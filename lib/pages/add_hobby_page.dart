import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hobbymatch/models/device_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddHobbyPage extends StatefulWidget {
  final String token;

  const AddHobbyPage({super.key, required this.token});

  @override
  State<AddHobbyPage> createState() => _AddHobbyPageState();
}

class _AddHobbyPageState extends State<AddHobbyPage> {
  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _auteurController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _prixController = TextEditingController();
  final _emailController = TextEditingController();
  String? _base64Image;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/ApiHobby/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({
          'Titre': _titreController.text,
          'Auteur': _auteurController.text,
          'Description': _descriptionController.text,
          'DatePublication': _dateController.text,
          'Image': _base64Image ?? '',
          'Prix': _prixController.text,
          'EmailContact': _emailController.text,
          'Latitude': DeviceInfo.latitude,
          'Longitude': DeviceInfo.longitude,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true); // Return to the previous page with a result
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Hobby')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titreController,
                decoration: const InputDecoration(labelText: 'Titre'),
              ),
              TextFormField(
                controller: _auteurController,
                decoration: const InputDecoration(labelText: 'Auteur'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date Publication'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
              TextFormField(
                controller: _prixController,
                decoration: const InputDecoration(labelText: 'Prix'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Contact'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: const Text('Pick Image from Gallery'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImageFromCamera,
                child: const Text('Take Photo with Camera'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}