import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String api_key = "ENTER_API_KEY";

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getPrice(String selectedCurrency) async {
    http.Response response = await http.get(
        'http://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$api_key');
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonDecodedData = jsonDecode(responseBody);
      return jsonDecodedData['rate'];
    } else {
      print('Price could not be fetched.');
      throw ('gePrice Problem');
    }
  }
}
