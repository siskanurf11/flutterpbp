import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;

  const RatingWidget({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
  });

  @override
  State<RatingWidget> createState() =>
      _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double rating = 0;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) {
          double starNumber = index + 1;

          return IconButton(
            onPressed: () {
              setState(() {
                rating = starNumber;
              });

              widget.onRatingChanged(rating);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              starNumber <= rating
                  ? Icons.star
                  : Icons.star_border,
              color: const Color(0xFF8B5E3C),
              size: 28,
            ),
          );
        },
      ),
    );
  }
}