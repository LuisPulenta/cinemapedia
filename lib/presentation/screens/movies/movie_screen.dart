import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final String movieId;
  const MovieScreen({Key? key, required this.movieId}) : super(key: key);
  static const String name = 'movie_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId: $movieId'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('MovieId: $movieId'),
      ),
    );
  }
}
