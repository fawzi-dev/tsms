import 'package:flutter/material.dart';

class AppStyles {
 static List<BoxShadow> shadows = [
    BoxShadow(
      color: Colors.black38.withOpacity(0.1),
      spreadRadius: 1,
      blurRadius: 3,
      offset: const Offset(0, 2), // Adjust offset for desired shadow direction
    ),
  ];
}
