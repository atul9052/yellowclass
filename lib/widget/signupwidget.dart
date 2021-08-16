import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yellowclass/modals/signinprovider.dart';
import 'package:yellowclass/widget/signupbuttonwidget.dart';
class signupwidget extends StatefulWidget {
  const signupwidget({Key? key}) : super(key: key);

  @override
  _signupwidgetState createState() => _signupwidgetState();
}

class _signupwidgetState extends State<signupwidget> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SizedBox(height: 100,),
        Container(
            height: 200,
            width: 150,

            child: Image.asset("assets/img.png")),
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: 130,
            child: Text(
              'Welcome Back To MyApp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 50,),
        GoogleSignupButtonWidget(),
        SizedBox(height: 12),

        Spacer(),
      ],
    );
  }
}
