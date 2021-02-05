import 'package:crytpo_project/blocs/crypto_state.dart';
import 'package:crytpo_project/models/crypto.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'package:rxdart/rxdart.dart';

const _coinLimit = 20;

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository repository;

  CryptoBloc({@required this.repository})
      : assert(repository != null),
        super(CryptoEmptyState());

  @override
  Stream<Transition<CryptoEvent, CryptoState>> transformEvents(
    Stream<CryptoEvent> events,
    TransitionFunction<CryptoEvent, CryptoState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    final currentState = state;
    if (event is FetchCryptoEvent) {
      try {
        if (currentState is CryptoEmptyState) {
          final coins = await repository.fetchCoins();
          yield CryptoLoadedState(coins: coins, limitReached: false);
          return;
        }
        if (currentState is CryptoLoadedState) {
          final coins = await repository.fetchCoins(currentState.coins.length + 1);
          yield CryptoLoadedState(
            coins: currentState.coins + coins,
            limitReached: false,
          );
        }
      } catch (_) {
        yield CryptoErrorState();
      }
    }
    // if (event is FetchCryptoEvent) {
    //   yield* _doFetch(event);
    //   // yield await _mapPostFetchedToState(state);
    // }
  }

  Future<CryptoState> _mapPostFetchedToState(CryptoState state) async {
    // if (state.limitReached) return state;
    // try {
    //   if (state.status == CryptoStatus.initial) {
    //     final coins = await repository.fetchCoins();
    //     return state.copyWith(
    //       status: CryptoStatus.success,
    //       coins: coins,
    //       hasReachedMax: _limitReached(coins.length),
    //     );
    //   }
    //   final coins = await repository.fetchCoins(state.coins.length + 1);
    //   return coins.isEmpty
    //       ? state.copyWith(hasReachedMax: true)
    //       : state.copyWith(
    //           status: CryptoStatus.success,
    //           coins: List.of(state.coins)..addAll(coins),
    //           hasReachedMax: _limitReached(coins.length),
    //         );
    // } on Exception {
    //   return state.copyWith(status: CryptoStatus.failure);
    // }
  }

  bool _limitReached(int coinCount) => coinCount <= _coinLimit ? false : true;
}
