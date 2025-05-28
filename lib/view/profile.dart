import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityProfilePage extends ConsumerWidget {
  const CommunityProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back),
                Icon(Icons.menu),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 24),
              const CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(
                    'lib/assets/images/Google Images 1.png'), // replace with your asset image path
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mrv',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'mrv@gmail.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Edit profile',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),
          const Divider(height: 40, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('My Bookings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Event for you'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Offer & Coupons'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Help and Support'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                Divider(thickness: 1, height: 32),
                const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
              child: const Text(
                'Qnnect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
