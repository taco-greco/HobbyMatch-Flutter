import 'package:flutter/material.dart';
import '../models/hobby.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Hobby>> futureHobbies;

  @override
  void initState() {
    super.initState();
    futureHobbies = ApiService.fetchHobbies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hobbies List")),
      body: FutureBuilder<List<Hobby>>(
        future: futureHobbies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hobbies found"));
          }

          List<Hobby> hobbies = snapshot.data!;

          return ListView.builder(
            itemCount: hobbies.length,
            itemBuilder: (context, index) {
              Hobby hobby = hobbies[index];

              return ListTile(
                leading: hobby.imageFileName != null
                    ? Image.network(
                  "http://10.0.2.2:8000/uploads/images/${hobby.imageRepository}/${hobby.imageFileName}",
                  height: 300,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
                )
                    : const Icon(Icons.image),
                title: Text(hobby.titre),
                subtitle: Text("Author: ${hobby.auteur}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(entity: hobby),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
