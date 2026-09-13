import 'cache_entry_stat.dart';

class DisengageableCache<T extends Object> {
  final Map<String, _CacheEntry<T>>? _stats;
  final int maxEntries;

  DisengageableCache({this.maxEntries = 0, bool enabled = true})
    : _stats = enabled ? {} : null;

  bool get enabled => _stats != null;

  T? operator [](String key) => _stats?[key]?._data;

  Iterable<CacheEntryStat> get stats => _stats?.values ?? const [];

  T putIfAbsent(String key, T Function() builder) {
    if (_stats == null) return builder(); // no cache

    var m = _stats[key];
    if (m == null) {
      _evict();
      m = _stats[key] = _CacheEntry(key);
      return m.init(builder);
    } else if (!m.active) {
      _evict();
      return m.rebuild(builder);
    } else {
      return m.reuse();
    }
  }

  void _evict() {
    if (_stats == null) return;
    final active = _stats.values.where((s) => s.active).length;
    if (maxEntries <= 0 || active < maxEntries) return;

    final activeEntries = _stats.values
        .where((s) => s.active && s.reused == 0)
        .toList();
    if (activeEntries.isEmpty) {
      activeEntries.addAll(_stats.values.where((s) => s.active));
    }

    // eviction strategy is only based on how recently the entry was used
    // build time / total use should probably be taken into account
    // eg. first try to evict the oldest entry where reused == 0
    // but if all entries have been reused already, evict the least used one with the smallest average build time
    activeEntries.sort((a, b) => a.lastUsed.compareTo(b.lastUsed));
    activeEntries.first.evict();
  }
}

int _timestamp() => DateTime.now().millisecondsSinceEpoch;

class _CacheEntry<T extends Object> extends CacheEntryStat {
  _CacheEntry(this.key);

  @override
  final String key;

  int _totalBuildTime = 0;
  int _lastUsed = 0;
  int _reused = 0;
  int _evicted = 0;
  T? _data;

  @override
  Duration get totalBuildTime => Duration(milliseconds: _totalBuildTime);

  @override
  int get lastUsed => _lastUsed;

  @override
  int get reused => _reused;

  @override
  int get evicted => _evicted;

  @override
  bool get active => _data != null;

  T init(T Function() builder) {
    assert(_data == null);
    assert(_lastUsed == 0);
    assert(_reused == 0);
    assert(_evicted == 0);
    final sw = Stopwatch()..start();
    _data = builder();
    _lastUsed = _timestamp();
    _totalBuildTime += sw.elapsedMilliseconds;
    return _data!;
  }

  T reuse() {
    assert(_data != null);
    _reused++;
    _lastUsed = _timestamp();
    return _data!;
  }

  T rebuild(T Function() builder) {
    assert(_data == null);
    assert(_evicted > 0);
    final sw = Stopwatch()..start();
    _data = builder();
    _lastUsed = _timestamp();
    _totalBuildTime += sw.elapsedMilliseconds;
    return _data!;
  }

  void evict() {
    assert(_data != null);
    _data = null;
    _evicted++;
  }
}
