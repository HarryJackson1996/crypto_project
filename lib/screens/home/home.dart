import 'package:flutter/material.dart';
import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:crytpo_project/widgets/coin_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  final CryptoRepository repository;

  HomeScreen({this.repository});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SecondScreen(),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _scrollController = ScrollController();
  CryptoBloc _cryptoBloc;
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _cryptoBloc = context.read<CryptoBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(
      builder: (context, state) {
        if (state is CryptoEmptyState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CryptoErrorState) {
          return const Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is CryptoLoadedState) {
          if (state.coins.isEmpty) {
            return const Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.coins.length
                  ? BottomLoader()
                  : CoinTile(
                      coinName: state.coins[index].name,
                      coinValue: 200,
                    );
            },
            itemCount: state.limitReached ? state.coins.length : state.coins.length + 1,
            controller: _scrollController,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<CryptoBloc, CryptoState>(
  //     builder: (context, state) {
  //       switch (state.status) {
  //         case CryptoStatus.failure:
  //           return const Center(child: Text('failed to fetch posts'));
  //         case CryptoStatus.success:
  //           if (state.coins.isEmpty) {
  //             return const Center(child: Text('no posts'));
  //           }
  //           return ListView.builder(
  //             itemBuilder: (BuildContext context, int index) {
  //               return index >= state.coins.length
  //                   ? BottomLoader()
  //                   : CoinTile(
  //                       coinName: state.coins[index].name,
  //                       coinValue: 200,
  //                     );
  //             },
  //             itemCount: state.limitReached ? state.coins.length : state.coins.length + 1,
  //             controller: _scrollController,
  //           );
  //         default:
  //           return const Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottomOfScreen) _cryptoBloc.add(FetchCryptoEvent());
  }

  bool get _isBottomOfScreen {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, count) {
          var a = count;
          print(a);
          return Container(
            width: 1000,
            color: Colors.pinkAccent,
            child: Center(
              child: Text('count.coins[0].name'),
            ),
          );
        },
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
