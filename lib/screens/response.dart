import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class responsePage extends StatefulWidget {
  const responsePage({Key? key}) : super(key: key);

  @override
  _responsePageState createState() => _responsePageState();
}

class _responsePageState extends State<responsePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
