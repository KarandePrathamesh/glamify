import 'package:flutter/material.dart';
import 'package:glamify/pages/users/customer/bookings.dart';
import 'package:glamify/pages/users/customer/near_by_salon.dart';
import 'package:glamify/pages/users/customer/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  late List<Widget> pages;
  late NearBySalon home;
  late Bookings booking;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    home = NearBySalon();
    booking = Bookings();
    profile = Profile();
    pages = [home, booking, profile];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        color: Color(0xff191B06),
        animationDuration: Duration(milliseconds: 600),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.book, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),

      body: pages[currentTabIndex],
    );
  }
}
