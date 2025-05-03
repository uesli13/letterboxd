import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviews = DataService.userReviews;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: reviews.isEmpty
          ? const Center(
              child: Text(
                "No reviews available.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return ReviewCard(review: review);
              },
            ),
    );
  }
}