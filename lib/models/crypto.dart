// To parse this JSON data, do
//
//     final crytpo = crytpoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Crytpo crytpoFromJson(String str) => Crytpo.fromJson(json.decode(str));

String crytpoToJson(Crytpo data) => json.encode(data.toJson());

class Crytpo extends Equatable {
  final List<Coin> data;
  final Status status;

  Crytpo({
    this.data,
    this.status,
  });

  factory Crytpo.fromJson(Map<String, dynamic> json) => Crytpo(
        data: List<Coin>.from(json["data"].map((x) => Coin.fromJson(x))),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status.toJson(),
      };

  @override
  List<Object> get props => [data, status];
}

class Coin extends Equatable {
  Coin({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.cmcRank,
    this.numMarketPairs,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.lastUpdated,
    this.dateAdded,
    this.tags,
    this.platform,
    this.quote,
  });

  int id;
  String name;
  String symbol;
  String slug;
  int cmcRank;
  int numMarketPairs;
  double circulatingSupply;
  double totalSupply;
  double maxSupply;
  DateTime lastUpdated;
  DateTime dateAdded;
  List<String> tags;
  dynamic platform;
  Map<String, Quote> quote;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        cmcRank: json["cmc_rank"],
        numMarketPairs: json["num_market_pairs"],
        circulatingSupply: json["circulating_supply"].toDouble(),
        totalSupply: json["total_supply"].toDouble(),
        maxSupply: json["max_supply"] != null ? json["max_supply"].toDouble() : null,
        lastUpdated: DateTime.parse(json["last_updated"]),
        dateAdded: DateTime.parse(json["date_added"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        platform: json["platform"],
        quote: Map.from(json["quote"]).map((k, v) => MapEntry<String, Quote>(k, Quote.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "cmc_rank": cmcRank,
        "num_market_pairs": numMarketPairs,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "last_updated": lastUpdated.toIso8601String(),
        "date_added": dateAdded.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "platform": platform,
        "quote": Map.from(quote).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };

  @override
  List<Object> get props => [
        id,
        name,
        symbol,
        slug,
        cmcRank,
        numMarketPairs,
        circulatingSupply,
        totalSupply,
        maxSupply,
        lastUpdated,
        dateAdded,
        platform,
        quote,
      ];
}

class Quote {
  Quote({
    this.price,
    this.volume24H,
    this.percentChange1H,
    this.percentChange24H,
    this.percentChange7D,
    this.marketCap,
    this.lastUpdated,
  });

  double price;
  double volume24H;
  double percentChange1H;
  double percentChange24H;
  double percentChange7D;
  double marketCap;
  DateTime lastUpdated;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        price: json["price"].toDouble(),
        volume24H: json["volume_24h"].toDouble(),
        percentChange1H: json["percent_change_1h"].toDouble(),
        percentChange24H: json["percent_change_24h"].toDouble(),
        percentChange7D: json["percent_change_7d"].toDouble(),
        marketCap: json["market_cap"].toDouble(),
        lastUpdated: DateTime.parse(json["last_updated"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "volume_24h": volume24H,
        "percent_change_1h": percentChange1H,
        "percent_change_24h": percentChange24H,
        "percent_change_7d": percentChange7D,
        "market_cap": marketCap,
        "last_updated": lastUpdated.toIso8601String(),
      };
}

class Status {
  Status({
    this.timestamp,
    this.errorCode,
    this.errorMessage,
    this.elapsed,
    this.creditCount,
  });

  DateTime timestamp;
  int errorCode;
  String errorMessage;
  int elapsed;
  int creditCount;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: DateTime.parse(json["timestamp"]),
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        elapsed: json["elapsed"],
        creditCount: json["credit_count"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toIso8601String(),
        "error_code": errorCode,
        "error_message": errorMessage,
        "elapsed": elapsed,
        "credit_count": creditCount,
      };
}
