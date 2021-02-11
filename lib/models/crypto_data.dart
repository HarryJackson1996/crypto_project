import 'dart:convert';
import 'package:hive/hive.dart';
import 'crypto.dart';

CryptoData crytpoDataFromJson(String str) => CryptoData.fromJson(json.decode(str));

String crytpoDataToJson(CryptoData data) => json.encode(data.toJson());

class CryptoData {
  CryptoData({
    this.data,
    this.status,
  });
  Map<String, Datum> data;
  Status status;

  factory CryptoData.fromJson(Map<String, dynamic> json) => CryptoData(
        data: Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "status": status.toJson(),
      };
}

class Datum {
  Datum({
    this.urls,
    this.logo,
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.description,
    this.dateAdded,
    this.tags,
    this.platform,
    this.category,
    this.notice,
  });
  Urls urls;
  String logo;
  int id;
  String name;
  String symbol;
  String slug;
  String description;
  DateTime dateAdded;
  List<String> tags;
  dynamic platform;
  String category;
  dynamic notice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        urls: Urls.fromJson(json["urls"]),
        logo: json["logo"],
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        description: json["description"],
        dateAdded: DateTime.parse(json["date_added"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        platform: json["platform"],
        category: json["category"],
        notice: json["notice"],
      );

  Map<String, dynamic> toJson() => {
        "urls": urls.toJson(),
        "logo": logo,
        "id": id,
        "name": name,
        "symbol": symbol,
        "slug": slug,
        "description": description,
        "date_added": dateAdded.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "platform": platform,
        "category": category,
        "notice": notice,
      };
}

class Urls {
  Urls({
    this.website,
    this.technicalDoc,
    this.twitter,
    this.reddit,
    this.messageBoard,
    this.announcement,
    this.chat,
    this.explorer,
    this.sourceCode,
  });
  List<String> website;
  List<String> technicalDoc;
  List<String> twitter;
  List<String> reddit;
  List<String> messageBoard;
  List<String> announcement;
  List<String> chat;
  List<String> explorer;
  List<String> sourceCode;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        website: List<String>.from(json["website"].map((x) => x)),
        technicalDoc: List<String>.from(json["technical_doc"].map((x) => x)),
        twitter: List<String>.from(json["twitter"].map((x) => x)),
        reddit: List<String>.from(json["reddit"].map((x) => x)),
        messageBoard: List<String>.from(json["message_board"].map((x) => x)),
        announcement: List<String>.from(json["announcement"].map((x) => x)),
        chat: List<String>.from(json["chat"].map((x) => x)),
        explorer: List<String>.from(json["explorer"].map((x) => x)),
        sourceCode: List<String>.from(json["source_code"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "website": List<dynamic>.from(website.map((x) => x)),
        "technical_doc": List<dynamic>.from(technicalDoc.map((x) => x)),
        "twitter": List<dynamic>.from(twitter.map((x) => x)),
        "reddit": List<dynamic>.from(reddit.map((x) => x)),
        "message_board": List<dynamic>.from(messageBoard.map((x) => x)),
        "announcement": List<dynamic>.from(announcement.map((x) => x)),
        "chat": List<dynamic>.from(chat.map((x) => x)),
        "explorer": List<dynamic>.from(explorer.map((x) => x)),
        "source_code": List<dynamic>.from(sourceCode.map((x) => x)),
      };
}
