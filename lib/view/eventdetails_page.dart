import 'package:flutter/material.dart';

class EventdetailsPage extends StatelessWidget {
  const EventdetailsPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                'lib/assets/images/pexels-teddy-2263436.jpg',
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16.0),
            Padding( 
              padding: const EdgeInsets.all(10.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Annual Music Festival',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   const SizedBox(height: 8.0),
            const Text(
              'Join us for our annual music festival, featuring live performances from renowned artists. Enjoy a day filled with great music, delicious food, and fun activities for the whole family.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Venue:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'City Park Amphitheater, 123 Main Street, Anytown USA',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Ticket Information:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Fare: 50/-',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Featured Artists:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'John Doe, Jane Smith, Bob Johnson, Alice Williams',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
