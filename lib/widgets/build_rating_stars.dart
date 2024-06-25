import 'package:flutter/material.dart';
import 'package:movieapp/constants.dart';

Widget buildRatingStars(double voteAverage) {
  List<Widget> stars = [];
  var fullStars = voteAverage.floor();
  var halfStars = (voteAverage * 2).round() % 2;

  for (var i = 0; i < fullStars; i++) {
    stars.add(const Icon(Icons.star, color: yellowColor));
  }

  if (halfStars > 0) {
    stars.add(const Icon(Icons.star_half, color: yellowColor));
  }

  while (stars.length < 5) {
    stars.add(const Icon(Icons.star_border, color: lightGreyColor));
  }

  return Row(children: stars);
}
