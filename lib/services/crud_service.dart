import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:micetalks/provider/data.dart';
import 'package:provider/provider.dart';

class CrudService {
  Future<void> createInvestment(
      BuildContext context, Map<String, dynamic> form) async {
    try {
      await FirebaseFirestore.instance
          .collection('investments')
          .add(form)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Investment Added Successfully')),
        );
        Provider.of<AllCards>(context, listen: false).fetchCardsFromFirestore();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add investment')),
        );
      });
    } catch (e) {
      // Handle any exceptions here if needed
      return;
    }
  }

  Future<void> incrementInvestment(
      BuildContext context, Map<String, dynamic> form) async {
    try {
      // Query Firestore for the document where 'mfname' matches
      final querySnapshot = await FirebaseFirestore.instance
          .collection('investments')
          .where('mfname', isEqualTo: form["mfname"])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference of the first matching document
        final docRef = querySnapshot.docs.first.reference;

        // Increment 'spent' and 'units' fields
        await docRef.update({
          'spent': FieldValue.increment(form["spent"]),
          'units': FieldValue.increment(form["units"]),
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Investment Updated Successfully')),
          );
          Provider.of<AllCards>(context, listen: false)
              .fetchCardsFromFirestore();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update investment')),
          );
        });
      }
    } catch (e) {
      return;
    }
  }

  Future<void> withdrawInvestment(
      BuildContext context, Map<String, dynamic> form) async {
    try {
      // Query Firestore for the document where 'mfname' matches
      final querySnapshot = await FirebaseFirestore.instance
          .collection('investments')
          .where('mfname', isEqualTo: form["mfname"])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference of the first matching document
        final docRef = querySnapshot.docs.first.reference;

        // Increment 'spent' and 'units' fields
        await docRef.update({
          'spent': FieldValue.increment(-form["spent"]),
          'units': FieldValue.increment(-form["units"]),
        }).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Investment Updated Successfully')),
          );
          Provider.of<AllCards>(context, listen: false)
              .fetchCardsFromFirestore();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update investment')),
          );
        });
      }
    } catch (e) {
      return;
    }
  }

  Future<void> deleteInvestment(
      BuildContext context, Map<String, dynamic> form) async {
    try {
      // Query Firestore for the document where 'mfname' matches
      final querySnapshot = await FirebaseFirestore.instance
          .collection('investments')
          .where('mfname', isEqualTo: form["mfname"])
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference of the first matching document
        final docRef = querySnapshot.docs.first.reference;

        // Delete the document
        await docRef.delete().then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Investment Deleted Successfully')),
          );
          Provider.of<AllCards>(context, listen: false)
              .fetchCardsFromFirestore(); // Refresh the UI after deletion
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete investment')),
          );
        });
      }
    } catch (e) {
      return;
    }
  }
}
