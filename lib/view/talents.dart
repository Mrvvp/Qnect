import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/view/profile.dart';

class TalentPage extends ConsumerWidget {
  const TalentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityProfile = ref.watch(communityProfileProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Upload Section for Gallery Images
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement gallery image upload logic.
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Gallery Image'),
          ),
          const SizedBox(height: 16),
          // Display Gallery Media
          Column(
            children: communityProfile.media.map((media) {
              if (media['type'] == 'image') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.file(
                    media['file'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (media['type'] == 'video') {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Icon(Icons.video_library, size: 100),
                );
              }
              return const SizedBox.shrink();
            }).toList(),
          ),
        ],
      ),
    );
  }
}
