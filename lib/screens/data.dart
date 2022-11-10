import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_exchange_data_via_api/models/stock_data.dart';
import 'package:stock_exchange_data_via_api/services/api_call.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}




// String readTimestamp(int timestamp) {
//   var now = DateTime.now();
//   var format = DateFormat('HH:mm a');
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   var diff = now.difference(date);
//   var time = '';
//
//   if (diff.inSeconds <= 0 ||
//       diff.inSeconds > 0 && diff.inMinutes == 0 ||
//       diff.inMinutes > 0 && diff.inHours == 0 ||
//       diff.inHours > 0 && diff.inDays == 0) {
//     time = format.format(date);
//   } else if (diff.inDays > 0 && diff.inDays < 7) {
//     if (diff.inDays == 1) {
//       time = diff.inDays.toString() + ' DAY AGO';
//     } else {
//       time = diff.inDays.toString() + ' DAYS AGO';
//     }
//   } else {
//     if (diff.inDays == 7) {
//       time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
//     } else {
//       time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
//     }
//   }
//
//   return time;
// }




class _StockPageState extends State<StockPage> {

  late Future<StockData?> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = getData();
  }

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
        future: fetchData,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            // return ListView.builder(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 15.0,
            //   ),
            //   itemCount: snapshot.data!.resultsCount,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: ListTile(
            //         title: Text(
            //           DateTime.fromMillisecondsSinceEpoch(
            //             snapshot.data!.results![index].t!.toInt(),
            //           ).toString(),
            //         ),
            //       ),
            //     );
            //   },
            // );

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {

            // return const ScaffoldMessenger(
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: 8.0),
            //     child: Text(
            //       "Oops !! Try again.",
            //       style: TextStyle(fontSize: 18),
            //     ),
            //   ),
            // );

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              itemCount: snapshot.data!.resultsCount,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data!.results![index].t!.toInt(),
                      ).toString(),
                    ),
                  ),
                );
              },
            );
          } else {
            log(snapshot.data.toString());
            // return const Center(
            //   child: CircularProgressIndicator(
            //     color: Colors.black,
            //     backgroundColor: Colors.white,
            //   ),
            // );

            return const ScaffoldMessenger(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Oops !! Try again.",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
