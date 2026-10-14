import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/product.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card.dart';
import 'category_page.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  String query = '';
  final auth = AuthService();
  String userName = '';

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  // get the saved user so we can say hello
  Future<void> loadUser() async {
    final username = await auth.currentUser();
    if (username == null) {
      goToLogin();
      return;
    }
    final profile = await auth.profileOf(username);
    if (!mounted) return;
    setState(() {
      userName = profile?['name'] ?? username;
    });
  }

  void goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<void> logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await auth.logout();
    if (!mounted) return;
    goToLogin();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocus.dispose();
    super.dispose();
  }

  // products that match the search text (name or category)
  List<Product> get searchResults {
    final text = query.toLowerCase();
    return allProducts.where((p) {
      return p.name.toLowerCase().contains(text) ||
          p.category.toLowerCase().contains(text);
    }).toList();
  }

  Widget sectionTitle(String title, {Widget? action}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 22, 8, 10),
      child: Row(
        children: [
          Container(width: 4, height: 18, color: AppColors.accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          if (action != null) action,
        ],
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        controller: searchController,
        focusNode: searchFocus,
        onChanged: (value) {
          setState(() {
            query = value.trim();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search products or categories',
          prefixIcon: const Icon(Icons.search, color: AppColors.ink),
          suffixIcon: query.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      query = '';
                    });
                  },
                ),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.accent, width: 2),
          ),
        ),
      ),
    );
  }

  Widget homeContent() {
    final popularProducts = allProducts.take(6).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const BannerCarousel(),

          // categories
          sectionTitle('Shop by Category'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: allCategories
                  .map((category) => CategoryItem(category: category))
                  .toList(),
            ),
          ),

          // popular products
          sectionTitle(
            'Popular Products',
            action: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CategoryPage(categoryName: 'All Products'),
                  ),
                );
              },
              child: const Text('See All →'),
            ),
          ),
          SizedBox(
            height: 295,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: popularProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12, top: 4, bottom: 8),
                  child: SizedBox(
                    width: 170,
                    child: ProductCard(product: popularProducts[index]),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget resultsView() {
    final results = searchResults;

    if (results.isEmpty) {
      return Center(
        child: Text(
          'No product found for "$query"',
          style: const TextStyle(color: AppColors.softText),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: results[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.ink,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bolt, size: 18, color: AppColors.accent),
            ),
            const SizedBox(width: 8),
            const Text(
              'MyShop',
              style: TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => searchFocus.requestFocus(),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Your cart is empty')),
              );
            },
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (userName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hello, $userName 👋',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            searchBar(),
            Expanded(
              child: query.isEmpty ? homeContent() : resultsView(),
            ),
          ],
        ),
      ),
    );
  }
}
