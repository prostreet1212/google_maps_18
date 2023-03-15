import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class BottomPanel extends StatefulWidget {
   const BottomPanel({Key? key,required this.controller,required this.zoom,required this.currentLocation}) : super(key: key);
  final Completer<GoogleMapController> controller ;
   final double zoom;
   final LocationData? currentLocation;

   void  setZoom(double zoom)=>zoom=this.zoom;
   double get zoom1 {
     return zoom;
   }



  @override
  State<BottomPanel> createState() => _BottomPanelState();

}

class _BottomPanelState extends State<BottomPanel> {
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
                await widget.controller.future;
                newController
                    .animateCamera(CameraUpdate.scrollBy(0, 50));
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
                        child: Slider(
                          min: 14.4746,
                          max: 21,
                          value: widget.zoom1,
                          onChanged: (double value) async {
                            //widget.zoom = value;
                            widget.setZoom(value);

                            final GoogleMapController controller =
                            await widget.controller.future;
                            controller.animateCamera(
                                CameraUpdate.zoomTo(widget.zoom1));
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  backgroundColor: const Color.fromARGB(192, 199, 192, 192),
                  onPressed: widget.currentLocation != null
                      ? () async {
                    final GoogleMapController controller =
                    await widget.controller.future;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: LatLng(
                                widget.currentLocation!.latitude!,
                                widget.currentLocation!.longitude!),
                            zoom: widget.zoom),
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

