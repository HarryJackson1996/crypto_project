import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

class CryptoDataBloc extends Bloc<CryptoDataEvent, CryptoDataState> {
  final CryptoRepository repository;

  CryptoDataBloc({@required this.repository})
      : assert(repository != null),
        super(CryptoDataEmptyState());

  @override
  Stream<Transition<CryptoDataEvent, CryptoDataState>> transformEvents(
    Stream<CryptoDataEvent> events,
    TransitionFunction<CryptoDataEvent, CryptoDataState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CryptoDataState> mapEventToState(CryptoDataEvent event) async* {
    final currentState = state;
    if (event is FetchCryptoDataEvent) {
      try {
        if (currentState is CryptoDataEmptyState) {
          yield CryptoDataLoadedState();
        }
        if (currentState is CryptoDataLoadedState) {
          yield CryptoDataLoadedState();
        }
      } catch (_) {
        yield CryptoDataErrorState();
      }
    }
  }
}
