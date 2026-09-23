import 'package:flutter/material.dart';

class TravelType {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String imageUrl;

  const TravelType({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.imageUrl,
  });
}
