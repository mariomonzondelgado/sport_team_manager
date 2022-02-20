import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';


class AuthService {
  final _auth = FirebaseAuth.instance;
  Stream<User?> get authStatus=>_auth.authStateChanges();


  Future<void> signup(String email, String password) async {
    try {
       await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().e('The password provider is to weak');
      } else if (e.code == 'email-already-in-use') {
        Logger().e('The account already exists for that email.');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signin(String email, String password) async {
    try {
        await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().e('Wrong password provided for that user.');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  User? currentUser(){
    final user = _auth.currentUser;
    if (user != null) {
      return user;
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
  }

  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Logger().e(
            'The user must reauthenticate before this operation can be executed.');
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
