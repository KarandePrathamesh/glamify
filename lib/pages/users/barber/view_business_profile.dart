import 'package:flutter/material.dart';

class ViewBusinessProfile extends StatefulWidget {
  const ViewBusinessProfile({super.key});

  @override
  State<ViewBusinessProfile> createState() => _ViewBusinessProfileState();
}

class _ViewBusinessProfileState extends State<ViewBusinessProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("View Business Profile")));
  }
}
