import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin/coinData.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform ;



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String rate;



  Future<dynamic> getdata(String coin) async {
    CoinData coinData = CoinData('https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=7937625D-6FE7-49F6-B69A-A493DEBF1371');
    var data = await coinData.getData();

    setState(() {
      rate = data.toStringAsFixed(2);
    });
    print(rate);
    return data;


  }

  @override
  void initState() {
    super.initState();
    Map<String, String> crip ={};
    for (String coin in cryptoList) {
        getdata(coin);
        crip[coin] = rate;
    }



  }

  String selectedCurrency = "USD";

  CupertinoPicker IOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
    },
      children: getPickItem(), );
  }

  DropdownButton<String> androidDropDown () {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropdown(),
      onChanged: (value) {
        for(String coin in cryptoList) {
          setState(() {
            getdata(coin);
          });

        }

        setState(() {
          selectedCurrency = value;
        });

      },
    );
  }

  List<DropdownMenuItem> getDropdown(){
    List<DropdownMenuItem<String>> dropdownitems = [];
    for(int i = 0; i< currenciesList.length; i++) {
      String Currency = currenciesList[i];
      var newItem = DropdownMenuItem(child: Text(Currency), value: Currency, );
      dropdownitems.add(newItem);

    }
    return dropdownitems;
  }

  List<Text> getPickItem(){
    List<Text> pickerItems = [];
    for(String curr in currenciesList) {
      pickerItems.add(Text(curr));
    }
    return pickerItems;
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return IOSPicker();
    }else if (Platform.isAndroid) {
      return androidDropDown();
    }
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(
                '1 BTC = $rate $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(
                '1 ETH = $rate $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),

            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(
                '1 LTC = $rate $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),

            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker()
          ),


        ],

      ),
    );
  }
}
