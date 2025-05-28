// import 'package:flutter/material.dart';
// import 'package:qrowd/view/eventdetails_page.dart';

// class LivePage extends StatelessWidget {
//   const LivePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Live Events'),
//       ),
//       body: ListView.builder(
//         itemCount: events.length,
//         itemBuilder: (context, index) {
//           final event = events[index];
//           return _buildEventCard(context, event);
//         },
//       ),
//     );
//   }

//   Widget _buildEventCard(BuildContext context, Map<String, dynamic> event) {
//     return Card(
//       margin: const EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: () {
//           // Navigate to event details page
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => EventdetailsPage())
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(
//               event['imageUrl'], //Make sure your image is declared in pubspec.yaml
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     event['title'],
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     'Date: ${event['date']}',
//                     style: const TextStyle(fontSize: 16.0, color: Colors.grey),
//                   ),
//                   Text(
//                     'Venue: ${event['venue']}',
//                     style: const TextStyle(fontSize: 16.0, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Price: \$${event['price']}',
//                         style: const TextStyle(fontSize: 16.0),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           //Implement your booking logic here
//                           print("Booking Ticket for ${event['title']}");
//                         },
//                         child: const Text('Book Now'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // Sample event data (replace with your actual data)
// final List<Map<String, dynamic>> events = [
//   {
//     'title': 'Concert 1',
//     'imageUrl': 'lib/assets/images/people-with-gothic-style-costumes-make-up-performing-drama-world-theatre-day.jpg', // Replace with your image path
//     'date': '2024-11-10',
//     'venue': 'Concert Hall',
//     'price': '50',
//   },
//   {
//     'title': 'Concert 2',
//     'imageUrl': 'lib/assets/images/pexels-teddy-2263436.jpg', // Replace with your image path
//     'date': '2024-11-15',
//     'venue': 'Stadium',
//     'price': '75',
//   },
//    {
//     'title': 'Concert 3',
//     'imageUrl': 'lib/assets/images/pexels-teddy-2263436.jpg', // Replace with your image path
//     'date': '2024-12-20',
//     'venue': 'Arena',
//     'price': '100',
//   },
//   // Add more events here
// ];



