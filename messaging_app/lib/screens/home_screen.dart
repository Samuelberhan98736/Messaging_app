import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> _boards = const [
    {"id": "general", "name": "General Chat", "icon": Icons.forum},
    {"id": "school", "name": "School Talk", "icon": Icons.school},
    {"id": "gaming", "name": "Gaming", "icon": Icons.sports_esports},
    {"id": "random", "name": "Random", "icon": Icons.casino},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Message Boards")),
      drawer: const _AppDrawer(),
      body: ListView.builder(
        itemCount: _boards.length,
        itemBuilder: (context, index) {
          final board = _boards[index];

          return ListTile(
            leading: Icon(board["icon"], size: 32),
            title: Text(board["name"]),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/chat',
                arguments: {
                  "boardId": board["id"],
                  "boardName": board["name"],
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
