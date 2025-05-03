import 'package:flutter/material.dart';
import '../services/data_service.dart';
import 'watched_screen.dart';
import 'liked_screen.dart';
import 'watchlist_screen.dart';
import 'ratings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = DataService.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(user.photo),
                ),
                const SizedBox(width: 16),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.visibility, color: Colors.green),
              title: const Text("Watched Movies"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchedScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.thumb_up, color: Colors.green),
              title: const Text("Liked Movies"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LikedScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark, color: Colors.green),
              title: const Text("Watchlist"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WatchlistScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.green),
              title: const Text("Reviews"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}