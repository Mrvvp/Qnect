import 'package:latlong2/latlong.dart';

class EventModel {
  final String id;
  final String name;
  final LatLng location;
  final String imageUrl;
  final String time;
  final String address;
  final String description;
  final double price;
  final bool isAvailable;
  final String type;
  final String date;

  EventModel(
      {required this.id,
      required this.name,
      required this.location,
      required this.imageUrl,
      required this.time,
      required this.address,
      required this.description,
      required this.price,
      required this.isAvailable,
      required this.type,
      required this.date});
}
