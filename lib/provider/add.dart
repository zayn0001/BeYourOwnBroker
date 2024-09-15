import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddInvestment with ChangeNotifier {
  Future<void> addInvestment(Map<String, dynamic> form) async {
    try {
      await FirebaseFirestore.instance.collection('investments').add(form);
      notifyListeners();
    } catch (e) {
      return;
    }
  }
}
