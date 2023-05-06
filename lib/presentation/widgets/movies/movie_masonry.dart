import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;
  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  //----------------------------------------------------
  //--------------------- initState --------------------
  //----------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //----------------------------------------------------
  //-------------------- Pantalla ----------------------
  //----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                MoviesPosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return MoviesPosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
