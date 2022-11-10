import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stock_exchange_data_via_api/models/stock_data.dart';

import '../utils/myRoutes.dart';

String? equity;
String? fDate;
String? tDate;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _toDate = TextEditingController();
  final TextEditingController _fromDate = TextEditingController();

  @override
  void initState() {
    _fromDate.text = "";
    _toDate.text = "";
    super.initState();
    initializeDateFormatting();
  }

  final _validationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              title: const Text(
                'Are you sure?',
              ),
              content: const Text(
                'Do you want to exit?',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'NO',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text(
                    'YES',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                )
              ],
            );
          },
        );
      }),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("StockRates API Data App"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          hintText:
                              'for ex : AAPL,AMZN,MSFT,GOOG,GOOGL,etc...'),
                      onChanged: (value) {
                        setState(
                          () {
                            equity = value;
                          },
                        );
                      },
                    ),
                    TextFormField(
                      validator: (fromDate) {
                        if (fromDate!.isEmpty) {
                          return "Please enter the date!";
                        }
                        return null;
                      },
                      controller: _fromDate,
                      decoration: InputDecoration(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Enter From Date"),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                        iconColor: Colors.black,
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        // labelText: "Enter From Date",
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      onPrimary: Colors.black,
                                      // selected text color
                                      onSurface: Colors.blue,
                                      // default text color
                                      primary: Colors.blue // circle color
                                      ),
                                  dialogBackgroundColor: Colors.black,
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                      textStyle: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          fontFamily: 'Quicksand'),
                                      // color of button's letters
                                      backgroundColor: Colors.black54,
                                      // Background color
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          if (kDebugMode) {
                            print("Picked date : $pickedDate");
                          }

                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          fDate = formattedDate;

                          if (kDebugMode) {
                            print("Formatted Date : $formattedDate");
                          }

                          setState(
                            () {
                              _fromDate.text = fDate!;
                            },
                          );
                        }
                      },
                    ),
                    TextFormField(
                      cursorColor: Colors.black,
                      validator: (toDate) {
                        if (toDate!.isEmpty) {
                          return "Please enter the date!";
                        }
                        return null;
                      },
                      controller: _toDate,
                      decoration: InputDecoration(
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Enter To Date"),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      onPrimary: Colors.black,
                                      // selected text color
                                      onSurface: Colors.blue,
                                      // default text color
                                      primary: Colors.blue // circle color
                                      ),
                                  dialogBackgroundColor: Colors.black,
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.blue,
                                      textStyle: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          fontFamily: 'Quicksand'),
                                      // color of button's letters
                                      backgroundColor: Colors.black54,
                                      // Background color
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          if (kDebugMode) {
                            print(pickedDate);
                          }

                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);

                          tDate = formattedDate;

                          if (kDebugMode) {
                            print(formattedDate);
                          }

                          setState(
                            () {
                              _toDate.text = tDate!;
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    if (_validationKey.currentState!.validate()) {
                      Navigator.pushNamed(context, Routes.dataScreen);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "VIEW RESULT",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(60.0, 40.0),
                    elevation: 8.0,
                    animationDuration: const Duration(
                      seconds: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
