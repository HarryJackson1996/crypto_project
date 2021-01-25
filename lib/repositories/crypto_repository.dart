import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/models/coin.dart';
import 'package:flutter/material.dart';

class CryptoRepository {
  final CryptoClient cryptoClient;

  CryptoRepository({@required this.cryptoClient})
      : assert(cryptoClient != null);

  Future<List<Coin>> fetchCoins() async {
    return await cryptoClient.fetchLastestCoinsFromApi();
  }
}
