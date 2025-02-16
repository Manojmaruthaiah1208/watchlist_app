extension ObjectExt on Object? {
  bool get isNotNull => this != null;

  bool get isMapOfString => this is Map<String, dynamic>;
}
