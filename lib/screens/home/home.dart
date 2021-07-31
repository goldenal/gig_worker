import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gig_worker/screens/authenticate/sign_in.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/services/database.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Hompage(),
    );
  }
}
class Hompage extends StatefulWidget {
  const Hompage({Key? key}) : super(key: key);

  @override
  _HompageState createState() => _HompageState();
}

class _HompageState extends State<Hompage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Gigs').snapshots();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Palette _palette = Palette();




@override
void initState() {
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3B5999) ,
        title: Text('Available jobs'),
          actions: <Widget>[
      FlatButton.icon(
      icon: Icon(Icons.settings),
      label: Text('logout'),
      onPressed: () async {
        await _auth.signOut();
        if(_auth.currentUser == null){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
                  (route) => false);
        }
      },
    )],
  ),
      body: streamWiget(context),
    );
  }




  Widget _buildCard (String gigName, String amount, String location, String fromtimePeriod, String totimePeriod){
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 7.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(gigName,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text('\$$amount',
                  style: TextStyle(
                      color: Colors.green.shade300,
                      fontSize: 15.0
                  ),)
              ],
            ),
            SizedBox(height: 12.0,),
            Text("$fromtimePeriod " + " - " + "$totimePeriod"),
            SizedBox(height: 4.0,),
            Text(location),

          ],

        ),
      ),
    );
  }


  Widget streamWiget(BuildContext context){
    return new StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        List<Gigs> gigList = gigListFromSnapshot(snapshot)?? [];
        return ListView.builder(
          itemCount: gigList.length,
          itemBuilder: (context, index) {
            return _buildCard(gigList[index].name, gigList[index].amount,
                gigList[index].location, gigList[index].tfrom,
                gigList[index].tto);
          },
        );

        // return new ListView(
        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        //     return _buildCard(data['gigName'], data['amount'], data['location'], data['fromtimePeriod'],
        //         data['totimePeriod']);
        //     // return new ListTile(
        //     //   title: new Text(data['full_name']),
        //     //   subtitle: new Text(data['company']),
        //     // );
        //   }).toList(),
        // );


      },


    );

  }
  List<Gigs> gigListFromSnapshot(snapshot) {
    return snapshot.data.docs.map<Gigs>((DocumentSnapshot document){
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      return
        Gigs(data['gigName'] ?? '', data['amount'],
            data['totimePeriod'], data['fromtimePeriod'], data['location'], data['location']);
    }).toList();
  }

}
