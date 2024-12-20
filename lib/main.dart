import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripvs/OnboardingScreen.dart';
import 'package:tripvs/home.dart';
import 'package:tripvs/profile.dart';
import 'package:tripvs/signin.dart';

void main() async {
  // firebse initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conditional Navigation Example',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Splash or Login
        '/home': (context) => HomeScreen(), // Home Screen
        '/login': (context) => SignInScreen(),
        '/profile': (context) => ProfilePage(),
        '/start': (context) => OnboardingScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  Future<void> _checkUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to Home if the user is logged in
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Navigate to Login if the user is not logged in
      Navigator.pushReplacementNamed(context, '/start');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child:
              CircularProgressIndicator()), // You can replace this with your own splash content
    );
  }
}
