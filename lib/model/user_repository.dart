import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/widgets.dart';

enum Status { UNINITIALIZED, UNAUTHENTICATED, AUTHENTICATING, AUTHENTICATED }

class UserRepository with ChangeNotifier {

  FirebaseAuth _auth;
  GoogleSignIn _googleSignIn;
  FirebaseUser _user;
  Status _status = Status.UNINITIALIZED;

  UserRepository.instance() {
    _auth = FirebaseAuth.instance;
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
    _googleSignIn = new GoogleSignIn();
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signInAnonymously() async {
    try {
      _status = Status.AUTHENTICATING;
      notifyListeners();
      await _auth.signInAnonymously();
      return true;
    } catch (e) {
      _status = Status.UNAUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      return true;
    } catch (e) {
      _status = Status.UNAUTHENTICATED;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.UNAUTHENTICATED;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.UNAUTHENTICATED;
    } else {
      _user = firebaseUser;
      _status = Status.AUTHENTICATED;
    }
    notifyListeners();
  }
}