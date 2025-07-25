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

  //**Bottom navigation bar
  int _selectedIndexBottomNavBar = 0;

  // Screens for each tab
  static final List<Widget> _pages = <Widget>[
    const Center(child: Text('🏠 Home')),
    const Center(child: Text('🔍 Explore')),
    const Center(child: Text('📅 Bookings')),
    const Center(child: Text('👤 Profile')),
  ];

  void _onItemTappedBottomNavBar(int index) {
    setState(() {
      _selectedIndexBottomNavBar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide.none),
                color: Color(0xff636362),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(40),
                ),
              ),
              curve: Curves.fastOutSlowIn,
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  ClipOval(
                    child: Image.asset(
                      './assets/images/glamify_logo.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Barber Dashboard',
                    style: TextStyle(color: Colors.white, fontSize: 24),
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

      //  **new bottom navigaton bar**
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndexBottomNavBar,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        onTap: _onItemTappedBottomNavBar,
        type:
            BottomNavigationBarType
                .shifting, // use shifting if you want animations
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
