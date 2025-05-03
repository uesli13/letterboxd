import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistMovies = DataService.user.watchlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
      ),
      body: watchlistMovies.isEmpty
          ? const Center(
              child: Text(
                "No movies in the watchlist.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: watchlistMovies.length,
              itemBuilder: (context, index) {
                final movie = watchlistMovies[index];
                return MovieCard(
                  movie: movie,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}