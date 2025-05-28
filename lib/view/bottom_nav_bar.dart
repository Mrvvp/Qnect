import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/view%20model/bottom_view_model.dart';
import 'package:qrowd/view/bookings.dart';
import 'package:qrowd/view/community.dart';
import 'package:qrowd/view/map.dart';
import 'package:qrowd/view/profile.dart';

class BottomNavBarScreen extends ConsumerWidget {
  const BottomNavBarScreen({super.key});

  static final List<Widget> _pages = <Widget>[
    const CustomMapPage(),
    CommunityPage(),
    BookingPage(),
    CommunityProfilePage()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // 👈 transparent so content can go behind notch
        statusBarIconBrightness:
            Brightness.dark, // 👈 or light based on background
      ),
      child: Scaffold(
        extendBody:
            true, // 👈 important to extend body behind BottomNavigationBar
        backgroundColor: Colors.white, // 👈 your app background
        body: SafeArea(
          top: false, // 👈 allow body to go *behind* the notch
          child: _pages[selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  selectedIndex == 0 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  'lib/assets/images/pin.png',
                  width: 20,
                  height: 20,
                ),
              ),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  selectedIndex == 1 ? Colors.black : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: Icon(CupertinoIcons.search),
              ),
              label: 'Qnnect',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ticket),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          onTap: (index) =>
              ref.read(bottomNavProvider.notifier).changeIndex(index),
        ),
      ),
    );
  }
}
