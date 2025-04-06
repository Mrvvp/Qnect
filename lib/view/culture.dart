import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/view/profile.dart';

class CulturePage extends ConsumerWidget {
  const CulturePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communityProfile = ref.watch(communityProfileProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Section for Culture Images
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement culture image upload logic.
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Upload Culture Image'),
          ),
          const SizedBox(height: 16),
          // Culture Details
          Text(
            'Culture: ${communityProfile.culture}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
