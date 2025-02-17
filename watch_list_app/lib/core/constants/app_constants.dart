
sealed class AppConstants {
  static const String watchListAapp = 'WatchList App';
  static const String homeScreen = 'Home Screen';
  static const String settingsScreen = 'Settings Screen';
  static const String home = 'Home';
  static const String watchList = 'WatchList';
  static const String settings = 'Settings';
  static const String searchForSym = 'Search for symbols';
  
  static const String rupeeSymbol = '\u20B9';
  static const String oops = 'oops';
  static const String retry = 'retry';
  static const String sort = 'sort';
  static const String noData = 'No data available';
  static const String editWatchlist = 'Edit Watchlist';
  static const String delete = 'delete';
  static const String alreadyWatchlistExistError = 'Already Exist Watchlist';
  static const String emptyWatchlistError = 'Watchlist is empty';
  static const String watchListHelperText = 'Watchlist help';
  static const String save = 'save';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String exit = 'Exit';
  static const String withoutSavingMsg = 'We are identified some changes on this watchlist , are you sure to save the changes';
  static const String continueText = 'Continue';
  static const String cancel = 'Cancel';
  static const String deleteWatchlist = 'Delete Watchlist';
  static const String manageWatchlist = 'Mange WatchList';
  static const String addWatchlist = 'add WatchList';
  static const String enterWatchlistName = 'Enter watchlist name';
  static const String modify = 'Modify';
  static const String search = 'Search & add';
  static const String Search = 'Search Symbols';

  static const int WatchListLimit = 10;
  static final watchListRegExp = RegExp('[0-9a-zA-Z- ]');

}
