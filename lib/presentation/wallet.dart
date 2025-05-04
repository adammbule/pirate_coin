import 'package:flutter/material.dart';
import 'package:Piratecoin/presentation/mainScaffold.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'My Wallet',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _walletHoldings(),
            const SizedBox(height: 24),
            const Text('Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _transactionList(),
            const SizedBox(height: 24),
            const Text('My Movies',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _ownedMovies(),
          ],
        ),
      ),
    );
  }

  Widget _walletHoldings() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.account_balance_wallet, size: 40, color: Colors.blueGrey),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Wallet Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("💰 153.25 PirateCoins", style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionList() {
  // Dummy data; replace with real transactions
  final transactions = [
    {'type': 'Sent', 'amount': '-10.00', 'to': '0xAb12...45', 'date': 'May 1'},
    {'type': 'Received', 'amount': '+25.50', 'to': '0xCd34...78', 'date': 'Apr 30'},
    {'type': 'Bought Movie', 'amount': '-5.00', 'to': 'MovieXYZ', 'date': 'Apr 28'},
  ];

  return SizedBox(
    height: 130,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isReceived = tx['type'] == 'Received';
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                  color: isReceived ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 6),
                Text('${tx['type']} ${tx['amount']}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('To: ${tx['to']}'),
                const SizedBox(height: 4),
                Text('Date: ${tx['date']}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    ),
  );
}


  Widget _ownedMovies() {
    // Dummy movies list; link to actual CoinKeys or media later
    final movieList = [
      {'title': 'Pirate Wars', 'image': 'https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg'},
      {'title': 'Crypto Shadows', 'image': 'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg'},
    ];

    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  movie['image']!,
                  height: 180,
                  width: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(height: 6),
              Text(movie['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          );
        },
      ),
    );
  }
}
