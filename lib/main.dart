// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:yellowclass/ui/googlesignin.dart';

import 'modals/movieinfo.dart';
import 'modals/signinprovider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
}
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   @override


// }
//
//
//



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => googlesigninprovider(),
      child: MaterialApp(
        home: signin()
      ),
    );
  }

}

