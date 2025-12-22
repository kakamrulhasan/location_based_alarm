import 'package:flutter/material.dart';
import 'package:flutter_application_17/common_widgets/button_widgets.dart';
import 'package:flutter_application_17/common_widgets/gradient_container.dart';
import 'package:flutter_application_17/features/home_screen.dart';
import 'package:flutter_application_17/networks/image_urls.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? selectedLocation;
  bool loading = false;

  Future<void> _getCurrentLocation() async {
    setState(() => loading = true);

    // Check location service
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage("Location service is disabled");
      setState(() => loading = false);
      return;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      _showMessage("Location permission denied");
      setState(() => loading = false);
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Try reverse geocoding
      String locationText;
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final city = place.locality ?? '';
          final state = place.administrativeArea ?? '';
          final country = place.country ?? '';

          locationText =
              [city, state, country].where((s) => s.isNotEmpty).join(', ');

          if (locationText.isEmpty) {
            locationText =
                "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
          }
        } else {
          locationText =
              "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
        }
      } catch (e) {
        print("Reverse geocoding failed: $e");
        locationText =
            "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
      }

      setState(() {
        selectedLocation = locationText;
        loading = false;
      });
    } catch (e) {
      _showMessage("Failed to get location: $e");
      setState(() => loading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Welcome! Your Smart\nTravel Alarm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Stay on schedule and enjoy every\nmoment of your journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    ImageUrls.onboarding2,
                    height: 220,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height: 24),
                _locationCard(),
                const Spacer(),
                CustomOutlinedButton(
                  onPressed: loading ? null : _getCurrentLocation,
                  icon: const Icon(Icons.my_location, color: Colors.white),
                  label: loading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Use Current Location"),
                  iconAfter: true,
                ),
                const SizedBox(height: 12),
                CustomElevatedButton(
                  onPressed: selectedLocation == null
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                HomeScreen(location: selectedLocation!),
                          ),
                        ),
                  text: "Home",
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _locationCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              selectedLocation ?? "Selected Location",
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
