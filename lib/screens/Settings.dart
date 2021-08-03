import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gig_worker/models/user.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/services/database.dart';


class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF3B5999);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class Settings_page extends StatefulWidget {
  const Settings_page({Key? key}) : super(key: key);


  @override
  _Settings_pageState createState() => _Settings_pageState();
}



class _Settings_pageState extends State<Settings_page> {
 // TextEditingController _controller = TextEditingController();
  String _fname = "", _lname= "",_sex = "", _phone = "", _age = "";
   late GUser _gUser;
  final _formKey = GlobalKey<FormState>();
  bool _isloading  = false;
  Database _db = Database();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('GigUsers')
        .doc(Database().user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _gUser = GUser(data['email'], data['firstName'], data['lastName'], data['sex'], data['phone'],
              data['isAdmin'], data['isVerified'], uid: data['uid']);
        });
        print(_gUser.firstName);

         firstNameController = TextEditingController
            .fromValue(new TextEditingValue(text: _gUser.firstName ));
         lastNameController = TextEditingController
             .fromValue(new TextEditingValue(text: _gUser.lastName));
         sexController = TextEditingController
             .fromValue(new TextEditingValue(text: _gUser.sex ));
         phoneController =TextEditingController
             .fromValue(new TextEditingValue(text: _gUser.phone ));
         emailController = TextEditingController
             .fromValue(new TextEditingValue(text: _gUser.email ));

      } else {
        print('Document does not exist on the database');
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          //alignment: Alignment.center,
          children: [
            // CustomPaint(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height,
            //   ),
            //   painter: HeaderCurvedContainer(),
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.all(20),
            //       child: Text(
            //         "Profile",
            //         style: TextStyle(
            //           fontSize: 35,
            //           letterSpacing: 1.5,
            //           color: Colors.white,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // ),
            Container(
              // height: 450,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0,),
                    Text('First Name',
                      style: TextStyle(
                          color: Color(0xFF3B5999)
                      ),),
                    textfield(true,
                        firstNameController,hintText:'First name'
                    ),
                    SizedBox(height: 8.0,),
                    Text('Last Name',
                      style: TextStyle(
                          color: Color(0xFF3B5999)
                      ),),
                    textfield(true,
                        lastNameController,hintText:'Last name'
                    ),
                    // SizedBox(height: 8.0,),
                    // Text('Age',
                    //   style: TextStyle(
                    //       color: Color(0xFF3B5999)
                    //   ),),
                    // textfield(true,
                    //     ageController,hintText:'Age'
                    // ),
                    SizedBox(height: 8.0,),
                    Text('Gender',
                      style: TextStyle(
                          color: Color(0xFF3B5999)
                      ),),
                    textfield(true,
                        sexController,hintText:'Gender'
                    ),

                    SizedBox(height: 8.0,),
                    Text('Phone',
                      style: TextStyle(
                          color: Color(0xFF3B5999)
                      ),),
                    textfield(true,
                        phoneController,hintText:'Phone'
                    ),
                    SizedBox(height: 8.0,),
                    Text('Email',
                      style: TextStyle(
                          color: Color(0xFF3B5999)
                      ),),
                    textfield(false,
                        emailController,hintText:'Email'
                    ),
                    SizedBox(height: 25.0,),

                    // textfield(
                    //   hintText: 'Email',
                    // ),
                    // textfield(
                    //   hintText: 'Password',
                    // ),
                    // textfield(
                    //   hintText: 'Confirm password',
                    // ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: buildTextButton('update', Colors.orange,context)
                    ),
                    _isloading == false ? Text(''): Center(child: CircularProgressIndicator(),)
                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }


  Widget textfield(bool isEnable, TextEditingController controller ,{@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        enabled: isEnable,
        validator: (String? value){
          if (value!.isEmpty || value == ' ') {
            return 'Can not be empty';
          }
          return null;
        },
        controller:controller ,
          keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
  TextButton buildTextButton(
      String title, Color backgroundColor, BuildContext context) {
    return TextButton(
      onPressed: (){
          setState(() {
            _isloading = true;
          });
        if(_formKey.currentState!.validate()){
          Database().updateCurrentUser(firstNameController.text.trim(), emailController.text.trim(),
              lastNameController.text.trim(), sexController.text.trim(), phoneController.text.trim(),
              0, 0).
          then((value) {
                if(value == 'success'){
                  setState(() {
                    _isloading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('updated'),
                    backgroundColor: Colors.green.shade400,)
                  );
                }
                else{
                  setState(() {
                    _isloading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error'),
                    backgroundColor: Colors.red.shade400,)
                  );
                }
           });
        }
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

