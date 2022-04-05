import 'homePage.dart';
import 'package:flutter/material.dart';

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
        title: const Text(("DATA"),),
        centerTitle: true,
      ),
      body: Container(
        child: const Center(
          child: Text("HELLO!"),
        ),
      )
      );
  }
}
