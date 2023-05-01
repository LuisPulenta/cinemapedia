import 'package:flutter/material.dart';
import 'package:cinemapedia/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinemapedia'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(Environment.movieDbKey),
      ),
    );
  }
}
