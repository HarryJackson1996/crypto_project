import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'coin.g.dart';

@HiveType(typeId: 0)
class Coin extends HiveObject {
  Coin({
    this.bookmarked,
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

  @HiveField(0)
  bool bookmarked;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String symbol;
  @HiveField(4)
  final String slug;
  @HiveField(5)
  final int cmcRank;
  @HiveField(6)
  final int numMarketPairs;
  @HiveField(7)
  final double circulatingSupply;
  @HiveField(8)
  final double totalSupply;
  @HiveField(9)
  final double maxSupply;
  @HiveField(10)
  final DateTime lastUpdated;
  @HiveField(11)
  final DateTime dateAdded;
  @HiveField(12)
  final List<String> tags;
  @HiveField(13)
  final dynamic platform;
  @HiveField(14)
  final Map<String, Quote> quote;

  Coin copyWith({
    bool bookmarked,
    int id,
    String name,
    String symbol,
    String slug,
    int cmcRank,
    int numMarketPairs,
    double circulatingSupply,
    double totalSupply,
    double maxSupply,
    DateTime lastUpdated,
    DateTime dateAdded,
    List<String> tags,
    dynamic platform,
    Map<String, Quote> quote,
  }) {
    return Coin(
      bookmarked: bookmarked ?? this.bookmarked,
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      slug: slug ?? this.slug,
      cmcRank: cmcRank ?? this.cmcRank,
      numMarketPairs: numMarketPairs ?? this.numMarketPairs,
      circulatingSupply: circulatingSupply ?? this.circulatingSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      maxSupply: maxSupply ?? this.maxSupply,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      dateAdded: dateAdded ?? this.dateAdded,
      tags: tags ?? this.tags,
      platform: platform ?? this.platform,
      quote: quote ?? this.quote,
    );
  }

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        bookmarked: json["bookmarked"] != null ? json["bookmarked"] : false,
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
        "bookmarked": bookmarked,
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
        bookmarked,
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

@HiveType(typeId: 1)
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
  @HiveField(0)
  double price;
  @HiveField(1)
  double volume24H;
  @HiveField(2)
  double percentChange1H;
  @HiveField(3)
  double percentChange24H;
  @HiveField(4)
  double percentChange7D;
  @HiveField(5)
  double marketCap;
  @HiveField(6)
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
