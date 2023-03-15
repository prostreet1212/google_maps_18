import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/*
class MyGoogleMaP extends StatefulWidget {
  const MyGoogleMaP({Key? key,required this.controller,required this.currentLocation}) : super(key: key);
  final Completer<GoogleMapController> controller;
  final LocationData? currentLocation;

  @override
  State<MyGoogleMaP> createState() => _MyGoogleMaPState();
}

class _MyGoogleMaPState extends State<MyGoogleMaP> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation == null
            ? LatLng(37.42796133580664, -122.085749655962)
            : LatLng(widget.currentLocation!.latitude!,
            widget.currentLocation!.longitude!),
        zoom: 14.4746,
      ),
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      onMapCreated: (controller) {
        widget.controller.complete(controller);
      },
      markers: widget.currentLocation != null
          ? {
        Marker(
          markerId: MarkerId('source'),
          position: LatLng(widget.currentLocation!.latitude!,
              widget.currentLocation!.longitude!),
        )
      }
          : {},
    );
  }
}
*/

class MyGoogleMap extends StatelessWidget {
  const MyGoogleMap({Key? key,required this.controller,required this.currentLocation}) : super(key: key);
  final Completer<GoogleMapController> controller;
  final LocationData? currentLocation;

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: currentLocation == null
            ? const LatLng(37.42796133580664, -122.085749655962)
            : LatLng(currentLocation!.latitude!,
            currentLocation!.longitude!),
        zoom: 14.4746,
      ),
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: false,
      scrollGesturesEnabled: false,
      onMapCreated: (newController) {
        controller.complete(newController);
      },
      markers: currentLocation != null
          ? {
        Marker(
          markerId: const MarkerId('my location'),
          position: LatLng(currentLocation!.latitude!,
              currentLocation!.longitude!),
        )
      }
          : {},
    );
  }
}
