import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:yellowclass/widget/signupwidget.dart';
import 'homepage.dart';
import 'moviepage.dart';
class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();


}
class _signinState extends State<signin> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }else if(snapshot.hasData){
              return ContactPage();
            }
            else if (snapshot.hasError){
              return Center(child: Text("something went wrong"),);
            }else{
              return signupwidget();
            }
          }
      )

    );
  }
}

