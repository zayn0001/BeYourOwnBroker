import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:intl/intl.dart';

class AllCards extends ChangeNotifier {
  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  Future<void> fetchCardsFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('investments').get();

    _cards = snapshot.docs.map((doc) => CardModel.fromSnapshot(doc)).toList();
    notifyListeners();
  }
}

class CardModel extends ChangeNotifier {
  final String mfname;
  final double units;
  final double spent;
  final double currentValuation;
  double profit;

  //final String date;

  CardModel({
    required this.mfname,
    required this.units,
    required this.spent,
    required this.currentValuation,
    required this.profit,
    //required this.date
  });

  factory CardModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    var currval = 500000000.0;
    var profit = currval - data['spent'];
    return CardModel(
      mfname: data['mfname'],
      units: data['units'].toDouble(),
      spent: data['spent'].toDouble(),
      currentValuation: currval.toDouble(),
      profit: profit.toDouble(),
      //date: _extractDate(data['date'])
    );
  }
}
/**
String _extractDate(Timestamp timestamp) {
  // Convert Timestamp to DateTime
  DateTime dateTime = timestamp.toDate();

  // Format DateTime to get the date part
  String formattedDate = DateFormat.yMMMMd().format(dateTime);

  return formattedDate;
}
 */
