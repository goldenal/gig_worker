
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gig_worker/models/user.dart';

class AuthServices {
FirebaseAuth auth = FirebaseAuth.instance;


//to register
Future<String> createAccount(String email,String password)async{
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return "Acount_created";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      return('The account already exists for that email.');
    }
  } catch (e) {
    return "an error occured";
  }
return "";
}

// to sign in
Future<String> SignIn(String email,String password)async{
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email:email,
        password: password
    );
    return "Welcome";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      return('Wrong password provided for that user.');
    }
  }
  return "";
}

//to reset password
Future<String> resetPassword(String email)async{
  try {
     await auth.sendPasswordResetEmail(
        email:email,
    );
    return "Email sent";
  }
  catch (e) {
    return "error occured";
  }
  return "";
}
void signOut(){
  auth.signOut();
}

}