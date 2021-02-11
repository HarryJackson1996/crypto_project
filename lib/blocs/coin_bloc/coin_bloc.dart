import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/blocs/coin_bloc/coin_state.dart';
import 'package:crytpo_project/models/coin.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    if (event is CryptoUpdateEvent) {
      yield* _mapCryptoUpdatedToState(event);
    }
    if (event is FetchCryptoEvent) {
      try {
        if (currentState is CryptoEmptyState) {
          final coins = await repository.fetchCoins();
          if (coins.length > 0) {
            yield CryptoLoadedState(coins: coins, limitReached: false);
          }
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
  }

  Stream<CryptoState> _mapCryptoUpdatedToState(CryptoUpdateEvent event) async* {
    if (state is CryptoLoadedState) {
      final List<Coin> updatedCoins = (state as CryptoLoadedState).coins.map((coin) {
        return coin.name == event.coin.name ? event.coin : coin;
      }).toList();
      if (event.coin.bookmarked) {
        print('added');
        await repository.bookmarkCoin(event.coin);
      } else {
        print('removed');
        await repository.unbookmarkCoin(event.coin);
      }
      yield CryptoLoadedState(coins: updatedCoins, limitReached: false);
    }
  }

  bool _limitReached(int coinCount) => coinCount <= _coinLimit ? false : true;
}
