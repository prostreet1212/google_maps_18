import 'package:flutter/material.dart';
import 'package:google_maps_18/screens/my_home_page.dart';
import 'package:google_maps_18/widgets/map_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(title: 'Google Maps',),
    );
  }
}


