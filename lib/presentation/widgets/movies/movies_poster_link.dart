import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesPosterLink extends StatelessWidget {
  final Movie movie;
  const MoviesPosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          height: 180,
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/loaders/loading2.gif'),
          image: NetworkImage(movie.posterPath),
        ),
      ),
    );
  }
}
