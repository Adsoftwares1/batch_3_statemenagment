import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({super.key});

  @override
  State<ConvertLatLongToAddress> createState() => _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {
  String latLong = '';
  String address = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: (){
              Text("Lat Long: $latLong");
              convertToAddress(LatLng(34.0109, 71.4804));
              convertToLatLng("Peshawar, Pakistan, board bazar brt station");
            }, child: Text("Convert Lat Long to Address")),
             Text(address),
          ],
         
        ),
      ),
    );  
  }
  void convertToAddress(LatLng position) async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude);
        address = placemark[0].country.toString();
        setState(() {
          
        });
  }

   Future<LatLng> convertToLatLng(String address) async {
    List<Location> locations = await locationFromAddress(address);
    latLong = "${locations[0].latitude}, ${locations[0].longitude}";
    setState(() {});
    return LatLng(locations[0].latitude, locations[0].longitude);
  }
}