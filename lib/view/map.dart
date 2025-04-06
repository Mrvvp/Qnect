import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:qrowd/view%20model/map_view_model.dart';

class CustomMapPage extends ConsumerWidget {
  const CustomMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = ref.watch(mapControllerProvider);
    final events = ref.watch(mapViewModelProvider); // List of events

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<LatLng>(
            future: ref.read(mapViewModelProvider.notifier).getCurrentLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final currentLocation = snapshot.data!;
              return FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: currentLocation,
                  initialZoom: 12.0,
                  interactionOptions: InteractionOptions(
                    flags: InteractiveFlag.drag |
                        InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom,
                  ),
                ),
                children: [
                  // 🌍 Use Mapbox Style for Custom Green Map Layout
                  TileLayer(
                    urlTemplate:
                       "https://api.mapbox.com/styles/v1/mrvnvp/cm7hfgbd100kc01s86ccvcjhp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXJ2bnZwIiwiYSI6ImNtMm00bm44bjBob24ycXM5MTA4M21yM3AifQ.0P8leBXmLQUqJMw-U5Jfag",
                    additionalOptions: {
                      'access_token':
                          "pk.eyJ1IjoibXJ2bnZwIiwiYSI6ImNtMm00bm44bjBob24ycXM5MTA4M21yM3AifQ.0P8leBXmLQUqJMw-U5Jfag",
                      'id': 'mapbox.mapbox-streets-v11',
                    },
                  ),
                  // 🔴 Display Event Markers
                  MarkerLayer(
                    markers: events.map((event) {
                      return Marker(
                        point: event.location,
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.location_on, color: Colors.red),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          // 📍 Move to Current Location
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FloatingActionButton(
                onPressed: () async {
                  final currentLocation = await ref
                      .read(mapViewModelProvider.notifier)
                      .getCurrentLocation();
                  mapController.move(currentLocation, 12.0);
                },
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                child: const Icon(Icons.my_location, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}