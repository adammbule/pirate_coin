import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:Piratecoin/features/auth/presentation/bloc/auth_state.dart';
import 'package:Piratecoin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/widgets/theme_widget.dart';

class HomeScreen extends StatelessWidget {
  final User? user;

  const HomeScreen({super.key, this.user});

  Widget _buildSummaryCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      color: kCardColor,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.white38, size: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // 🔹 CASE 1: Authenticated state
        if (state is AuthAuthenticated) {
          final username = state.username.isNotEmpty
              ? state.username
              : user?.username ?? 'Pirate';

          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              title: ShaderMask(
                shaderCallback: (bounds) =>
                    kPirateGradient.createShader(bounds),
                child: Text(
                  "Ahoy, $username!",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none,
                      color: Colors.cyanAccent),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: const HamburgerMenu(),
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: PirateTitle("Dashboard"),
                  ),
                  const SizedBox(height: 20),
                  _buildSummaryCard(
                    icon: Icons.account_balance_wallet,
                    iconColor: Colors.amberAccent,
                    title: "Wallet Balance",
                    subtitle: "₱ 1,234.56",
                    onTap: () => Navigator.pushNamed(context, '/wallet'),
                  ),
                  _buildSummaryCard(
                    icon: Icons.movie,
                    iconColor: Colors.lightBlueAccent,
                    title: "Movies & Series",
                    subtitle: "12 Movies, 5 Series",
                    onTap: () => Navigator.pushNamed(context, '/movies'),
                  ),
                  _buildSummaryCard(
                    icon: Icons.collections_bookmark,
                    iconColor: Colors.greenAccent,
                    title: "My Collection",
                    subtitle: "8 Items",
                    onTap: () => Navigator.pushNamed(context, '/collections'),
                  ),
                  _buildSummaryCard(
                    icon: Icons.store_mall_directory_outlined,
                    iconColor: Colors.purpleAccent,
                    title: "Marketplace",
                    subtitle: "Explore digital treasures",
                    onTap: () => Navigator.pushNamed(context, '/marketplace'),
                  ),
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      "PirateCoin v1.0.0 Ts & Cs Apply",
                      style: TextStyle(color: Colors.white38, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }

        // 🔹 CASE 2: Not authenticated → redirect to login
        else if (state is AuthInitial) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/login');
          });
          return const Scaffold(
            backgroundColor: kBackgroundColor,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
              ),
            ),
          );
        }

        // 🔹 CASE 3: Loading state
        return const Scaffold(
          backgroundColor: kBackgroundColor,
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
            ),
          ),
        );
      },
    );
  }
}
