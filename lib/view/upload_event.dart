import 'dart:io';

import 'package:flutter/material.dart';

class CreateEventPage extends StatelessWidget {
  final File? capturedImage;

  const CreateEventPage({super.key, this.capturedImage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display Captured Image
            if (capturedImage != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(capturedImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 16),
            // Event Title Input
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Event Title'),
            ),
            const SizedBox(height: 16),
            // Event Date Input
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Event Date'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // TODO: Save the event and navigate back
                final newEvent = {
                  'title': titleController.text,
                  'date': dateController.text,
                  'image': capturedImage,
                };

                // For now, simulate saving the event
                print('New Event Created: $newEvent');

                Navigator.pop(context); // Go back to EventsPage
              },
              child: const Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}