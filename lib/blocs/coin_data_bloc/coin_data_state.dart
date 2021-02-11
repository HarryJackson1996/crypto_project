import 'package:equatable/equatable.dart';

abstract class CryptoDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoDataEmptyState extends CryptoDataState {}

class CryptoDataLoadedState extends CryptoDataState {}

class CryptoDataLoadingState extends CryptoDataState {}

class CryptoDataErrorState extends CryptoDataState {}
