import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";

class FirestoreService {
  final investments = FirebaseFirestore.instance.collection("investments");

  Stream<QuerySnapshot> getnotestream() {
    final inv = investments.snapshots();
    return inv;
  }
}
