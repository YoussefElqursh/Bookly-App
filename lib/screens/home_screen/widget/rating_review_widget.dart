import 'package:bookly_app/shared/style/styles.dart';
import 'package:flutter/material.dart';

Row buildRatingWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.star, color: Colors.yellow.shade700),
      const SizedBox(width: 6.3,),
      const Text(
        '4.9',
        style: Styles.titleMedium16,
      ),
      const SizedBox(width: 5,),
      Text(
        '(245)',
        style: Styles.titleMedium14.copyWith(color: const Color(0xFF707070)),
      ),
    ],
  );
}