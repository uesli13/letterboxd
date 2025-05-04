import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../services/data_service.dart';
import '../widgets/movie_card.dart';
import 'movie_detail_screen.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({Key? key}) : super(key: key);

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    final likedMovies = DataService.user.liked;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liked Movies"),
      ),
      body: likedMovies.isEmpty
          ? const Center(
              child: Text(
                "No movies in the liked list.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: likedMovies.length,
              itemBuilder: (context, index) {
                final movie = likedMovies[index];
                return Slidable(
                  key: ValueKey(movie.title),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          setState(() {
                            DataService.user.liked.remove(movie);
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