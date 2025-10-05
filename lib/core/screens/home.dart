import 'package:flutter/material.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart'; // import your User model
import 'package:Piratecoin/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/features/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User user; // ✅ Accept user from login

  const HomeScreen({super.key, required this.user});

  Widget _walletSummary() {
    return const Card(
      margin: EdgeInsets.all(12),
      child: ListTile(
        leading: Icon(Icons.account_balance_wallet, color: Colors.amber),
        title: Text('Wallet Balance'),
        subtitle: Text('₱ 1,234.56'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _moviesSeriesSummary() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(Icons.movie, color: Colors.blueAccent),
        title: Text('Movies & Series'),
        subtitle: Text('12 Movies, 5 Series'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _myCollection() {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Icon(Icons.collections, color: Colors.green),
        title: Text('My Collection'),
        subtitle: Text('8 Items'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Welcome ${user.username}'),
            ),
            drawer: const HamburgerMenu(),
            body: ListView(
              children: [
                const SizedBox(height: 16),
                _walletSummary(),
                _moviesSeriesSummary(),
                _myCollection(),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
