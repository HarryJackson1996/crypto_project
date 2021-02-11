import 'package:equatable/equatable.dart';

abstract class CryptoDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCryptoDataEvent extends CryptoDataEvent {}
