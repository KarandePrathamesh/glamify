import 'package:flutter/material.dart';

class BookingsHistory extends StatefulWidget {
  const BookingsHistory({super.key});

  @override
  State<BookingsHistory> createState() => _BookingsHistoryState();
}

class _BookingsHistoryState extends State<BookingsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Bookings History")));
  }
}
