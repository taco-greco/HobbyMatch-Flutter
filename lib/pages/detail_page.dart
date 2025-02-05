import 'package:flutter/material.dart';
import '../models/hobby.dart';

class DetailPage extends StatelessWidget {
  final Hobby entity;

  const DetailPage({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(entity.titre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            entity.imageFileName != null
                ? Image.network(
              "http://hobbymatch.localhost/${entity.imageRepository}/${entity.imageFileName}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
            )
                : const SizedBox(),
            const SizedBox(height: 10),
            Text("Author: ${entity.auteur}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Description:\n${entity.description}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Published on: ${entity.datePublication}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            if (entity.prix != null) Text("Price: \$${entity.prix}", style: const TextStyle(fontSize: 14)),
            if (entity.emailContact != null) Text("Contact: ${entity.emailContact}", style: const TextStyle(fontSize: 14)),
            if (entity.latitude != null && entity.longitude != null)
              Text("Location: (${entity.latitude}, ${entity.longitude})", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
