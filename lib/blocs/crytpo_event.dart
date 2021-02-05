import 'package:equatable/equatable.dart';

abstract class CryptoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCryptoEvent extends CryptoEvent {}

class CryptoRefreshEvent extends CryptoEvent {}
