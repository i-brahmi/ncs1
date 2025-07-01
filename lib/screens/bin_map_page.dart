import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// lib/screens/maps_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ncs/constants/Appstyle.dart';

// pubspec.yaml dependencies to add:
/*
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.0
  location: ^5.0.3
  http: ^1.1.0
  geolocator: ^10.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
*/

// lib/models/trash_bin.dart
class TrashBin {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  TrashBin({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory TrashBin.fromJson(Map<String, dynamic> json) {
    return TrashBin(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}

// lib/services/location_service.dart

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  static double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}

// lib/services/api_service.dart

class ApiService {
  static Future<List<TrashBin>> fetchTrashBins() async {
    try {
      final response = await http.get(
        Uri.parse('https://ncs-bpb4.onrender.com/collection-points'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> collectionPoints = jsonData['collectionPoints'];
        return collectionPoints.map((json) => TrashBin.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load trash bins');
      }
    } catch (e) {
      throw Exception('Error fetching trash bins: $e');
    }
  }
}

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  List<TrashBin> _trashBins = [];
  // ignore: prefer_final_fields
  Set<Marker> _markers = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      // Get current location
      _currentPosition = await LocationService.getCurrentLocation();

      if (_currentPosition == null) {
        setState(() {
          _errorMessage =
              'Unable to get your location. Please enable location services.';
          _isLoading = false;
        });
        return;
      }

      // Fetch trash bins
      _trashBins = await ApiService.fetchTrashBins();

      // Create markers
      _createMarkers();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading data: $e';
        _isLoading = false;
      });
    }
  }

  void _createMarkers() {
    _markers.clear();

    // Add user location marker
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('user_location'),
          position: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'You are here',
          ),
        ),
      );
    }

    // Add trash bin markers
    for (TrashBin bin in _trashBins) {
      double distance = 0;
      if (_currentPosition != null) {
        distance = LocationService.calculateDistance(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          bin.latitude,
          bin.longitude,
        );
      }

      _markers.add(
        Marker(
          markerId: MarkerId('bin_${bin.id}'),
          position: LatLng(bin.latitude, bin.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: InfoWindow(
            title: bin.name,

            onTap: () => _showBinDetails(bin, distance),
          ),
        ),
      );
    }
  }

  void _showBinDetails(TrashBin bin, double distance) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bin.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              Text(
                'Distance: ${(distance / 1000).toStringAsFixed(2)} km',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _navigateToBin(bin),
                    child: const Text('Navigate'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToBin(TrashBin bin) {
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(bin.latitude, bin.longitude), 17.0),
      );
    }
  }

  List<TrashBin> _getNearestBins() {
    if (_currentPosition == null) return [];

    List<TrashBin> sortedBins = List.from(_trashBins);
    sortedBins.sort((a, b) {
      double distanceA = LocationService.calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        a.latitude,
        a.longitude,
      );
      double distanceB = LocationService.calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        b.latitude,
        b.longitude,
      );
      return distanceA.compareTo(distanceB);
    });

    return sortedBins.take(3).toList(); // Return 3 nearest bins
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppStyle.maincolor),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Trash Bins Map')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _initializeMap();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Trash Bins'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _initializeMap();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Map
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition != null
                    ? LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      )
                    : const LatLng(0, 0),
                zoom: 14.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
            ),
          ),
          // Nearest bins list
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nearest Trash Bins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _getNearestBins().length,
                      itemBuilder: (context, index) {
                        TrashBin bin = _getNearestBins()[index];
                        double distance = _currentPosition != null
                            ? LocationService.calculateDistance(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                                bin.latitude,
                                bin.longitude,
                              )
                            : 0;

                        return ListTile(
                          leading: const Icon(
                            Icons.delete,
                            color: Colors.green,
                          ),
                          title: Text(bin.name),
                          subtitle: Text(''),
                          isThreeLine: true,
                          onTap: () => _navigateToBin(bin),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
