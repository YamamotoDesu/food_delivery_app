import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get ccollection of orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  // save order to firestore
  Future<void> saveOrder(String receipt) async {
    try {
      await orders.add({
        'date': DateTime.now(),
        'order': receipt,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
