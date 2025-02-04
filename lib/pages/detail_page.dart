import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> entity;

  const DetailPage({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entity["name"]!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${entity["id"]}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Name: ${entity["name"]}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}