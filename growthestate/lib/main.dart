import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/land/land_list_screen.dart';
import 'screens/land/land_details_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/transactions/transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Growth Estate',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Set initial route to login screen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/land_list': (context) => const LandListScreen(),
        '/land_details': (context) => LandDetailScreen(
          landId: ModalRoute.of(context)!.settings.arguments as int,
        ),
        '/profile': (context) => const ProfileScreen(),
        '/transactions': (context) => const TransactionScreen(),
        // Add any additional routes here
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes if needed
        if (settings.name == '/land_details') {
          final int landId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) => LandDetailScreen(landId: landId),
          );
        }
        // Add other dynamic routes if needed
        return null; // Let the framework handle unknown routes
      },
    );
  }
}
