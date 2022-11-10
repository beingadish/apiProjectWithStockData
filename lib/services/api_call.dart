import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/stock_data.dart';
import '../screens/homePage.dart';

String apiUrl =
    "https://api.polygon.io/v2/aggs/ticker/$equity/range/15/minute/$fDate/$tDate?apiKey=zMcpUX4RjUks2ncqOoXdBHXUck_WFeGK";

Future<StockData?> getData() async {
  final response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    if (kDebugMode) {
      log(response.body);
    }

    return StockData.fromJson(
      jsonDecode(response.body),
    );
  } else {
    if (kDebugMode) {
      log(
        response.statusCode.toString(),
      );
    }
  }
  return null;
}
