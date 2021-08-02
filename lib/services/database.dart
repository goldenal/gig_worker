import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/models/user.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference gusers = FirebaseFirestore.instance.collection('GigUsers');
  CollectionReference userResponse = FirebaseFirestore.instance.collection('Response');
  User? user = FirebaseAuth.instance.currentUser;
  //User? user = FirebaseAuth.instance.currentUser;

  Future<String> createGig(String gigName, String amount, String location, String fromtimePeriod,
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
      return "success";
    } catch (e) {
      return(e.toString());
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

  Future<String> createResponses(String gigName, String userId) async {
    try {
      await firestore.collection("Response").add({
        'gigName': gigName,
        'gigApplicant': userId,
        'approved': '0'
      });
      return "success";
    } catch (e) {
      return(e.toString());
    }
  }

  Future<String> createResponse(String gigName, String userId) async{
    // FirebaseAu
    // userCredential.user[uid];
    try{
      await userResponse
          .doc(userId)
          .set({
        'gigName': gigName,
        'gigApplicant': userId,
        'approved': '0'
      });
      return "success";
    }catch(e){
      return(e.toString());
    }

  }


  // checks the data base if the current user is an admin
  // Future<bool> retrdata() async{
  //   try{
  //     await FirebaseFirestore.instance
  //         .collection('GigUsers')
  //         .doc(user!.uid)
  //         .get()
  //         .then((DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  //         return data['isAdmin'] == 1 ? true : false;
  //
  //       } else {
  //         print('Document does not exist on the database');
  //         return false;
  //       }
  //     });
  //   }
  //   catch(e){
  //     print(e.toString());
  //   }
  //
  //
  // }










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
