import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrowd/view/Event.dart';


import 'package:qrowd/view/controller.dart';
import 'package:qrowd/view/culture.dart';
import 'package:qrowd/view/talents.dart';
final eventImageProvider = StateProvider<File?>((ref) => null);
final talentImageProvider = StateProvider<File?>((ref) => null);
final cultureImageProvider = StateProvider<File?>((ref) => null);

// Add this function to pick an image
Future<File?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  return pickedFile != null ? File(pickedFile.path) : null;
}


final communityProfileProvider = StateNotifierProvider<CommunityProfileNotifier, CommunityProfile>((ref) {
  return CommunityProfileNotifier();
});

class CommunityProfilePage extends ConsumerWidget {
  const CommunityProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityProfile = ref.watch(communityProfileProvider);

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCommunityProfilePage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Community Profile Information
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: communityProfile.profileImage != null
                        ? FileImage(communityProfile.profileImage!)
                        : null,
                    child: communityProfile.profileImage == null
                        ? const Icon(Icons.group, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    communityProfile.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    communityProfile.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // TabBar
            const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(icon: Icon(CupertinoIcons.ticket), text: 'Events'),
                Tab(icon: Icon(Icons.photo), text: 'Talents'),
                Tab(icon: Icon(Icons.info), text: 'Culture'),
              ],
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
          children: [
            EventsPage(),
            TalentPage(),
            CulturePage(),
          ],
        ),
            ),
          ],
        ),
      ),
    );
  }
}
class EditCommunityProfilePage extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cultureController = TextEditingController();

  EditCommunityProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityProfile = ref.watch(communityProfileProvider);

    _nameController.text = communityProfile.name;
    _descriptionController.text = communityProfile.description;
    _cultureController.text = communityProfile.culture;

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Community Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Community Name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _cultureController,
              decoration: const InputDecoration(labelText: 'Culture'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(communityProfileProvider.notifier).updateProfile(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      culture: _cultureController.text,
                    );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}