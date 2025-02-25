import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DrawPolyline extends StatefulWidget {
  const DrawPolyline({super.key});

  @override
  State<DrawPolyline> createState() => _DrawPolylineState();
}

class _DrawPolylineState extends State<DrawPolyline> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Polyline> _polylines = {
  };

  Set<Marker> _markers = {
  };

  LatLng myCurentLocation = LatLng(0, 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await getCurrentLocation();
      _polylines = {
    Polyline(
      polylineId: PolylineId('line1'),
      points: [
        LatLng(myCurentLocation.latitude, myCurentLocation.longitude), // Start point
        LatLng(34.0109, 71.4804), // End point
      ],
      color: Colors.red,
      width: 10,
    ),
  };
  _markers = {
    Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(myCurentLocation.latitude, myCurentLocation.longitude),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: MarkerId('marker2'),
      position: LatLng(34.0109, 71.4804),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
  };
  // Move the camera to the current location after getting it
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(myCurentLocation));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(24.7136, 46.6753),
          zoom: 15,
        ),
        polylines: _polylines,
        markers: _markers,
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.best,
            timeLimit: Duration(seconds: 10),
          ));
      setState(() {
        myCurentLocation = LatLng(position.latitude, position.longitude);
        print("my current location : " + myCurentLocation.toString());
      });
    } catch (e) {
      print("Error : " + e.toString());
    }
  }
}
