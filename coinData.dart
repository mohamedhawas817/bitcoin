import 'package:http/http.dart';
import 'dart:convert';

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
  CoinData(this.url);
  final String url;

  Future getData() async {
    Response response = await get(url);
    if(response.statusCode ==200) {
      String data = response.body;

      return jsonDecode(data)['rate'];
    }else {
      print(response.body);

    }
  }

}