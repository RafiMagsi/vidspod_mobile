/// Upload policy per docs/MOBILE_APP_GUIDE.md §8.
///
/// The server rejects anything over 10 MB, so mobile hard-fails client-side
/// with a clear message before uploading (never queue a credit-costing job
/// that cannot complete).
class UploadPolicy {
  static const int maxBytes =
      10 * 1024 * 1024; // 10 MB (max:10240 KB server-side)

  /// Returns null if [bytes] is acceptable, else a human-readable reason.
  static String? validateSize(int bytes) {
    if (bytes > maxBytes) {
      final mb = bytes / (1024 * 1024);
      return 'File is ${mb.toStringAsFixed(1)} MB — the limit is 10 MB. '
          'Please pick a smaller photo.';
    }
    return null;
  }
}
