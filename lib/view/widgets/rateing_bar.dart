import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final double? size;

  const StarRating(
      {Key? key,
      this.starCount = 5,
      this.rating = 0,
      this.onRatingChanged,
      this.color,
      this.size})
      : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star,
        size: size ?? 24,
        color: Colors.black.withOpacity(.3),
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: size ?? 24,
        color: Colors.amber,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size ?? 24,
        color: Colors.amber,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
