import 'dart:async';

/// Polling policy for async generation runs per
/// docs/MOBILE_APP_GUIDE.md §9:
///   - 2s for the first 30s
///   - then 5s
///   - then 10s after 2 minutes
///   - stop when backgrounded, resume on foreground
///   - hard-stop after 30 minutes → "still running — check My Shorts"
///
/// Returns a self-managed loop. Use [stop] to cancel; [isPaused] gates
/// background/foreground. [onTick] receives the elapsed duration.
class PollPolicy {
  static const Duration initialInterval = Duration(seconds: 2);
  static const Duration midInterval = Duration(seconds: 5);
  static const Duration lateInterval = Duration(seconds: 10);
  static const Duration midThreshold = Duration(seconds: 30);
  static const Duration lateThreshold = Duration(minutes: 2);
  static const Duration maxTotal = Duration(minutes: 30);

  final Future<void> Function(Duration elapsed) onTick;

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isPaused = false;
  bool _stopped = false;
  Duration _pausedAt = Duration.zero;

  PollPolicy(this.onTick);

  Duration get elapsed => _elapsed;
  bool get isRunning => _timer != null && !_stopped;
  bool get isPaused => _isPaused;

  /// Starts the polling loop. Must be called from a foreground lifecycle.
  void start() {
    if (_timer != null || _stopped) return;
    _timer = Timer.periodic(initialInterval, (_) => _tick());
  }

  Future<void> _tick() async {
    if (_isPaused || _stopped) return;

    _elapsed += _intervalFor(_elapsed);

    if (_elapsed >= maxTotal) {
      stop();
      await onTick(_elapsed);
      return;
    }

    await onTick(_elapsed);
    // Reschedule with the interval appropriate for the new elapsed time.
    _timer?.cancel();
    _timer = Timer.periodic(_intervalFor(_elapsed), (_) => _tick());
  }

  /// Interval for a given elapsed time per the doc policy.
  Duration _intervalFor(Duration elapsed) {
    if (elapsed < midThreshold) return initialInterval;
    if (elapsed < lateThreshold) return midInterval;
    return lateInterval;
  }

  /// Pause polling (e.g. app backgrounded).
  void pause() {
    if (_isPaused) return;
    _isPaused = true;
    _pausedAt = _elapsed;
  }

  /// Resume polling after foregrounding.
  void resume() {
    if (!_isPaused) return;
    _isPaused = false;
    _elapsed = _pausedAt;
  }

  /// Hard-stop the loop. Safe to call multiple times.
  void stop() {
    _stopped = true;
    _timer?.cancel();
    _timer = null;
  }
}

/// Convenience for "poll until done" flows. Runs [tick] on the policy clock and
/// stops when [isDone] returns true. [onExhausted] is called after 30 minutes.
Future<void> pollUntil({
  required Future<void> Function() tick,
  required bool Function() isDone,
  Future<void> Function()? onExhausted,
}) async {
  final completer = Completer<void>();
  late final PollPolicy policy;

  policy = PollPolicy((_) async {
    await tick();
    if (isDone()) {
      policy.stop();
      if (!completer.isCompleted) completer.complete();
    } else if (policy.elapsed >= PollPolicy.maxTotal) {
      await onExhausted?.call();
      if (!completer.isCompleted) completer.complete();
    }
  });

  policy.start();
  await completer.future;
}
