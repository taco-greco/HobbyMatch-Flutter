import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/hobby.dart';

class DetailPage extends StatefulWidget {
  final Hobby entity;

  const DetailPage({super.key, required this.entity});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.entity.titre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.entity.imageFileName != null
                ? Image.network(
              "http://10.0.2.2:8000/uploads/images/${widget.entity.imageRepository}/${widget.entity.imageFileName}",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
            )
                : const SizedBox(),
            const SizedBox(height: 10),
            Text("Author: ${widget.entity.id}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Author: ${widget.entity.auteur}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Description:\n${widget.entity.description}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Published on: ${widget.entity.datePublication}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            if (widget.entity.prix != null) Text("Price: \€${widget.entity.prix}", style: const TextStyle(fontSize: 14)),
            if (widget.entity.emailContact != null) Text("Contact: ${widget.entity.emailContact}", style: const TextStyle(fontSize: 14)),
            if (widget.entity.latitude != null && widget.entity.longitude != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location: (${widget.entity.latitude}, ${widget.entity.longitude})", style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10),
          ],
        ),
    ]
      ),
    ));
    }
}