import 'package:flutter/material.dart';
import 'package:flutter_application_17/common_widgets/button_widgets.dart';
import 'package:flutter_application_17/common_widgets/gradient_container.dart';
import 'package:flutter_application_17/features/home_screen.dart';
import 'package:flutter_application_17/networks/image_urls.dart';
import 'package:geolocator/geolocator.dart';

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

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage("Location service is disabled");
      setState(() => loading = false);
      return;
    }

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

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      selectedLocation =
          "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}";
      loading = false;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
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
                  child: Image.network(
                    ImageUrls.onboarding2,
                    height: 220,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                const Spacer(),
                CustomOutlinedButton(
                  onPressed: loading ? null : _getCurrentLocation,
                  icon: const Icon(Icons.location_on_outlined, color: Colors.white),
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

  // Widget _locationCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(14),
  //     decoration: BoxDecoration(
  //       color: Colors.white12,
  //       borderRadius: BorderRadius.circular(30),
  //     ),
  //     child: Row(
  //       children: [
  //         const Icon(Icons.location_on, color: AppColors.whiteLight),
  //         const SizedBox(width: 8),
  //         Expanded(
  //           child: Text(
  //             selectedLocation ?? "Selected Location",
  //             style: const TextStyle(color: AppColors.whiteLight),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
