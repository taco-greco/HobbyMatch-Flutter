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
  final ScrollController _scrollController = ScrollController();
  List<Hobby> _hobbies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchHobbies();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchHobbies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Hobby> newHobbies = await ApiService.fetchHobbies(_currentPage);
      setState(() {
        _hobbies = newHobbies;
        _currentPage++;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMoreHobbies() async {
    if (_isFetchingMore) return;
    setState(() {
      _isFetchingMore = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2)); // Add delay
      List<Hobby> newHobbies = await ApiService.fetchHobbies(_currentPage);
      setState(() {
        _hobbies.addAll(newHobbies);
        _currentPage++;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isFetchingMore = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0 && !_isFetchingMore) {
      _fetchMoreHobbies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hobbies')),
      body: _isLoading && _hobbies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: _hobbies.length + (_isFetchingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _hobbies.length) {
            return const Center(child: CircularProgressIndicator());
          }
          Hobby hobby = _hobbies[index];
          return ListTile(
            leading: hobby.imageFileName != null
                ? Image.network(
              "http://10.0.2.2:8000/uploads/images/${hobby.imageRepository}/${hobby.imageFileName}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
            )
                : const Icon(Icons.image),
            title: Text(hobby.titre),
            subtitle: Text(hobby.description),
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
      ),
    );
  }
}