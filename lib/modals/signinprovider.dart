import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class googlesigninprovider extends ChangeNotifier{
final googlesignin =GoogleSignIn();
GoogleSignInAccount? _user;
GoogleSignInAccount get user =>_user!;
  Future signInWithGoogle() async {
     final googleuser = await GoogleSignIn().signIn();
if(googleuser==null) return;
_user =googleuser;
    final  googleAuth = await googleuser.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }


  Future logout() async{
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();

  }


}