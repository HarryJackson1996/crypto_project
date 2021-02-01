import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();
}

class FetchCrypto extends CryptoEvent {
  const FetchCrypto();

  @override
  List<Object> get props => [];
}

class CryptoRefreshEvent extends CryptoEvent {
  const CryptoRefreshEvent();

  @override
  List<Object> get props => [];
}
