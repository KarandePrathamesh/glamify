import 'package:flutter/material.dart';
import 'package:glamify/pages/auth/login.dart';
import 'package:glamify/pages/users/customer/Salondetails.dart';

// import of geolocator to take users location in latitude and longitude
import 'package:geolocator/geolocator.dart';

class NearBySalon extends StatefulWidget {
  const NearBySalon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NearBySalonState createState() => _NearBySalonState();
}

class _NearBySalonState extends State<NearBySalon> {
  // Sample list of salons with images
  List<Map<String, String>> salons = [
    {
      'name': 'Xyz Salon 1',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
    {
      'name': 'Xyz Salon 2',
      'distance': '10m',
      'image': 'assets/images/salon_2.jpg',
    },
    {
      'name': 'Xyz Salon 3',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
    {
      'name': 'Xyz Salon 4',
      'distance': '10m',
      'image': 'assets/images/salon_2.jpg',
    },
    {
      'name': 'Xyz Salon 5',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
    {
      'name': 'Xyz Salon 6',
      'distance': '10m',
      'image': 'assets/images/salon_2.jpg',
    },
    {
      'name': 'Xyz Salon 7',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
    {
      'name': 'Xyz Salon 8',
      'distance': '10m',
      'image': 'assets/images/salon_2.jpg',
    },
    {
      'name': 'Xyz Salon 9',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
    {
      'name': 'Xyz Salon 10',
      'distance': '10m',
      'image': 'assets/images/salon_2.jpg',
    },
    {
      'name': 'Xyz Salon 11',
      'distance': '10m',
      'image': 'assets/images/salon_1.jpg',
    },
  ];

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

  // variables to store lat and lang cordinates
  double? latitude;
  double? longitude;

  // code of lat/lang
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return;
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied.");
      return;
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    debugPrint("Latitude: $latitude, Longitude: $longitude");
  }

  // **user location widget**
  // Widget _buildLocationWidget() {
  //   return Center(
  //     child: latitude == null || longitude == null
  //         ? const Text("Fetching location...")
  //         : Text("Latitude: $latitude, Longitude: $longitude"),
  //   );
  // }

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

  // ** Build Method **
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
                      'assets/images/glamify_logo.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'User Settings',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text(
                'View Profile',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 0,
              onTap: () => onNavItemTap(0),
            ),
            ListTile(
              title: const Text(
                'Update Profile',
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
              onTap: () => onNavItemTap(2),
            ),
            ListTile(
              title: const Text(
                'Terms & Conditions',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => onNavItemTap(2),
            ),
            ListTile(
              title: const Text(
                'Deactivate Profile',
                style: TextStyle(color: Colors.black, fontSize: 14.5),
              ),
              selected: selectedIndex == 2,
              onTap: () => onNavItemTap(2),
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

      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Near by Salon',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: salons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85, // Adjust height
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            if (index < salons.length) {
              return SalonCard(
                name: salons[index]['name']!,
                distance: salons[index]['distance']!,
                imageUrl: salons[index]['image']!,
              );
            } else {
              return const SalonCard(
                name: 'Coming Soon',
                distance: '',
                imageUrl: 'assets/images/Salon_2.jpg', // Placeholder
              );
            }
          },
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

class SalonCard extends StatelessWidget {
  final String name;
  final String distance;
  final String imageUrl;

  const SalonCard({
    super.key,
    required this.name,
    required this.distance,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => SalonDetails(
                  name: name,
                  distance: distance,
                  imageUrl: imageUrl,
                ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salon Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
