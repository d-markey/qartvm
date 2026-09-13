abstract class CacheEntryStat {
  String get key;
  Duration get totalBuildTime;
  int get lastUsed;
  int get reused;
  int get evicted;
  bool get active;

  int get built => active ? (evicted + 1) : evicted;

  // the entry was built `evicted + 1` times if active, `evicted` times otherwise
  // it was also reused `reused` times
  int get totalUsed => built + reused;

  Duration get averageBuildTime => totalBuildTime ~/ built;
}
