import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/data_service.dart';
import 'add_review_screen.dart';
import '../widgets/review_card.dart';
import '../models/review.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isLiked = false;
  bool isInWatchlist = false;
  bool isWatched = false;
  List<Review> movieReviews = [];

  @override
  void initState() {
    super.initState();
    final user = DataService.user;
    isLiked = user.liked.contains(widget.movie);
    isInWatchlist = user.watchlist.contains(widget.movie);
    isWatched = user.watched.contains(widget.movie);

    // Load reviews for the current movie
    _loadMovieReviews();
  }

  void _loadMovieReviews() {
    setState(() {
      movieReviews = DataService.userReviews
          .where((review) => review.movie.title == widget.movie.title)
          .toList();
    });
  }

  void toggleLiked() {
    setState(() {
      final user = DataService.user;
      if (isLiked) {
        user.liked.remove(widget.movie);
      } else {
        user.liked.add(widget.movie);
      }
      isLiked = !isLiked;
    });
  }

  void toggleWatchlist() {
    setState(() {
      final user = DataService.user;
      if (isInWatchlist) {
        user.watchlist.remove(widget.movie);
      } else {
        user.watchlist.add(widget.movie);
      }
      isInWatchlist = !isInWatchlist;
    });
  }

  void toggleWatched() {
    setState(() {
      final user = DataService.user;
      if (isWatched) {
        user.watched.remove(widget.movie);
      } else {
        user.watched.add(widget.movie);
      }
      isWatched = !isWatched;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2 / 3, // Ensures the container maintains a 2:3 aspect ratio
                child: Image.asset(
                  widget.movie.image,
                  fit: BoxFit.cover, // Ensures the image covers the container without distortion
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.movie.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Director: ${widget.movie.director}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                "Year: ${widget.movie.year}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                widget.movie.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: toggleLiked,
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                    ),
                    label: Text(
                      isLiked ? "Liked" : "Like",
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLiked ? Colors.green : Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: toggleWatchlist,
                    icon: Icon(
                      isInWatchlist ? Icons.schedule : Icons.schedule_outlined,
                      size: 18,
                    ),
                    label: Text(
                      isInWatchlist ? "In Watchlist" : "Watchlist",
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isInWatchlist ? Colors.green : Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: toggleWatched,
                    icon: Icon(
                      isWatched ? Icons.visibility : Icons.visibility_off,
                      size: 18,
                    ),
                    label: Text(
                      isWatched ? "Watched" : "Watch",
                      style: const TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isWatched ? Colors.green : Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Add Review Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigate to AddReviewScreen and wait for the result
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddReviewScreen(movie: widget.movie),
                      ),
                    );

                    // Refresh the reviews if a new review was added
                    if (result == true) {
                      _loadMovieReviews();
                    }
                  },
                  child: const Text("Add Review"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Reviews Section
              Text(
                "Reviews",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              movieReviews.isEmpty
                  ? const Text(
                      "No reviews yet. Be the first to add one!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  : ListView.builder(
                      shrinkWrap: true, // Ensures the ListView doesn't take infinite height
                      physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                      itemCount: movieReviews.length,
                      itemBuilder: (context, index) {
                        final review = movieReviews[index];
                        return ReviewCard(review: review);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}