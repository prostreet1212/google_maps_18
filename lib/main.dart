import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_18/screens/my_home_page.dart';
import 'package:google_maps_18/widgets/map_sample.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(defaultTargetPlatform==TargetPlatform.android){
      AndroidGoogleMapsFlutter.useAndroidViewSurface=true;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'гугл',),
      //home: MapSample(),
    );
  }
}


