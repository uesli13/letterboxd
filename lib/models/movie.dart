class Movie {
  final String title;
  final String director;
  final String image; //asset path for the movie poster
  final int year;
  final int duration;
  final String description;
  final List<String> genre;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is Movie &&
        title == other.title &&
        director == other.director &&
        year == other.year);

  @override
  int get hashCode => title.hashCode ^ director.hashCode ^ year.hashCode;

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