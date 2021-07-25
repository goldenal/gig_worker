import 'package:flutter/material.dart';


Widget buildBottomHalfContainer(bool showShadow, bool isSignupScreen ) {
  //@required VoidCallback onTapped
  return AnimatedPositioned(
    duration: Duration(milliseconds: 500),
    curve: Curves.bounceInOut,
    top: isSignupScreen ? 535 : 430,
    right: 0,
    left: 0,
    child: Center(
      child: GestureDetector(

        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )
              : Center(),
        ),
      ),
    ),
  );
}