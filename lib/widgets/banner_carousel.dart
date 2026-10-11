import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../screens/category_page.dart';
import '../theme/app_colors.dart';
import 'product_image.dart';

class BannerItem {
  final String title;
  final String subtitle;
  final String image;
  final String category; // category opened when the banner is tapped

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.category,
  });
}

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int currentIndex = 0;

  final List<BannerItem> banners = [
    BannerItem(
      title: 'Electronics Discount',
      subtitle: 'Up to 20% off on gadgets',
      image: 'assets/images/banner1.png',   // Electronics Discount
      category: 'Electronics',
    ),
    BannerItem(
      title: 'New Arrivals',
      subtitle: 'Fresh styles for this season',
      image: 'assets/images/banner2.png',   // New Arrivals
      category: 'Fashion',
    ),
    BannerItem(
      title: 'Summer Sale',
      subtitle: 'Best deals on shoes',
      image: 'assets/images/banner3.png',   // Summer Sale
      category: 'Shoes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: banners.map((banner) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryPage(categoryName: banner.category),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppColors.shadow(),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ProductImage(url: banner.image),
                      // dark layer so the text can be read
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              banner.title,
                              style: const TextStyle(
                                color: AppColors.accent,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner.subtitle,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 8,
              width: currentIndex == index ? 22 : 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.ink
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
