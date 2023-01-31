import 'dart:convert';
import 'dart:developer';

import 'package:currencyconverter/userresponse.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserResponse userResponse = UserResponse();
  var fromItems = [
    "USD",
    "EUR",
    "GBP",
    "AUD",
    'CAD',
    "CHF",
    "INR",
  ];
  String dropValue = "INR";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUiResponse();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          color: Color(0xffaccbff),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h / 2.8,
              width: w / 1.2,
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 2, color: Colors.black12)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ro(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       height: h / 15,
                  //       width: w / 1.4,
                  //       child: DropdownButton(
                  //           elevation: 10,
                  //           dropdownColor: Colors.black12,
                  //           focusColor: Colors.black12,
                  //           items: fromItems.map((String items) {
                  //             return DropdownMenuItem(
                  //               value: items,
                  //               child: Text(items),
                  //             );
                  //           }).toList(),
                  //           value: dropValue,
                  //           onChanged: (val) {
                  //             setState(() {
                  //               dropValue = val!;
                  //             });
                  //           }),
                  //     )
                  //   ],
                  // )
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: fromItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: dropValue,
                      onChanged: (value) {
                        setState(() {
                          dropValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUiResponse() async {
    var url = Uri.parse(
        'https://api.apilayer.com/exchangerates_data/convert?to=USD&from=INR&amount=10&apikey=5Dfc0Mrucxy1IfUgeSq40P5UtPUuRo3K');
    var response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        userResponse = UserResponse.fromJson(json.decode(response.body));
      } else {
        print("Data Not Found !");
      }
      return userResponse;
    } catch (e) {
      log(e.toString());
    }
  }
}
