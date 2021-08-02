import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/models/userResponse.dart';
import 'package:gig_worker/models/user.dart';
import 'package:gig_worker/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class responsePage extends StatefulWidget {
  const responsePage({Key? key}) : super(key: key);

  @override
  _responsePageState createState() => _responsePageState();
}

class _responsePageState extends State<responsePage> {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Response');
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Response').snapshots();
  Database _db = Database();
  bool _isAdmin = false;
  List<Response> responseList = [];
  String fname = "";
  String lname = "";
  String uPhone = "";


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('GigUsers')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _isAdmin = data['isAdmin'] == 1 ? true : false;
        });

        print("well$_isAdmin");


      } else {
        print('Document does not exist on the database');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
   // selectedgUser = retriveApplicantdata();


    return _isAdmin == true ? streamWiget(context):
    FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Center(child: Text("No Active Gigs"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(data['gigName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                ),),
                new Text(data['approved'] == '0' ? 'Not yet approved': 'Approved',
                  style: TextStyle(
                      color: data['approved'] == '0' ? Colors.yellow.shade900 :Colors.green
                  ),
                ),
              ]

            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget streamWiget(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        responseList = responseListFromSnapshot(snapshot) ?? [];

        return ListView.builder(
          itemCount: responseList.length,
          itemBuilder: (context, index) {
            retriveApplicantdata(index);
            return GestureDetector(
              onTap: (){
                selectedResponse =   responseList[index];

               // showdetails(context);
              },
              child: _buildCard(
                  responseList[index].gigName,
                 fname,
                  lname,
                  uPhone,
                  index
              ),
            );
          },
        );


      },
    );
  }


  List<Response> responseListFromSnapshot(snapshot) {
    return snapshot.data.docs.map<Response>((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      return Response(data['gigName'] ?? '', data['gigApplicant'], data['approved']);
    }).toList();
  }

  //retreive current user applicant clicked
   retriveApplicantdata(int index) {
   FirebaseFirestore.instance
       .collection('GigUsers')
       .doc(responseList[index].applicantUid)
       .get()
       .then((DocumentSnapshot documentSnapshot) {
     if (documentSnapshot.exists) {
       Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
       GUser guser = GUser( documentSnapshot!['email'], documentSnapshot!['firstName'],
           data['lastName'], data['sex'], data['phone'],
           data['isAdmin'], data['isVerified'], uid: data['uid']);
       setState(() {
         fname = guser.firstName;
         print('my anme $fname');
         lname = guser.lastName;
         uPhone = guser.phone;
       });

     } else {
       print('mmDocument does not exist on the database');
     }
   });


  }

  Widget _buildCard(String gigName, String userfirstName, String userLastName,
      String phone,int index) {

    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2.0),
            Text(
              gigName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              userfirstName,
              style:
              TextStyle(color: Colors.green.shade300, fontSize: 15.0),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(userLastName),
            SizedBox(
              height: 5.0,
            ),
            Text(phone),
          ],
        ),
      ),
    );
  }
}
