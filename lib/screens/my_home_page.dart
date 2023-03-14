import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  /*CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );*/

  LocationData? currentLocation = LocationData.fromMap({
    "latitude": 37.42796133580664,
    "longitude": -122.085749655962
  }); //=LocationData.fromMap({l});
  bool isLocationEnabled=false;
  double zoom=14.4746;
  //double zoom=14;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    final GoogleMapController controller = await _controller.future;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Включите геолокацию для определения вашего местоположения'),
        ),
      );
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
            Text('Включите разрешение "Местоположение"'),
          ),
        );
        return;
      }
    }else if(_permissionGranted == PermissionStatus.grantedLimited){
      _permissionGranted = await location.requestPermission();

    }

    location.getLocation().then((location1) {
      currentLocation = location1;
    });

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;

      if(!isLocationEnabled){
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: zoom),
          ),
        );
        isLocationEnabled=true;
      }


      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
        title: Text(widget.title),
      ),*/
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 14.4746,
              ),
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              markers: {
                Marker(
                    markerId: MarkerId('source'),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                )
              },
            ),
           Align(
             alignment: Alignment.bottomCenter,
             child: Wrap(
               children: [
                 Container(
                   width: MediaQuery.of(context).size.width/2,
                   color:Color.fromARGB(192, 199, 192, 192),
                   child: Slider(
                     min: 14.4746,
                     max: 21,
                     value: zoom,
                     onChanged: (double value) async{
                       zoom=value;
                       final GoogleMapController controller = await _controller.future;
                       controller.animateCamera(CameraUpdate.zoomTo(zoom));
                       setState(() {

                       });
                     },
                   ),
                 )

               ],
             ),
           )



          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            /*  Position i= await _determinePosition();
          print(i.latitude.toString());
          _kGooglePlex=CameraPosition(
            target: LatLng(i.latitude,i.longitude),
            zoom: 14.4746,
          );
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex,),);*/
          },
        ),
      ),
    );
  }
}
