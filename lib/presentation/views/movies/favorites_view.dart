import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(body: MovieMasonry(movies: favoritesMovies));
  }
}
