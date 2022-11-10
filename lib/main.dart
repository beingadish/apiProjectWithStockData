import 'package:flutter/material.dart';
import 'screens/homePage.dart';
import 'screens/data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   brightness: Brightness.light,
      //   primaryColor: Colors.black,
      //   colorScheme: ColorScheme.fromSwatch().copyWith(
      //     secondary: Colors.black,
      //   ),
      //   splashColor: Colors.black,
      // ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/data': (context) => const StockPage(),
      },
    );
  }
}
