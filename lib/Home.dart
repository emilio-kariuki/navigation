import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import "Post.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // final Post post;
  // ignore: prefer_final_fields
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newGoogleMapController;

  Position? currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng ltPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: ltPosition, zoom: 10);
    // ignore: unused_local_variable
    newGoogleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-0.39817471446402214, 36.96075003863469),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-0.39817471446402214, 36.96075003863469),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          locatePosition();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  double? latitude;
  double? longitude;
  void getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // ignore: unused_local_variable
    var lastPosition = await Geolocator.getLastKnownPosition();

    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
  }
}
