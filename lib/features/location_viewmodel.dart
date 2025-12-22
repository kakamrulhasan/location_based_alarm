import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../helpers/permission_helper.dart';

class LocationViewModel extends ChangeNotifier {
  String? locationText;
  bool loading = false;

  Future<bool> fetchLocation() async {
    loading = true;
    notifyListeners();

    final granted = await PermissionHelper.requestLocation();
    if (!granted) {
      loading = false;
      notifyListeners();
      return false;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    locationText =
        "Lat: ${position.latitude}, Lng: ${position.longitude}";

    loading = false;
    notifyListeners();
    return true;
  }
}
