import 'package:flutter/material.dart';

class WomenServicesPage extends StatelessWidget {
  const WomenServicesPage({super.key});

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
        title: const Text(
          "Services for Women’s",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: "Haircut Services"),
              ServiceGrid(
                services: ["Haircuts", "Hair Treatments", "Hair Coloring"],
              ),
              const SectionTitle(title: "Skin Services"),
              ServiceGrid(services: ["Facials", "Body Polish", "Body Scrub"]),
              const SectionTitle(title: "Body Services"),
              ServiceGrid(
                services: ["Full Body Massage", "Pedicures", "Manicures"],
              ),
              const SectionTitle(title: "Other Services"),
              ServiceGrid(
                services: ["Waxing", "Tanning", "Hair Removal", "Aromatherapy"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget to display a section title
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget for displaying services in a grid
class ServiceGrid extends StatelessWidget {
  final List<String> services;

  const ServiceGrid({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceCard(serviceName: services[index]);
      },
    );
  }
}

// Widget for each service card
class ServiceCard extends StatelessWidget {
  final String serviceName;

  const ServiceCard({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image,
            size: 40,
            color: Colors.grey,
          ), // Placeholder image
          const SizedBox(height: 5),
          Text(
            serviceName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
