import 'package:crytpo_project/models/coin.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCryptoEvent extends CryptoEvent {}

class CryptoUpdateEvent extends CryptoEvent {
  final Coin coin;

  CryptoUpdateEvent(this.coin);

  @override
  List<Object> get props => [coin];
}

class CryptoRefreshEvent extends CryptoEvent {}
