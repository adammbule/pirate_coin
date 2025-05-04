import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const MainScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement your search logic here
              showSearch(
                context: context,
                delegate: DummySearchDelegate(), // Replace with real search
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Row(
                children: [
                  Icon(Icons.directions_boat_filled, color: Colors.white, size: 32),
                  SizedBox(width: 10),
                  Text(
                    'PirateCoin Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pushNamed(context, '/home'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text('Wallet'),
                    onTap: () => Navigator.pushNamed(context, '/wallet'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Marketplace'),
                    onTap: () => Navigator.pushNamed(context, '/marketplace'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.movie_filter),
                    title: const Text('Movies'),
                    onTap: () => Navigator.pushNamed(context, '/movies'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.tv),
                    title: const Text('Series'),
                    onTap: () => Navigator.pushNamed(context, '/series'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.collections_bookmark),
                    title: const Text('Collections'),
                    onTap: () => Navigator.pushNamed(context, '/collections'),
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/second', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}

// Dummy SearchDelegate — Replace with real one later
class DummySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text("Results for '$query'"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: query.isEmpty ? 0 : 3,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Suggestion $index for '$query'"),
          onTap: () => close(context, 'Suggestion $index'),
        );
      },
    );
  }
}
