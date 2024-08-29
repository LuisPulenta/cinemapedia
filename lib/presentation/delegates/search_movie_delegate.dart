import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  //------------------------------------------------------------------------
  void clearStreams() {
    debouncedMovies.close();
  }

  //------------------------------------------------------------------------
  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // if (query.isEmpty) {
      //   debouncedMovies.add([]);
      //   return;
      // }
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  //------------------------------------------------------------------------
  @override
  String get searchFieldLabel => 'Buscar película...';

  //------------------------------------------------------------------------
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingStream.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 20),
                spins: 10,
                infinite: true,
                child: IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    query = '';
                  },
                ),
              );
            } else {
              return FadeIn(
                animate: query.isNotEmpty,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    query = '';
                  },
                ),
              );
            }
          })
    ];
  }

  //------------------------------------------------------------------------
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.white,
      ),
      onPressed: () {
        clearStreams();
        close(context, null);
      },
    );
  }

  //------------------------------------------------------------------------
  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
                movie: movies[index],
                onMovieSelected: (context, movie) {
                  clearStreams();
                  close(context, movie);
                });
          },
        );
      },
    );
  }

  //------------------------------------------------------------------------
  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  //------------------------------------------------------------------------
  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

//------------------------------------------------------
//----------------------- _MovieItem -------------------
//------------------------------------------------------

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) =>
                        //FadeIn(child: child),
                        FadeInImage(
                          height: 150,
                          fit: BoxFit.cover,
                          image: NetworkImage(movie.posterPath),
                          placeholder:
                              const AssetImage('assets/loaders/loading2.gif'),
                        )),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleMedium,
                    ),
                    Text(
                      'Tìtulo original: ${movie.originalTitle}',
                      style: textStyles.labelMedium,
                    ),
                    Text(
                      movie.releaseDate != null
                          ? DateFormat('dd/MM/yyyy').format(movie.releaseDate!)
                          : '',
                      style: textStyles.labelMedium,
                    ),
                    const Divider(),
                    Text(
                      movie.overview,
                      style: textStyles.labelSmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow.shade800,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          HumanFormats.number(movie.voteAverage, 1),
                          style: textStyles.bodyMedium!
                              .copyWith(color: Colors.yellow.shade800),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
