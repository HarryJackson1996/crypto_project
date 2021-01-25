import 'dart:convert';
import 'package:crytpo_project/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoClient {
  static const apiKey = '1671043b-63c5-4521-9842-e138eb435c4d';
  static const String baseUrl = 'https://pro-api.coinmarketcap.com';
  // final http.Client httpClient;

  // CryptoClient({
  //   @required this.httpClient,
  // }) : assert(httpClient != null);

  Future<List<Coin>> fetchLastestCoinsFromApi({int start = 1, int limit = 20}) async {
    final String url = '$baseUrl/v1/cryptocurrency/listings/latest?start=$start&limit=$limit';
    try {
      final response = await http.get(url, headers: {"X-CMC_PRO_API_KEY": apiKey});
      final json = Crytpo.fromJson(jsonDecode(response.body));
      List<Coin> coins = json.data;
      var a = json;
    } catch (e) {
      print(e);
    }
  }
}