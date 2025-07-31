import 'package:flutter/material.dart';
import 'package:glamify/pages/auth/login.dart';
import 'package:glamify/pages/users/barber/create_business_profile.dart';

class BarberDashboard extends StatefulWidget {
  const BarberDashboard({super.key});

  @override
  State<BarberDashboard> createState() => _BarberDashboardState();
}

class _BarberDashboardState extends State<BarberDashboard> {
  // Logout functionality
  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false, // Clears navigation history
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        elevation: 2,
        backgroundColor: Color(0xff191B06),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(
          'Logged out successfully',
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // **Drawer Code*
  int selectedIndex = 0;
  final List<Widget> screens = [
    const Center(child: Text("Salon Shops coming soon...")),
  ];
  void onNavItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.6,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(color: Color(0xff191B06)),
              curve: Curves.fastOutSlowIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 125,
                    width: 140,
                    child: Image.asset(
                      'assets/images/glamify_logo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'View Business Profile',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 0,
              onTap: () => onNavItemTap(0),
            ),
            ListTile(
              title: const Text(
                'Update Business Profile',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 1,
              onTap: () => onNavItemTap(1),
            ),
            ListTile(
              title: const Text(
                'Today\'s Sale !',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 1,
              onTap: () => onNavItemTap(1),
            ),
            ListTile(
              title: const Text(
                'Privacy Policies',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => {},
            ),
            ListTile(
              title: const Text(
                'Terms & Conditions',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => {},
            ),
            ListTile(
              title: const Text(
                'Deactivate Profile',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => {},
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => logout(context),
            ),
          ],
        ),
      ),

      appBar: AppBar(title: Text('Barber Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.black, // Adjust padding
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBusinessProfile(),
                  ),
                );
              },
              child: Text(
                'Create Business Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.black, // Adjust padding
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/showProfile');
              },

              child: Text(
                'Show Business Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 40),

            Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/glamify_logo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                // Icon(Icons.image, size: 50, color: Colors.grey),
                Text(
                  "Glamify",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
