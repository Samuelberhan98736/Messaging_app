import 'package:flutter/material.dart';

// Screens
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // LOGIN
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      // REGISTER
      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      // HOME
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      // PROFILE
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      // SETTINGS
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      // CHAT SCREEN (requires arguments)
      case '/chat':
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            boardId: args['boardId'],
            boardName: args['boardName'],
          ),
        );

      // DEFAULT / UNKNOWN ROUTE
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                "Page not found",
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        );
    }
  }
}