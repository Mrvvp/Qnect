import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:qrowd/model/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Category').get();
  return snapshot.docs.map((doc) => doc['type'] as String).toList();
});

final mapZoomProvider = StateProvider<double>((ref) => 12.0);
final mapCenterProvider = StateProvider<LatLng?>((ref) => null);
final eventCardOffsetProvider = StateProvider<double>((ref) => 0.0);
final showCategoriesProvider = StateProvider<bool>((ref) => false);
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Holds current location
final currentLocationProvider = FutureProvider<LatLng>((ref) async {
  return await ref.read(mapViewModelProvider.notifier).getCurrentLocation();
});

// Holds the currently selected event (null = none)
final selectedEventProvider = StateProvider<EventModel?>((ref) => null);

class MapViewModel extends StateNotifier<List<EventModel>> {
  MapViewModel() : super([]) {
    loadEventsFromFirebase();
  }

  Future<void> loadEventsFromFirebase() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    final events = querySnapshot.docs.map((doc) {
      final data = doc.data();
      return EventModel(
        id: doc.id,
        name: data['name'] ?? '',
        location: LatLng(
          (data['latitude'] ?? 0).toDouble(),
          (data['longitude'] ?? 0).toDouble(),
        ),
        imageUrl: data['imageurl'] ?? '',
        time: data['time'] ?? '',
        address: data['address'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        isAvailable: data['isAvailable'] ?? true,
        type: data['type'] ?? '',
        date: data['date'] ?? '',
      );
    }).toList();

    state = events;
  }

  // Add a new marker (event)
  // void addEvent(String name, LatLng location, String imageUrl) {
  //   state = [
  //     ...state,
  //     EventModel(name: name, location: location, imageUrl: imageUrl)
  //   ];
  // }

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

final mapViewModelProvider =
    StateNotifierProvider<MapViewModel, List<EventModel>>((ref) {
  return MapViewModel();
});

final mapControllerProvider = Provider<MapController>((ref) {
  return MapController();
});
