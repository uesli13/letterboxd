class Movie {
  final String title;
  final String director;
  final String image; // URL or asset path for the movie poster
  final int year;
  final int duration; // Duration in minutes
  final String description;
  final List<String> genre; // List of genres (e.g., ["Action", "Drama"])

  Movie({
    required this.title,
    required this.director,
    required this.image,
    required this.year,
    required this.duration,
    required this.description,
    required this.genre,
  });

  // Convert Movie to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'director': director,
      'image': image,
      'year': year,
      'duration': duration,
      'description': description,
      'genre': genre,
    };
  }

  // Create Movie from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      director: json['director'],
      image: json['image'],
      year: json['year'],
      duration: json['duration'],
      description: json['description'],
      genre: List<String>.from(json['genre']),
    );
  }
}