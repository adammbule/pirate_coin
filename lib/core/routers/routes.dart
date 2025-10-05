import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:Piratecoin/features/movies/presentation/pages/trending_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:Piratecoin/core/screens/start.dart';
import 'package:Piratecoin/features/auth/presentation/pages/login_page.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:Piratecoin/features/auth/presentation/pages/register_page.dart';
import 'package:Piratecoin/features/movies/presentation/pages/movies_details_page.dart';
import 'package:Piratecoin/features/shows/presentation/pages/trending_shows_page.dart';
import 'package:Piratecoin/features/shows/presentation/pages/show_details_page.dart';
import 'package:Piratecoin/features/wallet/presentation/pages/wallet_page.dart';
import 'package:Piratecoin/core/screens/placeholder_page.dart';
import 'package:Piratecoin/core/screens/home.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart';

class AppRoutes {
  static const start = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const movies = '/movies';
  static const shows = '/shows';
  static const showDetails = '/showDetails';
  static const movieDetails = '/movieDetails';
  static const wallet = '/wallet';
  static const marketplace = '/marketplace';
  static const collections = '/collections';
  static const logout = '/logout';

  static Map<String, WidgetBuilder> routes = {
    start: (context) => const StartScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) =>
        HomeScreen(user: User(username: 'Guest', token: '', userid: '')),
    movies: (context) => TrendingMovieScreen(),
    shows: (context) => const TrendingShowScreen(),
    showDetails: (context) => const ShowDetailsScreen(
        title: '',
        plot: '',
        releasedDate: '',
        runtime: '',
        backgroundImageUrl: ''),
    movieDetails: (context) => const MovieDetailsScreen(
          title: '',
          plot: '',
          releasedDate: '',
          runtime: '',
          backgroundImageUrl: '',
        ),
    wallet: (context) => const WalletScreen(),
    marketplace: (context) => const PlaceholderScreen(title: 'Marketplace'),
    collections: (context) => const PlaceholderScreen(title: 'Collections'),
    logout: (context) {
      final storage = SecureStorage();
      storage.clearToken();
      // Navigate to login screen after logout
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  };
}
