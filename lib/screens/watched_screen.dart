import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class WatchedScreen extends StatelessWidget {
  const WatchedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchedMovies = DataService.user.watched;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watched Movies"),
      ),
      body: watchedMovies.isEmpty
          ? const Center(
              child: Text(
                "No movies in the watched list.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: watchedMovies.length,
              itemBuilder: (context, index) {
                final movie = watchedMovies[index];
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