import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/product.dart';

// pictures are saved inside assets/images
String img(String name) => 'assets/images/${name.replaceAll(',', '_')}.png';

final List<Category> allCategories = [
  Category(name: 'Electronics', icon: Icons.devices),
  Category(name: 'Fashion', icon: Icons.checkroom),
  Category(name: 'Shoes', icon: Icons.snowshoeing),
  Category(name: 'Beauty', icon: Icons.face_retouching_natural),
  Category(name: 'Accessories', icon: Icons.watch),
  Category(name: 'Home', icon: Icons.chair),
];

final List<Product> allProducts = [
  // Electronics
  Product(
    name: 'Wireless Headphones',
    icon: Icons.headphones,
    category: 'Electronics',
    image: img('headphones'),
    price: 3500,
    rating: 4.5,
    discount: 20,
    description:
        'Wireless headphones with high-quality sound, deep bass and up to 30 hours of battery life.',
  ),
  Product(
    name: 'Smart Watch',
    icon: Icons.watch,
    category: 'Electronics',
    image: img('smartwatch'),
    price: 5200,
    rating: 4.3,
    description:
        'Track your steps, heart rate and sleep. Receive phone notifications on your wrist.',
  ),
  // Fashion
  Product(
    name: 'Cotton T-Shirt',
    icon: Icons.checkroom,
    category: 'Fashion',
    image: img('tshirt'),
    price: 1200,
    rating: 4.1,
    discount: 10,
    description:
        'Soft and comfortable cotton t-shirt for daily wear. Available in many sizes.',
  ),
  Product(
    name: 'Denim Jacket',
    icon: Icons.dry_cleaning,
    category: 'Fashion',
    image: img('denim,jacket'),
    price: 3800,
    rating: 4.4,
    description:
        'Classic blue denim jacket with a modern fit. Goes well with any outfit.',
  ),
  // Shoes
  Product(
    name: 'Running Sneakers',
    icon: Icons.directions_run,
    category: 'Shoes',
    image: img('sneakers'),
    price: 4500,
    rating: 4.6,
    discount: 15,
    description:
        'Lightweight sneakers with a cushioned sole, made for running and daily use.',
  ),
  Product(
    name: 'Leather Boots',
    icon: Icons.hiking,
    category: 'Shoes',
    image: img('boots'),
    price: 6200,
    rating: 4.2,
    description:
        'Strong leather boots that keep your feet warm and protected in any weather.',
  ),
  // Beauty
  Product(
    name: 'Face Cream',
    icon: Icons.spa,
    category: 'Beauty',
    image: img('skincare'),
    price: 950,
    rating: 4.0,
    description:
        'Moisturizing face cream with natural ingredients for soft and fresh skin.',
  ),
  Product(
    name: 'Lipstick Set',
    icon: Icons.brush,
    category: 'Beauty',
    image: img('lipstick'),
    price: 1500,
    rating: 4.3,
    discount: 25,
    description:
        'Set of 4 long-lasting lipsticks in different shades with a smooth finish.',
  ),
  // Accessories
  Product(
    name: 'Sunglasses',
    icon: Icons.wb_sunny,
    category: 'Accessories',
    image: img('sunglasses'),
    price: 1800,
    rating: 4.2,
    description:
        'Stylish sunglasses with UV protection lenses and a light frame.',
  ),
  Product(
    name: 'Travel Backpack',
    icon: Icons.backpack,
    category: 'Accessories',
    image: img('backpack'),
    price: 3200,
    rating: 4.5,
    description:
        'Spacious water-resistant backpack with a laptop pocket and padded straps.',
  ),
  // Home
  Product(
    name: 'Table Lamp',
    icon: Icons.lightbulb,
    category: 'Home',
    image: img('table,lamp'),
    price: 2100,
    rating: 4.4,
    description:
        'Modern table lamp with warm light, perfect for your study or bedroom.',
  ),
  Product(
    name: 'Ceramic Mug Set',
    icon: Icons.coffee,
    category: 'Home',
    image: img('mug'),
    price: 850,
    rating: 4.1,
    discount: 5,
    description: 'Set of 4 ceramic mugs for tea and coffee. Dishwasher safe.',
  ),
];
