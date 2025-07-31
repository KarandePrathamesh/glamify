import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Eggfruit',
    'Fig',
    'Grapes',
  ];

  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  void filterSearch(String query) {
    final results =
        allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
    setState(() => filteredItems = results);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: filterSearch,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder:
                (_, index) => ListTile(title: Text(filteredItems[index])),
          ),
        ),
      ],
    );
  }
}
