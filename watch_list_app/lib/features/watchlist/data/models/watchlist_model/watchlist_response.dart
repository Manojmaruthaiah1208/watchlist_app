

class WatchListResponse {
  List<WatchList> watchLists;

  WatchListResponse({ required this.watchLists});

  factory WatchListResponse.fromJson(Map<String, dynamic> json) {
    return WatchListResponse(
      watchLists: (json['watchLists'] as List)
          .map((e) => WatchList.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'watchLists': watchLists.map((e) => e.toJson()).toList(),
    };
  }
}

class WatchList {
  String watchListName;
  List<SymbolDetails> symbols;
  bool predefined;

  WatchList({required this.watchListName, required this.symbols, required this.predefined});

  factory WatchList.fromJson(Map<String, dynamic> json) {
    return WatchList(
      watchListName: json['watchListName'],
      symbols: (json['symbols'] as List)
          .map((e) => SymbolDetails.fromJson(e))
          .toList(),
      predefined: json['predefined'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'watchListName': watchListName,
      'symbols': symbols.map((e) => e.toJson()).toList(),
      'predefined': predefined,
    };
  }
}

class SymbolDetails {
  String? symbol;
  String? dispSym;
  String? instrument;
  String? baseSym;
  String? companyName;
  String? isin;
  String? exc;
  int? excTkn;
  String? series;
  int? lotSize;
  String? tickSize;
  String? expiryDate;
  String? optionType;
  double? strikePrice;
  String? streamSym;
  String? segment;
  bool? fno;
  bool? mtf;
  double? multiplier;
  double? freezeQty;
  String? tradingSymbol;
  bool? isWeeklyExpiry;

  SymbolDetails({
     this.symbol,
     this.dispSym,
     this.instrument,
     this.baseSym,
     this.companyName,
     this.isin,
     this.exc,
     this.excTkn,
     this.series,
     this.lotSize,
     this.tickSize,
     this.expiryDate,
     this.optionType,
     this.strikePrice,
     this.streamSym,
     this.segment,
     this.fno,
     this.mtf,
     this.multiplier,
     this.freezeQty,
     this.tradingSymbol,
     this.isWeeklyExpiry,
  });

  factory SymbolDetails.fromJson(Map<String, dynamic> json) {
    return SymbolDetails(
      symbol: json['symbol'],
      dispSym: json['dispSym'],
      instrument: json['instrument'],
      baseSym: json['baseSym'],
      companyName: json['companyName'],
      isin: json['isin'],
      exc: json['exc'],
      excTkn: json['excTkn'],
      series: json['series'],
      lotSize: json['lotSize'],
      tickSize: json['tickSize'],
      expiryDate: json['expiryDate'],
      optionType: json['optionType'],
      strikePrice: json['strikePrice'],
      streamSym: json['streamSym'],
      segment: json['segment'],
      fno: json['fno'],
      mtf: json['mtf'],
      multiplier: json['multiplier'],
      freezeQty: json['freezeQty'],
      tradingSymbol: json['tradingSymbol'],
      isWeeklyExpiry: json['isWeeklyExpiry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'dispSym': dispSym,
      'instrument': instrument,
      'baseSym': baseSym,
      'companyName': companyName,
      'isin': isin,
      'exc': exc,
      'excTkn': excTkn,
      'series': series,
      'lotSize': lotSize,
      'tickSize': tickSize,
      'expiryDate': expiryDate,
      'optionType': optionType,
      'strikePrice': strikePrice,
      'streamSym': streamSym,
      'segment': segment,
      'fno': fno,
      'mtf': mtf,
      'multiplier': multiplier,
      'freezeQty': freezeQty,
      'tradingSymbol': tradingSymbol,
      'isWeeklyExpiry': isWeeklyExpiry,
    };
  }
}