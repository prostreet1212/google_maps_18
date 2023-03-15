import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LeftMoveButton extends StatelessWidget {
  const LeftMoveButton({Key? key,required this.controller}) : super(key: key);
  final Completer<GoogleMapController> controller ;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: FloatingActionButton.small(
            backgroundColor: const Color.fromARGB(192, 199, 192, 192),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () async {
              final GoogleMapController newController =
              await controller.future;
              newController.animateCamera(CameraUpdate.scrollBy(-50, 0));
            },
          ),
        ));
  }
}
