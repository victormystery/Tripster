import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';
import 'helper.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future registerUserWithEmailAndPassword(
      String email, String username, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      await DatabaseService(uid: user.uid).saveUserData(email, username);

      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future loginUserWithEmailAndPassword(String email, String password) async {
    try {
      // ignore: unused_local_variable
      User user = (await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  

  // Signout Function
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSf("");
      await HelperFunctions.saveUserNameSf("");

      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
