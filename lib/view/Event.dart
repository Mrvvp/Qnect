// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:qrowd/view/profile.dart';
// import 'package:qrowd/view/upload_event.dart';

// class EventsPage extends ConsumerWidget {
//   const EventsPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final communityProfile = ref.watch(communityProfileProvider);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Check if there are no events
//           if (communityProfile.events.isEmpty)
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     // Navigate to Create Event Page and open camera
//                     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//                     if (pickedImage != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CreateEventPage(
//                             capturedImage: File(pickedImage.path),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 40,
//                     child: const Icon(Icons.add, size: 40, color: Colors.black),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Post your first event!',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             )
//           else
//             Column(
//               children: [
//                 // Upload Section for Events
//                 ElevatedButton.icon(
//                   onPressed: () async {
//                     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
//                     if (pickedImage != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => CreateEventPage(
//                             capturedImage: File(pickedImage.path),
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   icon: const Icon(Icons.upload_file),
//                   label: const Text('Capture Event Image'),
//                 ),
//                 const SizedBox(height: 16),
//                 // List of Events
//                 ...communityProfile.events.map((event) {
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: ListTile(
//                       leading: event['image'] != null
//                           ? Image.file(
//                               event['image'],
//                               width: 50,
//                               height: 50,
//                               fit: BoxFit.cover,
//                             )
//                           : const Icon(Icons.event),
//                       title: Text(event['title']),
//                       subtitle: Text('Date: ${event['date']}'),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
