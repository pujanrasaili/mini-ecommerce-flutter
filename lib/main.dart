import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // check if a user is already saved in SharedPreferences
  final username = await AuthService().currentUser();
  runApp(MyShopApp(isLoggedIn: username != null));
}

class MyShopApp extends StatelessWidget {
  const MyShopApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.ink,
          onPrimary: Colors.white,
          secondary: AppColors.accent,
          surface: AppColors.card,
          primaryContainer: Color(0xFFFFF1C2),
          onPrimaryContainer: AppColors.ink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
          foregroundColor: AppColors.ink,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ink,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.ink,
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: isLoggedIn ? const HomePage() : const LoginScreen(),
    );
  }
}
