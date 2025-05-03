import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../models/review.dart';
import '../services/data_service.dart';

class AddReviewScreen extends StatefulWidget {
  final Movie movie;

  const AddReviewScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0; // Star rating
  String _reviewText = "";

  @override
  void initState() {
    super.initState();

    // Check if the movie already has a review
    final existingReview = DataService.userReviews.firstWhere(
      (review) => review.movie.title == widget.movie.title,
      orElse: () => Review(movie: widget.movie, score: 0, text: ""), // Return a default Review instead of null
);

    // if (existingReview != null) {////////////////////////////////////
      // Pre-fill the rating and review text
      _rating = existingReview.score;
      _reviewText = existingReview.text;
    // }
  }

  void _submitReview() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final review = Review(
        movie: widget.movie,
        score: _rating,
        text: _reviewText,
      );

      // Check if the movie already has a review
      final existingReviewIndex = DataService.userReviews.indexWhere(
        (r) => r.movie.title == widget.movie.title,
      );

      if (existingReviewIndex != -1) {
        // Update the existing review
        DataService.userReviews[existingReviewIndex] = review;
      } else {
        // Add a new review
        DataService.userReviews.add(review);
      }

      await DataService.saveData(); // Save data to local storage

      // Return true to indicate a new review was added
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Review for: ${widget.movie.title}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Star Rating
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < _rating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Review Text Box
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Write your review",
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your review.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _reviewText = value!;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitReview,
                  child: const Text("Submit Review"),
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
            ],
          ),
        ),
      ),
    );
  }
}