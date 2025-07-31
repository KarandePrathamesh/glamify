import 'package:flutter/material.dart';
import 'package:glamify/pages/users/customer/men_services.dart';
import 'package:glamify/pages/users/customer/women_services.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SalonDetails extends StatefulWidget {
  final String name;
  final String distance;
  final String imageUrl;

  const SalonDetails({
    super.key,
    required this.name,
    required this.distance,
    required this.imageUrl,
  });

  @override
  State<SalonDetails> createState() => _SalonDetailsState();
}

class _SalonDetailsState extends State<SalonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salon Image
            Container(
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Salon Name
            Text(
              widget.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Address: lorem ipsum lorem ipsum lorem ipsum",
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      LucideIcons.mapPin,
                      color: Colors.black54,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.distance,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Services Section
            const Text(
              "Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ServiceButton(
                    icon: Icons.male,
                    text: "Services for Men",
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenServicesPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  ServiceButton(
                    icon: Icons.female,
                    text: "Services for Women",
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WomenServicesPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // App Logo Placeholder
            Center(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/glamify_logo.png',
                      height: 90,
                      width: 90,
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
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed; // Added onPressed parameter

  const ServiceButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed, // Required callback function
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      onPressed: onPressed, // Now accepts the function dynamically
    );
  }
}
