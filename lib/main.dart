import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:crytpo_project/screens/home/home.dart';
import 'package:crytpo_project/widgets/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  Bloc.observer = SimpleBlocDelegate();
  final CryptoRepository repository = CryptoRepository(cryptoClient: CryptoClient(httpClient: http.Client()));
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CryptoRepository repository;

  MyApp({this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CryptoBloc>(
          create: (BuildContext context) => CryptoBloc(repository: repository)..add(FetchCryptoEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Crypto App',
        home: HomeScreen(repository: repository),
      ),
    );
  }
}
