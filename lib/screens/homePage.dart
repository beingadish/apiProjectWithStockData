import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class StockData {
  late final String c;
  late final String t;
  late final String o;
  late final String h;
  late final String l;
  late final String n;
  late final String v;
  late final String vw;

  StockData(this.c, this.t, this.o, this.h, this.l, this.n, this.v, this.vw);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _equity;
  var _fromDate;
  var _toDate;
  var rawdata = "";

  final _validationKey = GlobalKey<FormState>();

  Future<List<StockData>> _getData(
      String equity, String fDate, String tDate) async {
    var data = await get(
      Uri.parse(
          'https://api.polygon.io/v2/aggs/ticker/$equity/range/1/minute/$fDate/$tDate?apiKey=zMcpUX4RjUks2ncqOoXdBHXUck_WFeGK'),
    );

    var mainData = data.body;
    rawdata = mainData;
    var decodedData = jsonDecode(mainData);

    List<StockData> stocks = [];

    for (var u in decodedData["results"]) {
      StockData stock = StockData(
          u["c"], u["o"], u["h"], u["l"], u["n"], u["t"], u["v"], u["vw"]);
      stocks.add(stock);
    }
    //print(stocks.length.toString());
    return stocks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("StockRates API Data App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Form(
              key: _validationKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (_equity) {
                      if (_equity!.isEmpty) {
                        return "Please enter the name of EQUITY!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Equity',
                        hintText: 'for ex : AAPL,AMZN,MSFT,GOOG,GOOGL,etc...'),
                    onChanged: (value) {
                      setState(() {
                        _equity = value;
                      });
                    },
                  ),
                  TextFormField(
                    validator: (frmDate) {
                      if (frmDate!.isEmpty) {
                        return "Please enter the date!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'From Date',
                        hintText: 'format : YYYY-MM-DD , for ex : 2020-02-22'),
                    onChanged: (value) {
                      setState(() {
                        _fromDate = value;
                      });
                    },
                  ),
                  TextFormField(
                    validator: (toDate) {
                      if (toDate!.isEmpty) {
                        return "Please enter date!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'To Date',
                        hintText: 'format : YYYY-MM-DD , for ex : 2021-04-25'),
                    onChanged: (value) {
                      setState(() {
                        _toDate = value.toString();
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300.0,
              height: 40.0,
              child: ElevatedButton(
                autofocus: true,
                onPressed: () {
                  if (_validationKey.currentState!.validate()) {
                    setState(() {
                      _getData(_equity, _fromDate, _toDate);
                    });
                    // Navigator.pushNamed(context, Routes.dataScreen);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "VIEW RESULT",
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    minimumSize: const Size(60.0, 40.0),
                    elevation: 8.0,
                    animationDuration: const Duration(seconds: 1)),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Center(
            //   child: Text("Raw Data (will show below after clicking VIEW RESULT) : \n " + rawdata),
            // )
            Container(
              child: FutureBuilder(
                future: _getData(_equity, _fromDate, _toDate),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: const Center(
                        child: Text("Loading ..."),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(_equity),
                            // subtitle:,
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
