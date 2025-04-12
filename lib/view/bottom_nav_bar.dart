import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/view%20model/bottom_view_model.dart';
import 'package:qrowd/view/bookings.dart';
import 'package:qrowd/view/community.dart';
import 'package:qrowd/view/map.dart';
import 'package:qrowd/view/profile.dart';

class BottomNavBarScreen extends ConsumerWidget {
  const BottomNavBarScreen({super.key});

  static final List<Widget> _pages = <Widget>[
    CommunityPage(),
    const CustomMapPage(),
    BookingPage(),
     CommunityProfilePage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: _pages[selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex == 0
                    ? Colors.black
                    : Colors.grey, // Change color based on selection
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'lib/assets/images/magnifying-glass.png',
                width: 24,
                height: 24,
              ),
            ),
            label: 'Qnect',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                selectedIndex == 1 ? Colors.black : Colors.grey,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'lib/assets/images/pin.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Live Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ticket),
            label: 'Bookings',
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey, // Unselected icon and label color
        selectedItemColor: Colors.black, // Selected icon and label color
        onTap: (index) =>
            ref.read(bottomNavProvider.notifier).changeIndex(index),
      ),
    );
  }
}
