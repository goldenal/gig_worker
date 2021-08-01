import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/models/gigs.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/services/auth.dart';
import 'package:gig_worker/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

void showdetails(BuildContext context){
  showModalBottomSheet(context: context, builder: (context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
      child: detailedPage(),
    );
  });
}
class detailedPage extends StatefulWidget {
  const detailedPage({Key? key}) : super(key: key);

  @override
  _detailedPageState createState() => _detailedPageState();
}

class _detailedPageState extends State<detailedPage> {
  Database _db = Database();
  User? user = FirebaseAuth.instance.currentUser;
  bool _loading = false;
  String gigName = selectedGig.name;
  String amount = selectedGig.amount;
  String fromtimePeriod = selectedGig.tfrom;
  String totimePeriod = selectedGig.tto;
  String location = selectedGig.location;
  String details = selectedGig.details;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 20.0, 14.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            SizedBox(
              height: 20.0,
            ),
            Text('Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            Text(details),
            SizedBox(
              height: 20.0,
            ),
            buildTextButton('claim offer', Colors.green.shade400,gigName,user!.uid,context,),
            SizedBox(
              height: 5.0,
            ),
            _loading == true ? Center(child: CircularProgressIndicator()): Text("")

          ],
        ),
      ),
    );
  }

  TextButton buildTextButton(
      String title, Color backgroundColor,String name, String id, BuildContext context) {
    return TextButton(
      onPressed: (){
        setState(() {
          _loading = true;
        });
        _db.createResponse(name, id).then((value) {
          if(value == "success"){
            setState(() {
              _loading = false;
            });
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Response Submitted"),
              backgroundColor: Colors.green.shade400,));
          }else{
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Error occured"),
              backgroundColor: Colors.red.shade400,));
          }
        });
        //print(user!.uid);

      },
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title,),
          ),


        ],
      ),
    );
  }
}
