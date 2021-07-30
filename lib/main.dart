import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/screens/authenticate/sign_in.dart';
import 'package:gig_worker/screens/home/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //tracking and listening to User for changes
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: fHome(),
      );


  }
}

class fHome extends StatefulWidget {
  const fHome({Key? key}) : super(key: key);

  @override
  _fHomeState createState() => _fHomeState();
}

class _fHomeState extends State<fHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    //Database db = Database();
   // db.create("adewale job", '900', 'New york', "10am", "5pm");
      return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Container();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return decide();
          }

          Timer(Duration(seconds: 3),(){});
          // Otherwise, show something whilst waiting for initialization to complete
          return Container(

            child:Center(
                child: Center(child: CircularProgressIndicator(),)

        ),
            color: Color(0xFF3B5999),
          );
        },
      );
    }
  Widget decide(){
    FirebaseAuth auth =FirebaseAuth.instance;
    if(auth.currentUser == null)return SignIn();
    else{ return Home();}



  }

  }






