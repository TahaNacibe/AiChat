import 'package:flutter/material.dart';

Widget pfpWidget(String name, String? pfpImage) {
  //* constants
  const double sizeForBox = 35;

  //* if pfpImage is null
  if (pfpImage == null) {
    return Container(
      width: sizeForBox,
      height: sizeForBox,
      decoration: BoxDecoration(
        color: Colors.indigo.shade400,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  //* if pfpImage is not null
  return Container(
    width: sizeForBox,
    height: sizeForBox,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(image: NetworkImage(pfpImage), fit: BoxFit.cover),
    ),
  );
}
