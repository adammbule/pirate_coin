import 'package:Piratecoin/features/movies/domain/entities/movie.dart'
    as movie_entity;
import 'package:dio/dio.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class MovieRemoteDataSource {
  final Dio dio;
  final SecureStorage storage;

  MovieRemoteDataSource({
    required this.dio,
    required this.storage,
  });

  /// Fetch the user's movie collection
  Future<List<movie_entity.Movie>> fetchMovieCollection() async {
    try {
      final response = await dio.post(
        "https://piratenode.onrender.com/api/wallet/holdings/6802c5565ba9cffed4befac6",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await storage.getToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Assume API returns a list of movies, either directly or inside "results"
        final List<dynamic> moviesJson =
            data is List ? data : (data['results'] ?? data);

        final myMovieCollection = moviesJson
            .map((json) => movie_entity.Movie.fromJson(json))
            .toList();

        return myMovieCollection;
      } else {
        throw Exception("Fetch user collection failed: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Fetch collection error: ${e.message}");
    }
  }

  /// Fetch trending movies
  Future<List<movie_entity.Movie>> fetchTrendingMovies() async {
    try {
      final response = await dio.get(
        "https://piratenode.onrender.com/api/movies/trendingmovies",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await storage.getToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Adjust this depending on API response
        final List<dynamic> moviesJson =
            data is List ? data : (data['results'] ?? []);

        return moviesJson
            .map((json) => movie_entity.Movie.fromJson(json))
            .toList();
      } else {
        throw Exception(
          "Fetch trending movies failed: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Fetch trending movies error: ${e.message}");
    }
  }

  Future<List<movie_entity.Movie>> fetchFreshReleases() async {
    try {
      final response = await dio.get(
        // "https://piratenode.onrender.com/api/movies/freshreleases",
        "https://piratenode.onrender.com/api/movies/trendingmovies",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await storage.getToken()}',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Adjust this depending on API response
        final List<dynamic> moviesJson =
            data is List ? data : (data['results'] ?? []);

        return moviesJson
            .map((json) => movie_entity.Movie.fromJson(json))
            .toList();
      } else {
        throw Exception(
          "Fetch fresh releases failed: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Fetch fresh releases error: ${e.message}");
    }
  }

  Future<void> fetchPopularMovies(String token) async {
    // TODO: implement popular shows API call
  }

  Future<String?> getSavedToken() async {
    return await storage.getToken();
  }
}
