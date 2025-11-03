import 'package:Piratecoin/features/shows/domain/entities/show.dart'
    as show_entity;
import 'package:dio/dio.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';

class ShowRemoteDataSource {
  final Dio dio;
  final SecureStorage storage;

  ShowRemoteDataSource({
    required this.dio,
    required this.storage,
  });

  /// Fetch the user's Show collection
  Future<List<show_entity.Show>> fetchShowCollection() async {
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

        // Assume API returns a list of Shows, either directly or inside "results"
        final List<dynamic> ShowsJson =
            data is List ? data : (data['results'] ?? data);

        final myShowCollection =
            ShowsJson.map((json) => show_entity.Show.fromJson(json)).toList();

        return myShowCollection;
      } else {
        throw Exception("Fetch user collection failed: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Fetch collection error: ${e.message}");
    }
  }

  /// Fetch trending Shows
  Future<List<show_entity.Show>> fetchTrendingShows() async {
    try {
      final response = await dio.get(
        "https://piratenode.onrender.com/api/series/trendingseries",
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
        final List<dynamic> ShowsJson =
            data is List ? data : (data['results'] ?? []);

        return ShowsJson.map((json) => show_entity.Show.fromJson(json))
            .toList();
      } else {
        throw Exception(
          "Fetch trending Shows failed: ${response.statusCode} - ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Fetch trending Shows error: ${e.message}");
    }
  }

  Future<List<show_entity.Show>> fetchFreshReleases() async {
    try {
      final response = await dio.get(
        // "https://piratenode.onrender.com/api/Shows/freshreleases",
        "https://piratenode.onrender.com/api/series/trendingseries",
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
        final List<dynamic> ShowsJson =
            data is List ? data : (data['results'] ?? []);

        return ShowsJson.map((json) => show_entity.Show.fromJson(json))
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

  Future<List<show_entity.Show>> fetchPopularShows() async {
    try {
      final response = await dio.get(
        // "https://piratenode.onrender.com/api/Shows/freshreleases",
        "https://piratenode.onrender.com/api/series/trendingseries",
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
        final List<dynamic> ShowsJson =
            data is List ? data : (data['results'] ?? []);

        return ShowsJson.map((json) => show_entity.Show.fromJson(json))
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

  Future<String?> getSavedToken() async {
    return await storage.getToken();
  }
}
