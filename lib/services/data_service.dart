import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';
import '../models/user.dart';
import '../models/review.dart';

class DataService {
  // Static list of movies
  static final List<Movie> movies = [
    Movie(
      title: "The Matrix",
      director: "The Wachowskis",
      image: "assets/images/matrix.jpg", // Replace with your asset path
      year: 1999,
      duration: 136,
      description: "A computer hacker learns about the true nature of his reality and his role in the war against its controllers.",
      genre: ["Action", "Sci-Fi"],
    ),
    Movie(
      title: "Interstellar",
      director: "Christopher Nolan",
      image: "assets/images/interstellar.jpg", // Replace with your asset path
      year: 2014,
      duration: 169,
      description: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      genre: ["Adventure", "Drama", "Sci-Fi"],
    ),
    Movie(
      title: "Inception",
      director: "Christopher Nolan",
      image: "assets/images/inception.jpg", // Replace with your asset path
      year: 2010,
      duration: 148,
      description: "A thief who steals corporate secrets through dream-sharing technology is tasked with planting an idea into a CEO's mind.",
      genre: ["Action", "Adventure", "Sci-Fi"],
    ),
    Movie(
      title: "The Dark Knight",
      director: "Christopher Nolan",
      image: "assets/images/dark_knight.jpg", // Replace with your asset path
      year: 2008,
      duration: 152,
      description: "Batman faces the Joker, a criminal mastermind who wants to plunge Gotham City into anarchy.",
      genre: ["Action", "Crime", "Drama"],
    ),
    Movie(
      title: "Pulp Fiction",
      director: "Quentin Tarantino",
      image: "assets/images/pulp_fiction.jpg", // Replace with your asset path
      year: 1994,
      duration: 154,
      description: "The lives of two mob hitmen, a boxer, a gangster's wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
      genre: ["Crime", "Drama"],
    ),
    Movie(
      title: "The Shawshank Redemption",
      director: "Frank Darabont",
      image: "assets/images/shawshank_redemption.jpg", // Replace with your asset path
      year: 1994,
      duration: 142,
      description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
      genre: ["Drama"],
    ),
    Movie(
      title: "The Godfather",
      director: "Francis Ford Coppola",
      image: "assets/images/godfather.jpg", // Replace with your asset path
      year: 1972,
      duration: 175,
      description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
      genre: ["Crime", "Drama"],
    ),
    Movie(
      title: "Forrest Gump",
      director: "Robert Zemeckis",
      image: "assets/images/forrest_gump.jpg", // Replace with your asset path
      year: 1994,
      duration: 142,
      description: "The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.",
      genre: ["Drama", "Romance"],
    ),
    Movie(
      title: "Fight Club",
      director: "David Fincher",
      image: "assets/images/fight_club.jpg", // Replace with your asset path
      year: 1999,
      duration: 139,
      description: "An insomniac office worker and a devil-may-care soap maker form an underground fight club that evolves into much more.",
      genre: ["Drama"],
    ),
  ];

  // Static user data
  static final User user = User(
    name: "Panos Lekos",
    photo: "assets/images/user.jpg", // Replace with your asset path
    watched: [],
    liked: [],
    watchlist: [],
  );

  // Static list of user reviews
  static final List<Review> userReviews = [];

  // Save user lists and reviews to local storage
  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save user lists
    prefs.setString('liked', jsonEncode(user.liked.map((movie) => movie.toJson()).toList()));
    prefs.setString('watched', jsonEncode(user.watched.map((movie) => movie.toJson()).toList()));
    prefs.setString('watchlist', jsonEncode(user.watchlist.map((movie) => movie.toJson()).toList()));

    // Save reviews
    prefs.setString('userReviews', jsonEncode(userReviews.map((review) => review.toJson()).toList()));
  }

  // Load user lists and reviews from local storage
  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load user lists
    final likedString = prefs.getString('liked');
    final watchedString = prefs.getString('watched');
    final watchlistString = prefs.getString('watchlist');

    if (likedString != null) {
      user.liked.clear();
      user.liked.addAll((jsonDecode(likedString) as List).map((json) => Movie.fromJson(json)));
    }

    if (watchedString != null) {
      user.watched.clear();
      user.watched.addAll((jsonDecode(watchedString) as List).map((json) => Movie.fromJson(json)));
    }

    if (watchlistString != null) {
      user.watchlist.clear();
      user.watchlist.addAll((jsonDecode(watchlistString) as List).map((json) => Movie.fromJson(json)));
    }

    // Load reviews
    final reviewsString = prefs.getString('userReviews');
    if (reviewsString != null) {
      userReviews.clear();
      userReviews.addAll((jsonDecode(reviewsString) as List).map((json) => Review.fromJson(json)));
    }
  }
}