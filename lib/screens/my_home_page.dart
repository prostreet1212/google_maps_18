import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_18/widgets/bottom_panel.dart';
import 'package:google_maps_18/widgets/left_move_button.dart';
import 'package:google_maps_18/widgets/my_google_map.dart';
import 'package:google_maps_18/widgets/right_move_button.dart';
import 'package:google_maps_18/widgets/top_move_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LocationData? currentLocation;
  bool isLocationEnabled = false;
  double zoom = 14.4746;

  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void onChanged(double value) async {
    final GoogleMapController newController = await _controller.future;
    newController.animateCamera(CameraUpdate.zoomTo(zoom));
    setState(() {
      zoom = value;
    });
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    final GoogleMapController controller = await _controller.future;

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        showSnackbar(
            'Включите геолокацию для определения вашего местоположения');
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        showSnackbar('Включите разрешение "Местоположение"');
        return;
      }
    }
    location.getLocation().then((location1) {
      currentLocation = location1;
    });
    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      if (!isLocationEnabled) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: zoom),
          ),
        );
        isLocationEnabled = true;
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
        body: Stack(
          children: [
            MyGoogleMap(
                controller: _controller, currentLocation: currentLocation),
            TopMoveButton(controller: _controller),
            LeftMoveButton(controller: _controller),
            RightMoveButton(controller: _controller),
            BottomPanel(
              controller: _controller,
              zoom: zoom,
              currentLocation: currentLocation,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
