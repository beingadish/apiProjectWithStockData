import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  var _range;
  var _equity;
  var _apikey;
  var _fDate;
  var _fMonth;
  var _fYear;
  var _tDate;
  var _tMonth;
  var _tYear;
}

class _HomePageState extends State<HomePage> {
  @override
  void generateData(int range, String equity, int fYear, int fMonth, int fDate,
      int tYear, int tMonth, int tDate) async {
    Response stockData = await get(
      Uri.parse(
          'https://api.polygon.io/v2/aggs/ticker/$equity/$range/1/minute/$fYear-$fMonth-$fDate/$tYear-$tMonth-$tDate?apiKey=zMcpUX4RjUks2ncqOoXdBHXUck_WFeGK'),
    );
    for (int i = 0; i < range; i++) {
      var mainData = stockData.body;
      var decodedData = jsonDecode(mainData)["results"][i];
      var epochTime = decodedData['t'];
      var date = DateTime.fromMillisecondsSinceEpoch(epochTime);
      var openRate = decodedData['o'];
      var closingRate = decodedData['c'];
      var highRate = decodedData['h'];
      var lowRate = decodedData['l'];
      var transactNumber = decodedData['n'];
      var volume = decodedData['v'];
    }
  }

  // Text mainData(){
  //   return Text(res)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StockRates API Data App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text("Lorem Ipsum"),
            // Text(data)
          ],
        ),
      ),
    );
  }
}
