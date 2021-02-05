import 'package:crytpo_project/models/models.dart';
import 'package:equatable/equatable.dart';

// enum CryptoStatus { initial, success, failure }

// class CryptoState extends Equatable {
//   final List<Coin> coins;
//   final bool limitReached;
//   final CryptoStatus status;

//   const CryptoState({
//     this.coins = const <Coin>[],
//     this.limitReached = false,
//     this.status = CryptoStatus.initial,
//   });

//   CryptoState copyWith({
//     CryptoStatus status,
//     List<Coin> coins,
//     bool hasReachedMax,
//   }) {
//     return CryptoState(
//       status: status ?? this.status,
//       coins: coins ?? this.coins,
//       limitReached: limitReached ?? this.limitReached,
//     );
//   }

//   @override
//   List<Object> get props => [coins, limitReached];
// }

abstract class CryptoState extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoEmptyState extends CryptoState {}

class CryptoLoadingState extends CryptoState {}

class CryptoLoadedState extends CryptoState {
  final List<Coin> coins;
  final bool limitReached;

  CryptoLoadedState({
    this.coins = const <Coin>[],
    this.limitReached,
  });

  CryptoState copyWith({
    List<Coin> coins,
    bool hasReachedMax,
  }) {
    return CryptoLoadedState(
      coins: coins ?? this.coins,
      limitReached: limitReached ?? this.limitReached,
    );
  }

  @override
  List<Object> get props => [coins, limitReached];
}

class CryptoErrorState extends CryptoState {}
