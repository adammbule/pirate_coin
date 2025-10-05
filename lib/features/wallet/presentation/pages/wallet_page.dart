import 'package:flutter/material.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';

class WalletScreen extends StatelessWidget {
  final int coinCount;
  final List<MediaItem> collection;

  const WalletScreen({
    super.key,
    this.coinCount = 0,
    this.collection = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      drawer: const HamburgerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.monetization_on,
                    size: 40, color: Colors.amber),
                title: const Text('Coins'),
                subtitle: Text(
                  '$coinCount',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'My Collection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: collection.isEmpty
                  ? const Center(
                      child: Text('No movies/shows/videos in your collection.'))
                  : ListView.builder(
                      itemCount: collection.length,
                      itemBuilder: (context, index) {
                        final item = collection[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              item.type == MediaType.movie
                                  ? Icons.movie
                                  : item.type == MediaType.show
                                      ? Icons.tv
                                      : Icons.videocam,
                            ),
                            title: Text(item.title),
                            subtitle: Text('Linked coins: ${item.linkedCoins}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MediaType { movie, show, video }

class MediaItem {
  final String title;
  final MediaType type;
  final int linkedCoins;

  MediaItem({
    required this.title,
    required this.type,
    required this.linkedCoins,
  });
}
