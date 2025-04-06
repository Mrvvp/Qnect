import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:qrowd/model/event_model.dart';

// ViewModel for managing map logic
class MapViewModel extends StateNotifier<List<EventModel>> {
  MapViewModel() : super([]);

  // Add a new marker (event)
  void addEvent(String name, LatLng location) {
    state = [...state, EventModel(name: name, location: location)];
  }

  // Get user's current location
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("Location services are disabled.");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}

// Provider for Map ViewModel
final mapViewModelProvider =
    StateNotifierProvider<MapViewModel, List<EventModel>>((ref) {
  return MapViewModel();
});

// Provider for the Map Controller
final mapControllerProvider = Provider<MapController>((ref) {
  return MapController();
});