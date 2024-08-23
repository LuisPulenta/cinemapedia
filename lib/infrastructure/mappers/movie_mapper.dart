import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(
          MovieMovieDB moviedb, String desde, String hasta) =>
      Movie(
          adult: moviedb.adult,
          backdropPath: moviedb.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
          genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
          id: moviedb.id,
          originalLanguage: moviedb.originalLanguage,
          originalTitle: moviedb.originalTitle,
          overview: moviedb.overview,
          popularity: moviedb.popularity,
          posterPath: moviedb.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
          releaseDate: moviedb.releaseDate,
          title: moviedb.title,
          video: moviedb.video,
          voteAverage: moviedb.voteAverage,
          voteCount: moviedb.voteCount,
          desde: desde,
          hasta: hasta);

  static Movie movieDetailsToEntity(
          MovieDetails moviedb, String desde, String hasta) =>
      Movie(
          adult: moviedb.adult,
          backdropPath: (moviedb.backdropPath != '')
              ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
          genreIds: moviedb.genres.map((e) => e.name).toList(),
          id: moviedb.id,
          originalLanguage: moviedb.originalLanguage,
          originalTitle: moviedb.originalTitle,
          overview: moviedb.overview,
          popularity: moviedb.popularity,
          posterPath: (moviedb.posterPath != '' && moviedb.posterPath != null)
              ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
          releaseDate: moviedb.releaseDate,
          title: moviedb.title,
          video: moviedb.video,
          voteAverage: moviedb.voteAverage,
          voteCount: moviedb.voteCount,
          desde: desde,
          hasta: hasta);
}
