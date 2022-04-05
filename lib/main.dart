import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/data.dart';
import 'package:stock_exchange_data_via_api/utils/myRoutes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => const HomePage(),
        '/data' : (context) => const StockPage(),
      },
    );
  }
}

