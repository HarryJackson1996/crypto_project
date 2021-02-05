import 'package:crytpo_project/clients/crypto_client.dart';
import 'package:crytpo_project/models/crypto.dart';
import 'package:flutter/material.dart';

class CryptoRepository {
  final CryptoClient cryptoClient;

  CryptoRepository({@required this.cryptoClient}) : assert(cryptoClient != null);

  Future<List<Coin>> fetchCoins([int startIndex = 1, int limit = 10]) async {
    return await cryptoClient.fetchLastestCoinsFromApi(
      startIndex: startIndex,
      limit: limit,
    );
  }
}
