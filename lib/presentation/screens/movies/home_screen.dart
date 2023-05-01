import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: const _HomeView(),
    );
  }
}

//-------------------------------------------------------
//--------------------_HomeView -------------------------
//-------------------------------------------------------

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
//-------------------------------------------------------
//-------------------- initState ------------------------
//-------------------------------------------------------

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

//-------------------------------------------------------
//--------------------Pantalla --------------------------
//-------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    if (nowPlayingMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: ListView.builder(
        itemCount: nowPlayingMovies.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(nowPlayingMovies[index].title),
        ),
      ),
    );
  }
}
