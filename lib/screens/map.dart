import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationShareScreen extends StatefulWidget {
  const LocationShareScreen({Key? key}) : super(key: key);

  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  String _locationString = 'Fetching location...';
  GoogleMapController? _mapController;
  LatLng _currentLatLng = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _locationString =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        _locationString = 'Error getting location: $e';
      });
    }
  }

  void _shareLocation() {
    Share.share(_locationString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Share'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentLatLng,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: _currentLatLng,
                  infoWindow: InfoWindow(
                    title: 'Current Location',
                    snippet: _locationString,
                  ),
                ),
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _locationString,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _shareLocation,
            child: const Text('Share Location'),
          ),
        ],
      ),
    );
  }
}
