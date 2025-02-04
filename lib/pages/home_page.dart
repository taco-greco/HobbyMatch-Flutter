import 'package:flutter/material.dart';
import 'package:hobbymatch/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Fake data and API data after
    List<Map<String, String>> entities = [
      {"id": "1", "name": "Entity 1"},
      {"id": "2", "name": "Entity 2"},
      {"id": "3", "name": "Entity 3"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Entities List")),
      body: ListView.builder(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entities[index]["name"]!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(entity: entities[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}