
import '../watchlist_model/watchlist_response.dart';

class SearchDataModel {
  final List<SymbolDetails> symbols;

  SearchDataModel({required this.symbols});

  factory SearchDataModel.fromJson(Map<String, dynamic> json) {
    return SearchDataModel(
      symbols: (json['symbols'] as List)
          .map((item) => SymbolDetails.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbols': symbols.map((symbol) => symbol.toJson()).toList(),
    };
  }
}


