import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:glamify/pages/users/barber/add_services.dart';
import 'package:glamify/pages/users/barber/barber_dashboard.dart';
import 'package:glamify/pages/users/barber/bookings_history.dart';
import 'package:glamify/pages/users/barber/create_business_profile.dart';
import 'package:glamify/pages/users/barber/view_business_profile.dart';

class BarberBottomNavBar extends StatefulWidget {
  const BarberBottomNavBar({super.key});

  @override
  State<BarberBottomNavBar> createState() => _BarberBottomNavBarState();
}

class _BarberBottomNavBarState extends State<BarberBottomNavBar> {
  late List<Widget> pages;
  late BarberDashboard home;
  late ViewBusinessProfile viewBusinessProfile;
  late AddServices addServices;
  late BookingsHistory bookingsHistory;
  late int currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    home = BarberDashboard();
    viewBusinessProfile = ViewBusinessProfile();
    addServices = AddServices();
    bookingsHistory = BookingsHistory();
    pages = [home, viewBusinessProfile, addServices, bookingsHistory];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.transparent,
        color: Color(0xff191B06),
        animationDuration: Duration(milliseconds: 600),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.business_center_rounded, color: Colors.white),
          Icon(Icons.add_box, color: Colors.white),
          Icon(Icons.history_rounded, color: Colors.white),
        ],
      ),

      body: pages[currentTabIndex],
    );
  }
}
