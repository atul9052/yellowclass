import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';


import 'package:yellowclass/modals/movieinfo.dart';

import 'package:yellowclass/widget/drawer.dart';
import 'package:yellowclass/widget/textdialog.dart';

import 'googlesignin.dart';
class ContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
       FutureBuilder(
          future: Hive.openBox(
            'movies',
            compactionStrategy: (int total, int deleted) {
              return deleted > 20;
            },
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return Scaffold(
                  drawer: Drawer(
                    elevation: 20,
                     child: drawer(),
                  ),
                  appBar: AppBar(
                    actions: [

                    ],
                    backgroundColor: Colors.black,
                    title: Text
                      ("WATCHED MOVIES")
                  ),
                  body: Column(
                    children: <Widget>[
                      Expanded(child: _buildListView()),
                    ],
                  ),
                );
            } else
              return Scaffold();
          },
        ),


    );
  }
  Widget _buildListView() {
    return WatchBoxBuilder(
      box: Hive.box('movies'),
      builder: (context, contactsBox) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contact;
            return ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  tileColor: Colors.orange,
leading: CircleAvatar(
  backgroundImage: FileImage(File(contact.image)),
  radius: 40,
),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(contact.name,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                    child: Text("DIRECTED BY :  ${contact.director}",style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextButton(

                        child: Icon(Icons.edit
                        ,color: Colors.black,),
                        onPressed: (){
editFirstName(contact,context,index);
                        },
                      ),
                      IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          contactsBox.deleteAt(index);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
   Future editFirstName(Contact contact,context,index) async {
    final firstname = await showTextDialog(context,index,
      contact.name,contact.director,contact.image
    );
   }

  void logout() {


  }
}

