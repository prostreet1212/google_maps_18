

import 'package:flutter/material.dart';
import 'package:google_maps_18/widgets/map_sample.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,),
          Align(
            alignment: Alignment.centerLeft,
            child: Slider(
              min: 0,
              max: 100,
              value: 10,
              onChanged: (double value) {  },
            ),
          )
        ],
      ),
    );
  }
}