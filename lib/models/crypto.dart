// To parse this JSON data, do
//
//     final crytpo = crytpoFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'coin.dart';

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
