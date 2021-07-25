import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> create(String gigName, String amount, String location, String fromtimePeriod, String totimePeriod) async {
    try {
      await firestore.collection("Gigs").add({
        'gigName': gigName,
        'amount': amount,
        'location': location,
        'fromtimePeriod': fromtimePeriod,
        'totimePeriod': totimePeriod,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("Gigs").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  // Future<List> read() async {
    // FirebaseFirestore? _instance;
    // _instance = FirebaseFirestore.instance;
    // final gigcollection = _instance.collection('Gigs').get();




  //   QuerySnapshot querySnapshot;
  //   List gigsDoc = [];
  //   try {
  //     print('tried querying');
  //     querySnapshot =
  //     await firestore.collection('Gigs').get();
  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (var doc in querySnapshot.docs.toList()) {
  //         Map a = {"id": doc.id,
  //           "gigName": doc['name'],
  //           'amount':  doc['amount'],
  //           'location':  doc['location'],
  //           'fromtimePeriod':  doc['fromtimePeriod'],
  //           'totimePeriod':  doc['totimePeriod'],
  //         };
  //
  //
  //         gigsDoc.add(a);
  //       }
  //
  //       return gigsDoc;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return gigsDoc;
  // }

  // Future<void> update(String id, String name, String code) async {
  //   try {
  //     await firestore
  //         .collection("countries")
  //         .doc(id)
  //         .update({'name': name, 'code': code});
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
