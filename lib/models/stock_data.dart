// To parse this JSON data, do
//
//     final stockData = stockDataFromJson(jsonString);

import 'dart:convert';

StockData stockDataFromJson(String str) => StockData.fromJson(json.decode(str));

String stockDataToJson(StockData data) => json.encode(data.toJson());

class StockData {
  StockData({
    required this.ticker,
    required this.queryCount,
    required this.resultsCount,
    required this.adjusted,
    required this.results,
    required this.status,
    required this.requestId,
    required this.count,
  });

  final String ticker;
  final int queryCount;
  final int resultsCount;
  final bool adjusted;
  final List<Result>? results;
  final String status;
  final String requestId;
  final int count;

  factory StockData.fromJson(Map<String, dynamic> json) => StockData(
    ticker: json["ticker"] == null ? null : json["ticker"],
    queryCount: json["queryCount"] == null ? null : json["queryCount"],
    resultsCount:
    json["resultsCount"] == null ? null : json["resultsCount"],
    adjusted: json["adjusted"] == null ? null : json["adjusted"],
    results: json["results"] == null
        ? null
        : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
    requestId: json["request_id"] == null ? null : json["request_id"],
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "ticker": ticker == null ? null : ticker,
    "queryCount": queryCount == null ? null : queryCount,
    "resultsCount": resultsCount == null ? null : resultsCount,
    "adjusted": adjusted == null ? null : adjusted,
    "results": results == null
        ? null
        : List<dynamic>.from(results!.map((x) => x.toJson())),
    "status": status == null ? null : status,
    "request_id": requestId == null ? null : requestId,
    "count": count == null ? null : count,
  };
}

class Result {
  Result({
    required this.vw,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.t,
    required this.n,
  });

  final double vw;
  final double o;
  final double c;
  final double h;
  final double l;
  final int t;
  final int n;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    vw: json["vw"] == null ? null : json["vw"].toDouble(),
    o: json["o"] == null ? null : json["o"].toDouble(),
    c: json["c"] == null ? null : json["c"].toDouble(),
    h: json["h"] == null ? null : json["h"].toDouble(),
    l: json["l"] == null ? null : json["l"].toDouble(),
    t: json["t"] ?? null,
    n: json["n"],
  );

  Map<String, dynamic> toJson() => {
    "vw": vw,
    "o": o,
    "c": c,
    "h": h,
    "l": l,
    "t": t,
    "n": n,
  };
}