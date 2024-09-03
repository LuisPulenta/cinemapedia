import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

//--------------------------------------------------------------
//------------------------ initState ---------------------------
//--------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

//--------------------------------------------------------------
//------------------------ Pantalla ----------------------------
//--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text('Ohhh no!!!',
                style: TextStyle(
                    color: colors.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text('No tienes películas favoritas',
                style: TextStyle(color: colors.primary, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonal(
              child: const Text('Empieza a buscar'),
              onPressed: () => context.go('/home/0'),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: favoritesMovies),
    );
  }

//--------------------------------------------------------------
//------------------------ loadNextPage ------------------------
//--------------------------------------------------------------

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }
}
