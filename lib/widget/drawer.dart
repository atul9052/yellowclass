import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:yellowclass/modals/signinprovider.dart';
import 'package:yellowclass/ui/googlesignin.dart';
import 'package:yellowclass/ui/homepage.dart';
import 'package:yellowclass/ui/moviepage.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  final contactsBox = Hive.box('movies');

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(

          child: Container(

            height: 200,
            width: double.infinity,

            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.orange,Colors.orangeAccent,Colors.deepOrange],begin: Alignment.topCenter,end: Alignment.bottomCenter)
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:29.0),
                  child: Center(
                    child: Container(
                      width: 100,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                              child: Image.network(user.photoURL!)),
                          SizedBox(height: 10,),
                          Text(user.displayName!,style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold
                          ),),
SizedBox(height: 10,),
                          Text(user.email!,style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 8
                          ),)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),

        ListTile(
            leading: Icon(Icons.add_a_photo,color: Colors.black,),
            title: Text("Watched Movies"),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactPage(),
                ),
              );
            }
        ), ListTile(
            leading: Icon(Icons.movie,color: Colors.black,),
            title: Text("Add movies"),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewContactForm(),
                ),
              );
            }
        ),
        ListTile(
            leading: Icon(Icons.logout,color: Colors.black,),
            title: Text("Log out"),
            onTap:  () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => signin(),
                ),
              );
              final provider = Provider.of<googlesigninprovider>(context,listen: false);
              provider.logout();
            }
        ),
      ],
    );
  }
}
