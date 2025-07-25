import 'package:flutter/material.dart';
import 'package:glamify/pages/auth/login.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // logout Functionality
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

  int selectedIndex = 0;

  final List<Widget> screens = [
    const UsersTable(),
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
      appBar: AppBar(title: const Text("Admin Panel")),

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
              title: const Text('Users'),
              selected: selectedIndex == 0,
              onTap: () => onNavItemTap(0),
            ),
            ListTile(
              title: const Text('Salon Shops'),
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

      body: screens[selectedIndex],

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

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

  final List<Map<String, String>> users = const [
    {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "role": "User",
      "status": "Active",
    },
    {
      "name": "Jane Smith",
      "email": "jane.smith@example.com",
      "role": "User",
      "status": "Active",
    },
    {
      "name": "Michael Johnson",
      "email": "michael.johnson@example.com",
      "role": "User",
      "status": "Active",
    },
    {
      "name": "Emily Brown",
      "email": "emily.brown@example.com",
      "role": "User",
      "status": "Active",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(child: InfoCard(title: "Total Users", value: "105")),
              SizedBox(width: 20),
              Expanded(
                child: InfoCard(title: "Total Barber Shops", value: "38"),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SearchBarWidget(),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Role")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows:
                      users
                          .map(
                            (user) => DataRow(
                              cells: [
                                DataCell(Text(user["name"]!)),
                                DataCell(Text(user["email"]!)),
                                DataCell(Text(user["role"]!)),
                                DataCell(Text(user["status"]!)),
                              ],
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[700])),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search users",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
