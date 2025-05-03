import 'movie.dart';

class User {
  final String name;
  final String photo; // URL or asset path for the user's profile picture
  List<Movie> watched;
  List<Movie> liked;
  List<Movie> watchlist;

  User({
    required this.name,
    required this.photo,
    required this.watched,
    required this.liked,
    required this.watchlist,
  });
}