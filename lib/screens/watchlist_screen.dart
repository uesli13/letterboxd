import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/data_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
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
                return Slidable(
                  key: ValueKey(movie.title), // Unique key for each movie
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            DataService.user.watchlist.remove(movie);
                          });
                          DataService.saveData(); // Save changes to persistent storage
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remove',
                      ),
                    ],
                  ),
                  child: MovieCard(
                    movie: movie,
                    onTap: () async {
                      // Navigate to MovieDetailScreen and wait for the result
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movie: movie),
                        ),
                      );

                      // Refresh the state when returning from MovieDetailScreen
                      setState(() {});
                    },
                  ),
                );
              },
            ),
    );
  }
}