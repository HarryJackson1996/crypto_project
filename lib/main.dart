import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'models/crypto.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final CryptoRepository repository = CryptoRepository(cryptoClient: CryptoClient(httpClient: http.Client()));
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CryptoRepository repository;

  MyApp({this.repository}) : assert(repository != null);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crypto'),
        ),
        body: BlocProvider(
          create: (context) => CryptoBloc(repository: repository),
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(builder: (context, state) {
      if (state is CryptoEmpty) {
        BlocProvider.of<CryptoBloc>(context).add(FetchCrypto());
      }

      if (state is CryptoLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<CryptoBloc>(context).add(CryptoRefreshEvent());
          },
          child: ListView.builder(
            itemCount: state.crypto.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(state.crypto[index].quote['USD'].price.toString()),
              );
            },
          ),
        );
      }
      if (state is CryptoError) {
        return Center(child: Text('Failed to fetch crypto'));
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
