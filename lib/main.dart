import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/blocs/tab_bloc/tab_bloc.dart';
import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/consts/consts.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:crytpo_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/coin.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CoinAdapter());
  Hive.registerAdapter(QuoteAdapter());
  await Hive.openBox<Coin>(coinBookmarkBox);
  Bloc.observer = SimpleBlocDelegate();
  final CryptoRepository repository = CryptoRepository(
    cryptoClient: CryptoClient(
      httpClient: http.Client(),
    ),
    box: Hive.box<Coin>(coinBookmarkBox),
  );
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
          create: (BuildContext context) => CryptoBloc(repository: repository)
            ..add(
              FetchCryptoEvent(),
            ),
        ),
        BlocProvider<TabBloc>(create: (context) => TabBloc()),
      ],
      child: MaterialApp(
        title: 'Crypto App',
        home: HomeScreen(repository: repository),
      ),
    );
  }
}
