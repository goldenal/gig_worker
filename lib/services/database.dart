import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/models/user.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference gusers = FirebaseFirestore.instance.collection('GigUsers');
 // User? user = FirebaseAuth.instance.currentUser;

  Future<void> createGig(String gigName, String amount, String location, String fromtimePeriod,
      String totimePeriod, String details) async {
    try {
      await firestore.collection("Gigs").add({
        'gigName': gigName,
        'amount': amount,
        'location': location,
        'fromtimePeriod': fromtimePeriod,
        'totimePeriod': totimePeriod,
        'timestamp': FieldValue.serverTimestamp(),
        'details' : details
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
  Future<void> addUser(UserCredential userCredential) {
    // FirebaseAu
    // userCredential.user[uid];
    return gusers
        .doc(userCredential.user!.uid)
        .set({
      'age': 18,
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'firstName': 'new user',
      'lastName': ' ',
      'sex' : ' ',
      'phone': '0',
      'isAdmin': 0,
      'isVerified': 0,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
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
