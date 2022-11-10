import 'package:flutter/material.dart';
import 'package:stock_exchange_data_via_api/models/stock_data.dart';
import 'package:stock_exchange_data_via_api/services/api_call.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          ("DATA"),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<StockData?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.count,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text("${snapshot.data!.results![index].t}")),
                  );
                },);
          } else {
            return const ScaffoldMessenger(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Scan card again.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
