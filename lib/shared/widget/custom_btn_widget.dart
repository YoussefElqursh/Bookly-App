import 'package:bookly_app/shared/style/styles.dart';
import 'package:flutter/material.dart';

buildCustomButton({
  required BuildContext context,
  required String text,
  required Color backgroundColor,
  required Color textColor,
  required void Function()? onPressed,
  BorderRadius? borderRadius,
}) {
  return SizedBox(
    height: 48,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: Styles.titleMedium16.copyWith(
          color: textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}