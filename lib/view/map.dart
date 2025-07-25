import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlng2;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/view%20model/map_view_model.dart';
import 'package:qrowd/view/search_page.dart';
import 'package:qrowd/view/event_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomMapPage extends ConsumerStatefulWidget {
  const CustomMapPage({super.key});

  @override
  ConsumerState<CustomMapPage> createState() => _CustomMapPageState();
}

class _CustomMapPageState extends ConsumerState<CustomMapPage>
    with TickerProviderStateMixin {
  bool showCategories = false;
  String? selectedCategory;
  late GoogleMapController googleMapController;

  Future<void> animatedMapMove(LatLng destLocation, double destZoom) async {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: destLocation, zoom: destZoom),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // The controller is set in the GoogleMap's onMapCreated callback
    // Only fetch location if we don’t have a saved one
    if (ref.read(mapCenterProvider) == null) {
      ref.read(currentLocationProvider.future).then((loc) {
        if (mounted) {
          ref.read(mapCenterProvider.notifier).state = loc;
        }
      });
    }
  }

  double getMarkerSize(double zoom) {
    const double baseSize = 60;
    const double scaleStartZoom = 12.0;
    const double maxSize = 120;

    if (zoom <= scaleStartZoom) return baseSize;
    double size = baseSize + (zoom - scaleStartZoom) * 10;
    return size.clamp(baseSize, maxSize);
  }

  @override
  Widget build(BuildContext context) {
    final allEvents = ref.watch(mapViewModelProvider);
    final _selectedCategory = ref.watch(selectedCategoryProvider);
    final events = _selectedCategory == null
        ? allEvents
        : allEvents.where((event) => event.type == _selectedCategory).toList();
    ref.watch(mapZoomProvider);
    final asyncLocation = ref.watch(currentLocationProvider);
    final LatLng boundsSouthWest = LatLng(6.5546, 68.1114);
    final LatLng boundsNorthEast = LatLng(35.6745, 97.3956);
    final LatLngBounds allowedBounds =
        LatLngBounds(southwest: boundsSouthWest, northeast: boundsNorthEast);
    final LatLng fallbackLocation = LatLng(11.25, 76.78);

    LatLng safeInitialCenter(latlng2.LatLng location) {
      final lat = location.latitude;
      final lng = location.longitude;
      final target = LatLng(lat, lng);
      return allowedBounds.contains(target) ? target : fallbackLocation;
    }

    final selectedEvent = ref.watch(selectedEventProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final _showCategories = ref.watch(showCategoriesProvider);

    return Scaffold(
      body: Stack(
        children: [
          if (asyncLocation.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (asyncLocation.hasError)
            Center(child: Text('Error: ${asyncLocation.error}'))
          else if (asyncLocation.value == null)
            const Center(child: Text('Location not available'))
          else
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: safeInitialCenter(asyncLocation.value!),
                zoom: 9.0,
              ),
              minMaxZoomPreference: const MinMaxZoomPreference(6.0, 18.0),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapType: MapType.terrain,
              onMapCreated: (controller) {
                googleMapController = controller;
              },
              markers: {
                ...events
                    .where((event) => event != selectedEvent)
                    .map((event) => Marker(
                          markerId: MarkerId(event.id),
                          position: LatLng(event.location.latitude,
                              event.location.longitude),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueOrange),
                          onTap: () {
                            ref.read(selectedEventProvider.notifier).state =
                                event;
                          },
                        )),
                if (selectedEvent != null)
                  Marker(
                    markerId: MarkerId(selectedEvent.id),
                    position: LatLng(selectedEvent.location.latitude,
                        selectedEvent.location.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    onTap: () {
                      ref.read(selectedEventProvider.notifier).state = null;
                    },
                  ),
              },
              onCameraMove: (position) {
                ref.read(mapZoomProvider.notifier).state = position.zoom;
                // ref.read(mapCenterProvider.notifier).state = LatLng(position.target.latitude, position.target.longitude) as LatLng;
              },
            ),
          // 🟧 Filter Button (top-left) and Search Button (top-right) with vertical category column
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'filterFAB',
                        backgroundColor: Colors.white,
                        mini: true,
                        onPressed: () {
                          ref.read(showCategoriesProvider.notifier).state =
                              !ref.read(showCategoriesProvider);
                        },
                        child:
                            const Icon(Icons.filter_list, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: 'searchFAB',
                        backgroundColor: Colors.white,
                        mini: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SearchPage(),
                            ),
                          );
                        },
                        child: const Icon(CupertinoIcons.search,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: _showCategories
                        ? categoriesAsync.when(
                            data: (categories) => Column(
                              key: const ValueKey(true),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: categories.map((category) {
                                final isSelected =
                                    category == _selectedCategory;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ChoiceChip(
                                    label: Text(category),
                                    selected: isSelected,
                                    showCheckmark: true,
                                    checkmarkColor: Colors.white,
                                    onSelected: (selected) {
                                      ref
                                          .read(
                                              selectedCategoryProvider.notifier)
                                          .state = selected ? category : null;
                                    },
                                    selectedColor: Colors.deepOrange,
                                    backgroundColor: Colors.grey[200],
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stack) =>
                                Text('Error loading categories'),
                          )
                        : const SizedBox.shrink(key: ValueKey(false)),
                  ),
                ),
              ],
            ),
          ),
          // 📍 Zoom In, Zoom Out, and Current Location Button
          Consumer(builder: (context, ref, _) {
            final offset = ref.watch(eventCardOffsetProvider);
            final selectedEvent = ref.watch(selectedEventProvider);

            final baseBottom = selectedEvent != null ? 170.0 : 20.0;
            final animatedBottom = baseBottom - offset;

            return AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              bottom: animatedBottom,
              right: 15,
              child: FloatingActionButton(
                heroTag: 'currentLocation',
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () async {
                  final currentLocation = await ref
                      .read(mapViewModelProvider.notifier)
                      .getCurrentLocation();
                  // await animatedMapMove(
                  //     currentLocation, ref.read(mapZoomProvider));
                },
                child: const Icon(CupertinoIcons.location_fill,
                    color: Color(0xffFF2F00)),
              ),
            );
          }),

          // 📦 Bottom Sheet for Selected Event
          if (selectedEvent != null)
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  final delta = details.delta.dy;
                  ref.read(eventCardOffsetProvider.notifier).update((offset) {
                    final newOffset = offset + delta;
                    return newOffset.clamp(0.0, 150.0);
                  });
                },
                onVerticalDragEnd: (_) {
                  final offset = ref.read(eventCardOffsetProvider);

                  if (offset >= 150) {
                    // Only dismiss when fully pulled down
                    ref.read(selectedEventProvider.notifier).state = null;
                    ref.read(eventCardOffsetProvider.notifier).state = 0.0;
                  } else {
                    // Snap back to top
                    ref.read(eventCardOffsetProvider.notifier).state = 0.0;
                  }
                },
                child: Consumer(
                  builder: (context, ref, _) {
                    final offset = ref.watch(eventCardOffsetProvider);
                    final opacity = (1 - offset / 100).clamp(0.0, 1.0);
                    final scale = (1 - offset / 300).clamp(0.9, 1.0);

                    return TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.9, end: scale),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      builder: (context, scaleValue, child) {
                        return Transform.scale(
                          scale: scaleValue,
                          alignment: Alignment.bottomCenter,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: opacity,
                            curve: Curves.easeOutCubic,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutCubic,
                              transform:
                                  Matrix4.translationValues(0, offset, 0),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  // Event content
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: selectedEvent.imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      selectedEvent.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  const Text("6 KM",
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.access_time,
                                                      size: 14),
                                                  SizedBox(width: 4),
                                                  Text(selectedEvent.time,
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 14),
                                                  SizedBox(width: 4),
                                                  Text(selectedEvent.address,
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // View button
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const EventDetailPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "View",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }
}

// To render the below custom widget markers on GoogleMap,
// you need to convert the widget to image bytes and use BitmapDescriptor.fromBytes().

Widget buildMarker(
    BuildContext context, dynamic event, double size, WidgetRef ref) {
  final isSelected = event == ref.read(selectedEventProvider);

  return GestureDetector(
    onTap: () {
      ref.read(selectedEventProvider.notifier).state =
          isSelected ? null : event;
    },
    child: TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: isSelected ? 0.9 : 1.0,
        end: isSelected ? 1.0 : 0.9,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) => Transform.scale(
        scale: scale,
        child: child,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: event.imageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    ),
  );
}
