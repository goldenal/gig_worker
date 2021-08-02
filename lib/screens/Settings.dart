import 'package:flutter/material.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';


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
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [


            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
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
            Column(

              children: [
                Container(
                 // height: 450,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 8.0,),
                      Text('Age',
                        style: TextStyle(
                            color: Color(0xFF3B5999)
                        ),),
                      textfield(true,
                          ageController,hintText:'Age'
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
                      SizedBox(height: 10.0,),

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
                        child: RaisedButton(
                          onPressed: () {},
                          color: Color(0xFF3B5999),
                          child: Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),


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
}

