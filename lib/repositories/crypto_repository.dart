import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/models/coin.dart';
import 'package:crytpo_project/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CryptoRepository {
  final CryptoClient cryptoClient;
  final Box<Coin> box;

  CryptoRepository({
    @required this.cryptoClient,
    @required this.box,
  }) : assert(cryptoClient != null);

  Future<List<Coin>> fetchCoins([int startIndex = 1, int limit = 20]) async {
    List<Coin> myCoins = loadBookmarkedCoins();
    List<Coin> apiCoins = await cryptoClient.fetchCoinsFromApi(
      startIndex: startIndex,
      limit: limit,
    );

    if (myCoins.length > 0) {
      for (int i = 0; i < myCoins.length; i++) {
        for (int x = 0; x < apiCoins.length; x++) {
          if (myCoins[i].name == apiCoins[x].name) {
            apiCoins[x].bookmarked = true;
          }
        }
      }
    }
    return apiCoins;
  }

  Future<CryptoData> fetchCoinData(String coinName) async {
    return await cryptoClient.fetchCoinData(
      coinName: coinName,
    );
  }

  Future<void> bookmarkCoin(Coin coin) async {
    if (isBoxClosed) {
      return null;
    } else {
      await box.put(coin.name, coin);
    }
  }

  Future<void> unbookmarkCoin(Coin coin) async {
    if (isBoxClosed) {
      return null;
    } else {
      await box.delete(coin.name);
    }
  }

  List<Coin> loadBookmarkedCoins() {
    if (isBoxClosed) {
      return null;
    } else {
      List<Coin> coins = [];

      box.keys.forEach((element) {
        coins.add(box.get(element));
      });

      return coins;
    }
  }

  bool get isBoxClosed => !(this.box?.isOpen ?? false);
}
