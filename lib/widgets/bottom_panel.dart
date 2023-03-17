import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel(
      {Key? key,
      required this.controller,
      required this.zoom,
      required this.currentLocation,
      required this.onChanged})
      : super(key: key);

  final Completer<GoogleMapController> controller;
  final double zoom;
  final LocationData? currentLocation;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              backgroundColor: const Color.fromARGB(192, 199, 192, 192),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              onPressed: () async {
                final GoogleMapController newController =
                    await controller.future;
                newController.animateCamera(CameraUpdate.scrollBy(0, 50));
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Wrap(
                    children: [
                      Container(
                          color: const Color.fromARGB(192, 199, 192, 192),
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Slider(
                              min: 14.4746,
                              max: 21,
                              value: zoom,
                              onChanged: onChanged,
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(192, 199, 192, 192),
                  onPressed: currentLocation != null
                      ? () async {
                          final GoogleMapController newController =
                              await controller.future;
                          newController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                  target: LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!),
                                  zoom: zoom),
                            ),
                          );
                        }
                      : () {},
                  child: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
