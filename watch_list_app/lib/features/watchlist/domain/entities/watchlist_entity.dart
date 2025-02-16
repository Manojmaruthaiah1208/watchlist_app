import 'package:equatable/equatable.dart';

class WatchlistEntity extends Equatable {
  final String id;
  final String name;
  final List<String> symbols;

  const WatchlistEntity({
    required this.id,
    required this.name,
    required this.symbols,
  });

  @override
  List<Object> get props => [id, name, symbols];
}
