import 'package:flutter/material.dart';
import 'package:gig_worker/palette/palette.dart';

final formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final RegExp emailRegex = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
Widget buildTextField() {

  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
      obscureText: false,
      validator: (String? value){
        if (!emailRegex.hasMatch(value!)) {
          return 'Please enter valid email';
        }
        return null;
      },
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail_outline,
          color: Palette.iconColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: 'coldsteamdev@gmail.com',
        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
      ),
    ),
  );
}

Widget buildPasswrdTextField() {

  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextFormField(
      obscureText: true,
      validator: (String? value){
        if(value != null && value.length > 6){
          return null;
        }else{
          return "At least 6 charcters long";
        }
      },
      controller: passwordController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Palette.iconColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.textColor1),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        contentPadding: EdgeInsets.all(10),
        hintText: 'Password',
        hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
      ),
    ),
  );
}