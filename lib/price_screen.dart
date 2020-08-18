import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Widget getAndroidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    // String item;
    for (var item in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(item),
          value: item,
        ),
      );
    }
    DropdownButton dropdownButton = DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) async {
          setState(() async {
            selectedCurrency = value;
            getCoinData();
          });
        });
    return dropdownButton;
  }

  Widget getDropDownItemsCupertino() {
    List<Text> dropDownItemsCupertino = [];
    for (String item in currenciesList) {
      dropDownItemsCupertino.add(Text(
        item,
        style: TextStyle(color: Colors.white),
      ));
    }

    CupertinoPicker cupertinoPicker = CupertinoPicker(
      backgroundColor: Colors.blue[900],
      itemExtent: 32,
      onSelectedItemChanged: (value) async {
        setState(() {
          selectedCurrency = currenciesList[value];
          getCoinData();
        });
      },
      children: dropDownItemsCupertino,
    );
    return cupertinoPicker;
  }

  void getCoinData() async {
    double temp = await CoinData().getPrice(selectedCurrency);
    setState(() {
      priceToDisplay = temp.toStringAsFixed(0);
    });
  }

  String priceToDisplay = '0.0';
  String selectedCurrency = 'USD';
  @override
  void initState() {
    getCoinData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.blue[700],
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $priceToDisplay $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue[900],
            child: Platform.isIOS
                ? getDropDownItemsCupertino()
                : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
