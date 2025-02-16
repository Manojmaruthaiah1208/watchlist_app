// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


WatchlistResponse _$DataFromJson(Map<String, dynamic> json) => WatchlistResponse(
      watchLists: (json['watchLists'] as List<dynamic>)
          .map((e) => WatchList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(WatchlistResponse instance) => <String, dynamic>{
      'watchLists': instance.watchLists.map((e) => e.toJson()).toList(),
    };

WatchList _$WatchListFromJson(Map<String, dynamic> json) => WatchList(
      watchListName: json['watchListName'] as String,
      watchListId: json['watchListId'] as String?,
      symbolsList: (json['symbols'] as List<dynamic>)
          .map((e) => SymbolDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      predefined: json['predefined'] as bool,
    );

Map<String, dynamic> _$WatchListToJson(WatchList instance) => <String, dynamic>{
      'watchListName': instance.watchListName,
      'watchListId': instance.watchListId,
      'symbols': instance.symbolsList?.map((e) => e.toJson()).toList(),
      'predefined': instance.predefined,
    };

SymbolDetails _$SymbolDetailsFromJson(Map<String, dynamic> json) => SymbolDetails(
      symbol: json['symbol'] as String,
      dispSym: json['dispSym'] as String,
      instrument: json['instrument'] as String,
      baseSym: json['baseSym'] as String?,
      companyName: json['companyName'] as String?,
      isin: json['isin'] as String?,
      exc: json['exc'] as String,
      excTkn: json['excTkn'],
      series: json['series'] as String?,
      lotSize: json['lotSize'] as int,
      tickSize: json['tickSize'] as String?,
      expiryDate: json['expiryDate'] as String?,
      optionType: json['optionType'] as String?,
      strikePrice: json['strikePrice'],
      streamSym: json['streamSym'] as String,
      segment: json['segment'] as String?,
      fno: json['fno'] as bool,
      mtf: json['mtf'] as bool,
      multiplier: json['multiplier'],
      freezeQty: json['freezeQty'],
      tradingSymbol: json['tradingSymbol'] as String?,
      otherExc: json['otherExc'],
      isWeeklyExpiry: json['isWeeklyExpiry'],
    );

Map<String, dynamic> _$SymbolDetailsToJson(SymbolDetails instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'dispSym': instance.dispSym,
      'instrument': instance.instrument,
      'baseSym': instance.baseSym,
      'companyName': instance.companyName,
      'isin': instance.isin,
      'exc': instance.exc,
      'excTkn': instance.excTkn,
      'series': instance.series,
      'lotSize': instance.lotSize,
      'tickSize': instance.tickSize,
      'expiryDate': instance.expiryDate,
      'optionType': instance.optionType,
      'strikePrice': instance.strikePrice,
      'streamSym': instance.streamSym,
      'segment': instance.segment,
      'fno': instance.fno,
      'mtf': instance.mtf,
      'multiplier': instance.multiplier,
      'freezeQty': instance.freezeQty,
      'tradingSymbol': instance.tradingSymbol,
      'otherExc': instance.otherExc,
      'isWeeklyExpiry': instance.isWeeklyExpiry,
    };