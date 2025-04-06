import 'package:flutter/material.dart';// Import for launching URLs

class SponserPage extends StatelessWidget {
   SponserPage({super.key});

  final List<Map<String, dynamic>> sponsors = [
    {
     
      'logoUrl': 'lib/assets/images/pngwing.com (2).png', // Replace with image path
      'website': 'https://www.sponsorA.com',
    },
    {
      
      'logoUrl': 'lib/assets/images/pngwing.com.png', // Replace with image path
      'website': 'https://www.sponsorB.com',
    },
    {
     
      'logoUrl': 'lib/assets/images/pngwing.com (1).png', // Replace with image path
      'website': 'https://www.sponsorC.com',
    },
    // Add more sponsors here
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sponsors')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          childAspectRatio: 1.0, // Adjust aspect ratio as needed
        ),
        itemCount: sponsors.length,
        itemBuilder: (context, index) {
          return _buildSponsorItem(context, sponsors[index]);
        },
      ),
    );
  }

  Widget _buildSponsorItem(BuildContext context, Map<String, dynamic> sponsor) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              sponsor['logoUrl'],
              height: 100, // Adjust as needed
              width: 100,  // Adjust as needed
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8.0),
            
          ],
        ),
      ),
    );
  }
}
