import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local cache for research results per docs/MOBILE_APP_GUIDE.md §5.9 —
/// "Cache results locally; this is the most-used offline surface."
///
/// Results are stored keyed by `toolKey:query` so they survive app restarts
/// and are available with no connection.
class ResearchCache {
  static const _prefix = 'research_cache_v1:';

  final SharedPreferences _prefs;
  ResearchCache(this._prefs);

  Future<void> put(
    String toolKey,
    String query,
    List<Map<String, dynamic>> results,
  ) async {
    final key = _key(toolKey, query);
    await _prefs.setString(
      key,
      jsonEncode({'tool': toolKey, 'query': query, 'results': results}),
    );
  }

  List<Map<String, dynamic>>? get(String toolKey, String query) {
    final raw = _prefs.getString(_key(toolKey, query));
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return null;
    final results = decoded['results'];
    if (results is! List) return null;
    return results.cast<Map<String, dynamic>>();
  }

  String _key(String toolKey, String query) => '$_prefix$toolKey::$query';
}

final researchCacheProvider = FutureProvider<ResearchCache>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return ResearchCache(prefs);
});
