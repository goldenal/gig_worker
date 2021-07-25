import 'package:flutter/material.dart';
import 'package:gig_worker/screens/tools/mtextButton.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';

void showForgetPassword(BuildContext context){
  showModalBottomSheet(context: context, builder: (context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
      child: forgetPassword(),
    );
  });
}

class forgetPassword extends StatefulWidget {

  const forgetPassword({Key? key}) : super(key: key);

  @override
  _forgetPasswordState createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          buildTextField(),
          SizedBox(height: 40,),
          buildTextButton("Reset password",Palette.facebookColor),


        ],
      ),
    );
  }
}
