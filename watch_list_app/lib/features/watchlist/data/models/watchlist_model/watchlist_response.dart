import 'package:json_annotation/json_annotation.dart';

part 'watchlist_response.g.dart';


@JsonSerializable()
class WatchlistResponse {
  @JsonKey(name: 'watchLists')
  final List<WatchList> watchLists;

  WatchlistResponse({
    required this.watchLists,
  });

  factory WatchlistResponse.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class WatchList {
  @JsonKey(name: 'watchListName')
   String? watchListName;

  @JsonKey(name: 'watchListId')
  final String? watchListId;

  @JsonKey(name: 'symbols')
   List<SymbolDetails>? symbolsList;

  @JsonKey(name: 'predefined')
  final bool predefined;

  WatchList({
    required this.watchListName,
    this.watchListId,
    required this.symbolsList,
    required this.predefined,
  });

  factory WatchList.fromJson(Map<String, dynamic> json) =>
      _$WatchListFromJson(json);

  Map<String, dynamic> toJson() => _$WatchListToJson(this);
}

@JsonSerializable()
class SymbolDetails {
  @JsonKey(name: 'symbol')
  final String? symbol;

  @JsonKey(name: 'dispSym')
  final String? dispSym;

  @JsonKey(name: 'instrument')
  final String? instrument;

  @JsonKey(name: 'baseSym')
  final String? baseSym;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'isin')
  final String? isin;

  @JsonKey(name: 'exc')
  final String? exc;

  @JsonKey(name: 'excTkn')
  final dynamic excTkn;

  @JsonKey(name: 'series')
  final String? series;

  @JsonKey(name: 'lotSize')
  final int? lotSize;

  @JsonKey(name: 'tickSize')
  final String? tickSize;

  @JsonKey(name: 'expiryDate')
  final String? expiryDate;

  @JsonKey(name: 'optionType')
  final String? optionType;

  @JsonKey(name: 'strikePrice')
  final dynamic strikePrice;

  @JsonKey(name: 'streamSym')
  final String? streamSym;

  @JsonKey(name: 'segment')
  final String? segment;

  @JsonKey(name: 'fno')
  final bool? fno;

  @JsonKey(name: 'mtf')
  final bool? mtf;

  @JsonKey(name: 'multiplier')
  final dynamic multiplier;

  @JsonKey(name: 'freezeQty')
  final dynamic freezeQty;

  @JsonKey(name: 'tradingSymbol')
  final String? tradingSymbol;

  @JsonKey(name: 'otherExc')
  final dynamic otherExc;

  @JsonKey(name: 'isWeeklyExpiry')
  final dynamic isWeeklyExpiry;

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
    this.otherExc,
    this.isWeeklyExpiry,
  });

  factory SymbolDetails.fromJson(Map<String, dynamic> json) => _$SymbolDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SymbolDetailsToJson(this);
}