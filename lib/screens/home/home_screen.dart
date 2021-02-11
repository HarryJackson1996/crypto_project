import 'package:crytpo_project/blocs/tab_bloc/tab_bloc.dart';
import 'package:crytpo_project/blocs/tab_bloc/tab_event.dart';
import 'package:crytpo_project/consts/consts.dart';
import 'package:crytpo_project/models/app_tab.dart';
import 'package:crytpo_project/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:crytpo_project/blocs/bloc.dart';
import 'package:crytpo_project/repositories/repositories.dart';
import 'package:crytpo_project/widgets/coin_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  final CryptoRepository repository;

  HomeScreen({this.repository});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('crypto'),
            leading: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ),
          body: activeTab == AppTab.home ? CrytpoListScreen() : ThirdScreen(repository: repository),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppTab.values.indexOf(activeTab),
            onTap: (index) => BlocProvider.of<TabBloc>(context).add(TabUpdatedEvent(AppTab.values[index])),
            items: AppTab.values.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(
                  tab == AppTab.home ? Icons.list : Icons.show_chart,
                ),
                label: tab == AppTab.home ? '1' : '2',
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class CrytpoListScreen extends StatefulWidget {
  @override
  _CrytpoListScreenState createState() => _CrytpoListScreenState();
}

class _CrytpoListScreenState extends State<CrytpoListScreen> {
  Box<Coin> coinBox;
  final _scrollController = ScrollController();
  CryptoBloc _cryptoBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _cryptoBloc = context.read<CryptoBloc>();
    coinBox = Hive.box<Coin>(coinBookmarkBox);
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
                  ? Container()
                  : CoinTile(
                      coin: state.coins[index],
                      onPressed: () {
                        BlocProvider.of<CryptoBloc>(context).add(
                          CryptoUpdateEvent(
                            state.coins[index].copyWith(bookmarked: !state.coins[index].bookmarked),
                          ),
                        );
                      },
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
  final CryptoRepository repository;
  ThirdScreen({Key key, this.repository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoBloc, CryptoState>(
      builder: (context, state) {
        if (state is CryptoErrorState) {
          return Center(
            child: Text('error'),
          );
        }
        if (state is CryptoLoadedState) {
          if (state.coins.isEmpty) {
            return const Center(
              child: Text('no posts'),
            );
          }
          final coins = state.coins;
          print(coins);
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= coins.length || state.coins[index].bookmarked != true
                  ? Container()
                  : CoinTile(
                      coin: coins[index],
                      onPressed: () {
                        BlocProvider.of<CryptoBloc>(context).add(
                          CryptoUpdateEvent(
                            coins[index].copyWith(bookmarked: !coins[index].bookmarked),
                          ),
                        );
                      },
                    );
            },
            itemCount: state.limitReached ? state.coins.length : state.coins.length + 1,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
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
