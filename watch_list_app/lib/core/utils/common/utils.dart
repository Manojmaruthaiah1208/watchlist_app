
abstract class Utils {

  static bool isValidWatchlistName({
    required String watchlistName,
    required List<String> existingWatchlist,
    int maxLength = 16,
  }) {
    if (watchlistName.isEmpty) return false;

    if (watchlistName.length > maxLength) return false;

    if (existingWatchlist.contains(watchlistName)) return false;

    if (!watchlistName.contains(RegExp('[0-9a-zA-Z- ]'))) return false;

    return true;
  }
}
