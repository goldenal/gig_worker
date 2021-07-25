import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/screens/authenticate/authenticate.dart';
import 'package:gig_worker/screens/authenticate/sign_in.dart';
import 'package:gig_worker/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:gig_worker/models/user.dart';
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: decide(),


    );

  }
  Widget decide(){
    FirebaseAuth auth =FirebaseAuth.instance;
    if(auth.currentUser == null)return SignIn();
    else{ return Home();}
  }
}
