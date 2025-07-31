import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:glamify/pages/users/admin/admin_dashboard.dart';
import 'package:glamify/pages/users/admin/profile.dart';

class AdminBottomNavBar extends StatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _AdminBottomNavBarState();
}

class _AdminBottomNavBarState extends State<AdminBottomNavBar> {
  late List<Widget> pages;
  late AdminDashboard home;
  late AdminProfile profile;
  late int currentTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    home = AdminDashboard();
    profile = AdminProfile();

    pages = [home, profile];

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
          Icon(Icons.person, color: Colors.white),
          // Icon(Icons.add_box, color: Colors.white),
          // Icon(Icons.history_rounded, color: Colors.white),
        ],
      ),

      body: pages[currentTabIndex],
    );
  }
}
