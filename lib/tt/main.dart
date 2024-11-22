import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripvs/tt/home.dart';
import 'package:tripvs/tt/additem.dart';
import 'package:tripvs/tt/edititem.dart';

// void main() {
//   runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       '/': (context) => HomeScreen(),
//       '/add': (context) => AddItemScreen(),
//       '/edit': (context) => EditItemScreen(),
//     },
//   ));
// }

void main() async {
  // firebse initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/add': (context) => AddItemScreen(),
      '/edit': (context) => EditItemScreen(),
    },
  ));
}
