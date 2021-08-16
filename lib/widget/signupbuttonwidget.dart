import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellowclass/modals/signinprovider.dart';


class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(4),
    child: OutlineButton.icon(
      label: Text(
        'Sign In With Google',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      highlightedBorderColor: Colors.black,
      borderSide: BorderSide(color: Colors.black),
      textColor: Colors.black,
      icon: Container(
          height:70,
          width:70,child: Image.asset("assets/img_1.png",fit: BoxFit.cover,)),
      onPressed: () {
        {
          final provider = Provider.of<googlesigninprovider>(context,listen: false);
          provider.signInWithGoogle();


        }

      },
    ),
  );
}