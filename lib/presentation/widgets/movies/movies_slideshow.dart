import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          pagination: SwiperPagination(
              margin: const EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary, color: colors.inversePrimary)),
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(movie: movies[index])),
    );
  }
}

//-------------------------------------------------
//------------------- _Slide ----------------------
//-------------------------------------------------
class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white38,
            blurRadius: 5,
            offset: Offset(5, 5),
          ),
        ]);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: DecoratedBox(
            decoration: decoration,
            child: GestureDetector(
              onTap: () => context.push('/home/0/movie/${movie.id}'),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    movie.backdropPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return DecoratedBox(
                          decoration:
                              const BoxDecoration(color: Colors.white60),
                          child: Container(
                            height: 180,
                          ),
                        );
                      }
                      return FadeIn(child: child);
                    },
                  )),
            ),
          ),
        ),
        FittedBox(
          child: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
