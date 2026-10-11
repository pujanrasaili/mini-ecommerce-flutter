import 'package:flutter/material.dart';

class Product {
  final String name;
  final String category;
  final String image;
  final double price;
  final double rating;
  final String description;
  final int discount; // percentage, 0 means no discount
  final IconData icon; // shown if the photo cannot load

  Product({
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    required this.description,
    this.discount = 0,
    this.icon = Icons.shopping_bag,
  });
}
