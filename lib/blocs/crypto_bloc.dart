import 'package:crytpo_project/blocs/crypto_state.dart';
import 'package:crytpo_project/models/crypto.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository repository;

  CryptoBloc({@required this.repository}) : assert(repository != null);

  @override
  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if (event is FetchCrypto) {
      yield CryptoLoading();
    }
    if (event is CryptoRefreshEvent) {
      try {
        final List<Coin> crypto = await repository.fetchCoins();
        yield CryptoLoaded(crypto: crypto);
      } catch (_) {
        yield CryptoError();
      }
    }
    try {
      final List<Coin> crypto = await repository.fetchCoins();
      yield CryptoLoaded(crypto: crypto);
    } catch (_) {
      yield CryptoError();
    }
  }
}
