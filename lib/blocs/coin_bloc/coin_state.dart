import 'package:crytpo_project/models/coin.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoState extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoEmptyState extends CryptoState {}

class CryptoLoadedState extends CryptoState {
  final List<Coin> coins;
  final bool limitReached;

  CryptoLoadedState({
    this.coins = const <Coin>[],
    this.limitReached,
  });

  @override
  List<Object> get props => [coins, limitReached];
}

class CryptoErrorState extends CryptoState {}
