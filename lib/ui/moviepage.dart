

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yellowclass/modals/movieinfo.dart';
import 'package:image_picker/image_picker.dart';
class NewContactForm extends StatefulWidget {
  @override
  _NewContactFormState createState() => _NewContactFormState();


}
class _NewContactFormState extends State<NewContactForm> {
  final user = FirebaseAuth.instance.currentUser!;
  late final PickedFile _imagefile ;
  final ImagePicker _picker =ImagePicker();
late String path;
  late var _name;
  late var _director;

  final _formKey = GlobalKey<FormState>();

  bool isuploaded=true;
  void addContact(Contact contact) {
    final contactsBox = Hive.box('movies');
    contactsBox.add(contact);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("Add movies",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),)),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextFormField(
                    validator: (v){
                      if(v!.isEmpty){
                        return "Movie name is required";
                      }
                    },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(

                                color: Colors.red
                            ),
                          ),focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(

                            color: Colors.orange
                        ),
                      ),
                          hintText: 'Enter movie name',
                          hintStyle: TextStyle(
                              color: Colors.black
                          )
                      ),

                    onSaved: ( value) => _name = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextFormField(

                      validator: (v){
                        if(v!.isEmpty){
                          return "Director name is required";
                        }
                      },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(

                              color: Colors.red
                          ),
                        ),focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(

                          color: Colors.orange
                      ),
                    ),
                        hintText: 'Enter director name',
                        hintStyle: TextStyle(
                            color: Colors.black
                        )
                    ),
                    onSaved: (value) => _director = value,
                  ),
                ),
                   ListTile(leading:isuploaded? TextButton(
                     child: Text("-> click to upload image",style: TextStyle(
                       fontSize: 23,
                       fontWeight: FontWeight.bold,

                     ),),
                     onPressed: (){
                       setState(() {
                         isuploaded=false;
                       });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("image uploaded"),
                      ));
                       takephoto(ImageSource.gallery);
                     },
                   ):Center(
                     child: Text("image uploaded",style: TextStyle(
                       fontSize: 30,
                       color: Colors.red
                     ),),
                   )
                   ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),Container(
                      color: Colors.orange,
                      width: 150,
                      child: FlatButton(
                        hoverColor: Colors.black,
                        child: Text('Add New Movie',style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            final newContact = Contact(_name,_director,_imagefile.path);
                            addContact(newContact);
                          }else{
                            return;
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                )

              ],
        ),
      ),
    );
  }

  void takephoto(ImageSource source) async {
    PickedFile? pickedfile = await _picker.getImage(source:source );
    setState(() {
      _imagefile = pickedfile! ;

    });

  }
}