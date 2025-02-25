import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapPractice extends StatefulWidget {
  const GoogleMapPractice({super.key});

  @override
  State<GoogleMapPractice> createState() => _GoogleMapPracticeState();
}

class _GoogleMapPracticeState extends State<GoogleMapPractice> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng myCurentLocation = LatLng(32.953162854, 70.502997988);

  Set<Marker> markers = {};

  // set markers
  void setMarkers() {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId('1'),
          position: myCurentLocation,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // request permission of location
    getPermission();
    // get current location
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCurrentLocation();
      setMarkers();
      // Move the camera to the current location after getting it
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(myCurentLocation));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
          compassEnabled: true,
          mapType: MapType.satellite,
          initialCameraPosition: CameraPosition(
            target: myCurentLocation,
            zoom: 20,
          ),
          markers: Set.of(markers),
          onTap: (position) {
            setState(() {
              markers.add(Marker(
                markerId: MarkerId(position.toString()),
                position: position,
              ));
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            myCurentLocation = LatLng(32.953162854, 70.502997988);
            final GoogleMapController controller = await _controller.future;
            await controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: myCurentLocation, zoom: 20)));
          },
          child: Icon(Icons.location_pin),
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        myCurentLocation = LatLng(position.latitude, position.longitude);
        print("my current location : " + myCurentLocation.toString());
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
  }

  Future<void> getPermission() async {
    try {
      Permission.location.request();
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
