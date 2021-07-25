import 'package:flutter/material.dart';


TextButton buildTextButton(
     String title, Color backgroundColor) {
  return TextButton(
    onPressed: () {},
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
