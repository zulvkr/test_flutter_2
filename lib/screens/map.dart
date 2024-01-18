import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share/share.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;

class LocationShareScreen extends StatefulWidget {
  const LocationShareScreen({super.key});
  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  String _locationString = 'Fetching location...';
  final Map<String, Marker> _markers = {};
  LatLng _currentLatLng = const LatLng(0, 0);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        _locationString =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        _currentLatLng = LatLng(position.latitude, position.longitude);
        _markers['Current Location'] = Marker(
          markerId: const MarkerId('Current Location'),
          position: _currentLatLng,
          infoWindow: const InfoWindow(
            title: 'Current Location',
            snippet: 'You are here',
          ),
        );
      });
    } catch (e) {
      setState(() {
        _locationString = 'Error getting location: $e';
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _shareLocation() {
    Share.share(
        'https://www.google.com/maps/search/?api=1&query=${_currentLatLng.latitude},${_currentLatLng.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Share'),
      ),
      body: Column(
        children: [
          Container(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _currentLatLng,
                  zoom: 2,
                ),
                markers: _markers.values.toSet(),
                // set latlng on longpress
                onLongPress: (latLng) {
                  setState(() {
                    _currentLatLng = latLng;
                    _locationString =
                        'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}';
                  });
                },
              )),
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
