import 'package:flutter/material.dart';// Import for launching URLs

class VenuePage extends StatelessWidget {
   VenuePage({super.key});

  final List<Map<String, dynamic>> venues = [
    {
      'name': 'Venue A',
      'imageUrl': 'lib/assets/images/people-with-gothic-style-costumes-make-up-performing-drama-world-theatre-day.jpg', // Replace with image path
      'address': '123 Main Street, City, State',
      'phone': '+15551234567',
      'website': 'https://www.venuea.com',
      'description': 'A large event space suitable for conferences.',
    },
    {
      'name': 'Venue B',
      'imageUrl': 'lib/assets/images/people-with-gothic-style-costumes-make-up-performing-drama-world-theatre-day.jpg', // Replace with image path
      'address': '456 Oak Avenue, City, State',
      'phone': '+15559876543',
      'website': 'https://www.venueb.com',
      'description': 'A smaller venue ideal for intimate gatherings.',
    },
    // Add more venue data here
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Venues')),
      body: ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          return _buildVenueCard(context, venues[index]);
        },
      ),
    );
  }

  Widget _buildVenueCard(BuildContext context, Map<String, dynamic> venue) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            venue['imageUrl'],
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  venue['name'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(venue['address']),
                const SizedBox(height: 8.0),
                Text(venue['description']),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () {
                        // Implement phone call logic here (requires permission)
                        print("Calling ${venue['phone']}");
                      },
                    ),
                    // Add a connection button here if needed
                    ElevatedButton(
                      onPressed: () {
                        // Implement connection logic here
                        print("Connecting with ${venue['name']}");
                      },
                      child: const Text('Connect'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
