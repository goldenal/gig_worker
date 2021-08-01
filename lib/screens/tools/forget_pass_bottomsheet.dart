import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gig_worker/screens/tools/mtextButton.dart';
import 'package:gig_worker/screens/tools/mtextfield.dart';
import 'package:gig_worker/palette/palette.dart';
import 'package:gig_worker/services/auth.dart';

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
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          buildTextField(),
          SizedBox(height: 40,),
          buildTextButton("Reset password",Palette.facebookColor,context),
          _loading == true ? CircularProgressIndicator(): Text("")


        ],
      ),
    );
  }
  void submitForgetPasswordForm(BuildContext context){
    if(_formkey.currentState!.validate()){
      setState(() {
        _loading = true;
      });
      AuthServices().resetPassword(emailController.text.trim()).then((value) {
        if(value == "Email sent"){
          setState(() {
            _loading = false;
          });

          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Check your mail for reset link"),
            backgroundColor: Colors.green.shade500,)
          );


        }else{
          setState(() {
            _loading = false;
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("An Error Occurred "),
            backgroundColor: Colors.red.shade400,)
          );
       
        }

      });

    }
  }

  TextButton buildTextButton(
      String title, Color backgroundColor,BuildContext context) {
    return TextButton(
      onPressed: (){
        submitForgetPasswordForm(context);
      },
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(

        children: [
          SizedBox(width: 80,),
          Center(
            child: Text(
              title,),
          ),


        ],
      ),
    );
  }
}


