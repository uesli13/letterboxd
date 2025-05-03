import 'movie.dart';

class Review {
  final Movie movie;
  final int score; // Rating score (e.g., 1-10)
  final String text; // Review text

  Review({
    required this.movie,
    required this.score,
    required this.text,
  });

  // Convert Review to JSON
  Map<String, dynamic> toJson() {
    return {
      'movie': movie.toJson(),
      'score': score,
      'text': text,
    };
  }

  // Create Review from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      movie: Movie.fromJson(json['movie']),
      score: json['score'],
      text: json['text'],
    );
  }
}