import 'package:flutter/material.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("add services")));
    ;
  }
}
