import 'package:flutter/material.dart';
import 'package:gig_worker/screens/home/home.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/services/auth.dart';
import 'package:gig_worker/services/database.dart';



//
// void showNewGigForm(BuildContext context){
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
//       child: new_Gig(),
//     );
//   });
// }

class newGig extends StatelessWidget {
  const newGig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new_Gig(),
    );;
  }
}


class new_Gig extends StatefulWidget {
  const new_Gig({Key? key}) : super(key: key);

  @override
  _new_GigState createState() => _new_GigState();
}

class _new_GigState extends State<new_Gig> {
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  Database _db = Database();
  @override
  Widget build(BuildContext context) {
    return _loading == false ? Scaffold(
      appBar: AppBar(
        elevation: 0.0,
       // backgroundColor: Color(0xff555555),
        backgroundColor: Colors.white,
        title: Text('Create new Gigs',
        style: TextStyle(
          color: Color(0xFF3B5999)
        ),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF3B5999),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),

      ),
      body: Form(
        key:_formkey ,
        
        child: new SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              SizedBox(height: 20,),
              buildTextField(nameController, Icon(Icons.work,
                color: Palette.iconColor,), 'Gigs Title'),
              buildTextField(amountController, Icon(Icons.monetization_on,
                color: Palette.iconColor,), 'Amount'),
              buildTextField(locationController, Icon(Icons.add_location_sharp,
                color: Palette.iconColor,), 'Location'),
              buildTextField(toController, Icon(Icons.timer,
                color: Palette.iconColor,), 'staring time e.g 10:00am '),
              buildTextField(fromController, Icon(Icons.timer,
                color: Palette.iconColor,), 'Ending time e.g 4:00pm '),
              buildSpecialTextField(detailController, Icon(Icons.details,
                color: Palette.iconColor,), 'Gig details '),
              buildTextButton('Submit', Colors.orange, context)
            ],
          ),
        ),
      ),
    ) : Center(child: CircularProgressIndicator(),);
  }



  void submitNewGig(BuildContext context){
    if(_formkey.currentState!.validate()){
      setState(() {
        _loading = true;
      });
      _db.createGig(nameController.text.trim(), amountController.text.trim(),
          locationController.text.trim(), fromController.text.trim(),
          toController.text.trim(), detailController.text.trim()).then((value) {
            if(value == "success"){
              setState(() {
                _loading = false;
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successfully Added'),
                backgroundColor: Colors.green.shade400,)
              );
            }
            else{
              setState(() {
                _loading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error'),
                backgroundColor: Colors.red.shade400,)
              );

              print(value);
            }
      }
          );


    }
  }


  TextButton buildTextButton(
      String title, Color backgroundColor,BuildContext context) {
    return TextButton(
      onPressed: (){
        submitNewGig(context);

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
