import 'package:flutter/material.dart';
import 'package:hobbymatch/pages/home_page.dart';
import 'package:location/location.dart';

import 'models/device_info.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Location location = new Location();

  bool _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  PermissionStatus _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  LocationData _locationData = await location.getLocation();
  DeviceInfo.latitude = _locationData.latitude;
  DeviceInfo.longitude = _locationData.longitude;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
