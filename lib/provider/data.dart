import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:micetalks/provider/constants.dart" as constants;
//import 'package:intl/intl.dart';

class AllCards extends ChangeNotifier {
  final List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  Future<double> _fetchNav(String ticker) async {
    String apiUrl = constants.url + ticker;
    http.Response response = await http.get(Uri.parse(apiUrl));
    Map<String, dynamic> data = jsonDecode(response.body);
    var curnav = data['nav'];
    return curnav;
  }

  String _convertToIndianCurrencyFormat(double amount) {
    String amountStr = amount.toStringAsFixed(2);
    bool hasDecimal = amountStr.contains('.');
    List<String> parts = amountStr.split('.');
    String integerPart = parts[0];
    String decimalPart = hasDecimal ? '.${parts[1]}' : '';

    String formattedIntegerPart = '';

    for (int i = integerPart.length - 1, j = 0; i >= 0; i--, j++) {
      formattedIntegerPart = integerPart[i] + formattedIntegerPart;
      if (j != 0 && j % 2 == 0 && i != 0) {
        formattedIntegerPart = ',$formattedIntegerPart';
      }
    }

    String formattedAmount = formattedIntegerPart + decimalPart;
    return formattedAmount;
  }

  Future<void> fetchCardsFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('investments').get();
    for (var data in snapshot.docs) {
      var curnav = await _fetchNav(data["ticker"]);
      var curval = double.parse((curnav * data["units"]).toStringAsFixed(2));
      var profit = double.parse((curval - data["spent"]).toStringAsFixed(2));
      var cardModel = CardModel(
        mfname: data['mfname'],
        units: data['units'].toDouble(),
        spent: _convertToIndianCurrencyFormat(data['spent'].toDouble()),
        currentValuation: _convertToIndianCurrencyFormat(curval.toDouble()),
        profit: _convertToIndianCurrencyFormat(profit.toDouble()),
      );

      _cards.add(cardModel);
    }
    notifyListeners();
  }
}

class CardModel extends ChangeNotifier {
  final String mfname;
  final double units;
  final String spent;
  String currentValuation;
  String profit;

  CardModel({
    required this.mfname,
    required this.units,
    required this.spent,
    required this.currentValuation,
    required this.profit,
  });
}
