import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellowclass/modals/movieinfo.dart';

Future<T?> showTextDialog<T>(
    BuildContext context,
      int index,
       String name,
     String director,
    String image
    ) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
     name,director,image,index
      ),
    );
class TextDialogWidget extends StatefulWidget {

   String name;
   String director;
   String image;
 int index;
  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
   TextDialogWidget(this.name, this.director, this.image, this.index);
}
class _TextDialogWidgetState extends State<TextDialogWidget> {
  bool isedit = true;
  late final PickedFile _imagefile ;
  final ImagePicker _picker =ImagePicker();
  void updatedata(int index,Contact contact) {
    final contactsBox = Hive.box('movies');
    contactsBox.putAt(index,contact);
  }

  final _editformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('movies'),
      builder: (context, contactsBox){
        final contact = contactsBox.getAt(widget.index) as Contact;
      return Form(
  key: _editformKey,
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
                  Card(
                    shadowColor: Colors.black,
                     shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
        ),
                    elevation: 200,
                    child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: contact.name,
                              decoration: InputDecoration(labelText: 'change Name',fillColor: Colors.white,filled: true),
                              onSaved: (value) {
                                widget.name = value!;
                              },
                            ),
                          ),  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: contact.director,
                              decoration: InputDecoration(labelText: 'change Name',fillColor: Colors.white,filled: true),
                              onSaved: (value) {
                                widget.director = value!;
                              },
                            ),
                          ),             ListTile(
                            leading: isedit?TextButton(
                              child: Text(" update image"),
                              onPressed: (){

                                setState(() {
                                  isedit=false;
                                });
                                editphoto(ImageSource.gallery);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("image updated"),
                                ));
                              },
                            ):Text("IMAGE UPDATED",style: TextStyle(
                              color: Colors.red,
                              fontSize: 20
                            ),)

                          ),
                          ElevatedButton(
                            child: Text('update',style: TextStyle(
                                color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold
                              ),),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _editformKey.currentState!.save();
                                final newContact = Contact(widget.name, widget.director,_imagefile.path);
                                updatedata(widget.index,newContact);
                              }
                          ),
                        ],
                      )
                  ),




            ],
          ),
        ),
      );
  }
    );
  }

  Future<void> editphoto(ImageSource gallery) async {
      PickedFile? pickedfile = await _picker.getImage(source:gallery );
      setState(() {
        _imagefile = pickedfile! ;
      });
  }
}