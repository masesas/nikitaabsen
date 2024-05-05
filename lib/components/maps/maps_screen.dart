import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  final double lat;
  final double lng;

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  late LatLng location;

  @override
  void initState() {
    setMarker();
    super.initState();
  }

  void setMarker() {
    final getLocation = LatLng(widget.lat, widget.lng);
    setState(() {
      location = getLocation;
    });
    markers.add(Marker(
      markerId: MarkerId(getLocation.toString()),
      position: getLocation,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: CameraPosition(target: location, zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
