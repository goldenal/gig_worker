import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gig_worker/screens/authenticate/sign_in.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/screens/detailedPage.dart';
import 'package:gig_worker/screens/response.dart';
import 'package:gig_worker/services/database.dart';
import 'package:gig_worker/screens/tools/new_gig_page.dart';

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
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Gigs').snapshots();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Palette _palette = Palette();
  int index = 0;
  bool _isAdmin = false;
  List<Gigs> gigList = [];


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

        print(_isAdmin);


      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:titleSelector(),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
              if (_auth.currentUser == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                    (route) => false);
              }
            },
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible:_isAdmin ,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.orange,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => newGig()),
                    );
          //  showNewGigForm(context);
          },
        )
      ),
      body: pageSelector(),
      bottomNavigationBar: buildbottombar(),
    );
  }

  Widget _buildCard(String gigName, String amount, String location,
      String fromtimePeriod, String totimePeriod) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  gigName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$$amount',
                  style:
                      TextStyle(color: Colors.green.shade300, fontSize: 15.0),
                )
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Text("$fromtimePeriod " + " - " + "$totimePeriod"),
            SizedBox(
              height: 4.0,
            ),
            Text(location),
          ],
        ),
      ),
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

          gigList = gigListFromSnapshot(snapshot) ?? [];

        return ListView.builder(
          itemCount: gigList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
               selectedGig =   gigList[index];
               //print(selectedGig.name);
                showdetails(context);
              },
              child: _buildCard(
                  gigList[index].name,
                  gigList[index].amount,
                  gigList[index].location,
                  gigList[index].tfrom,
                  gigList[index].tto),
            );
          },
        );


      },
    );
  }

  List<Gigs> gigListFromSnapshot(snapshot) {
    return snapshot.data.docs.map<Gigs>((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      return Gigs(data['gigName'] ?? '', data['amount'], data['totimePeriod'],
          data['fromtimePeriod'], data['location'], data['details']?? 'not available');
    }).toList();
  }


  //creating the bottom navy bar
  buildbottombar() {
    final inactivecolor= Colors.grey;
    return BottomNavyBar(
      selectedIndex: index,
        containerHeight: 65.0,
        onItemSelected: (index) => setState(() => this.index = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('home'),
            textAlign: TextAlign.center,
            activeColor: Color(0xFF3B5999),
            inactiveColor: inactivecolor

          ),
          BottomNavyBarItem(
              icon: Icon(Icons.dynamic_feed_sharp),
              title: Text('Requests'),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF3B5999),
              inactiveColor: inactivecolor

          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('settings'),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF3B5999),
              inactiveColor: inactivecolor
          )
        ]

    );

  }




  //for routing pages when click the bottom navy bar
  Widget pageSelector(){
    switch(index){
      case 1:
        return responsePage();
      default:
        return streamWiget(context);
    }
  }

  //for changing the app bar title
Widget titleSelector(){
  switch(index){
    case 1:
      return Text("Active Gig",
        style: TextStyle(
          color: Color(0xFF3B5999),
        ),);
    default:
      return  Text('Available jobs',
        style: TextStyle(
          color: Color(0xFF3B5999),
        ),);
  }
}


}
