import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.movieDbKey,
      'language': 'es-ES',
    }),
  );

//---------------------------------------------------------------
//----------------------- _JsonToMovies -------------------------
//---------------------------------------------------------------
  List<Movie> _JsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromMap(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
        .toList();
    return movies;
  }

//---------------------------------------------------------------
//----------------------- getNowPlaying -------------------------
//---------------------------------------------------------------

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _JsonToMovies(response.data);
  }

//---------------------------------------------------------------
//----------------------- getPopular ----------------------------
//---------------------------------------------------------------
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _JsonToMovies(response.data);
  }
}
