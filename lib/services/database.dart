import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/models/user.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference gusers = FirebaseFirestore.instance.collection(
      'GigUsers');
  CollectionReference userResponse = FirebaseFirestore.instance.collection(
      'Response');
  User? user = FirebaseAuth.instance.currentUser;

  //User? user = FirebaseAuth.instance.currentUser;

  Future<String> createGig(String gigName, String amount, String location,
      String fromtimePeriod,
      String totimePeriod, String details) async {
    try {
      await firestore.collection("Gigs").add({
        'gigName': gigName,
        'amount': amount,
        'location': location,
        'fromtimePeriod': fromtimePeriod,
        'totimePeriod': totimePeriod,
        'timestamp': FieldValue.serverTimestamp(),
        'details': details
      });
      return "success";
    } catch (e) {
      return (e.toString());
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
      'sex': ' ',
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
      return (e.toString());
    }
  }

  Future<String> createResponse(String gigName, String userId,String firstname,
      String lastname,String phone,) async {
    // FirebaseAu
    // userCredential.user[uid];
    try {
      await userResponse
          .doc(userId)
          .set({
        'gigName': gigName,
        'gigApplicant': userId,
        'approved': '0',
        'lastname': lastname,
        'firstname': firstname,
        'phone': phone
      });
      return "success";
    } catch (e) {
      return (e.toString());
    }
  }


  // checks the data base if the current user is an admin
  void retrdata() {
    FirebaseFirestore.instance
        .collection('GigUsers')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<
            String,
            dynamic>;
        // return data['isAdmin'] == 1 ? true : false;

      } else {
        print('Document does not exist on the database');
        return false;
      }
    });
  }


//update user
  Future<String> updateCurrentUser(String firstName, String email,String lastName,
      String sex,String phone,int admin,int verified) async{

    try{
      await gusers
          .doc(user!.uid)
          .set({
        'age': 18,
        'uid': user!.uid,
        'email': email,
        'firstName':firstName ,
        'lastName': lastName,
        'sex': sex,
        'phone': phone,
        'isAdmin': admin,
        'isVerified': verified,
      });
      return "success";
    }catch(e){
      return(e.toString());
    }

  }


}



