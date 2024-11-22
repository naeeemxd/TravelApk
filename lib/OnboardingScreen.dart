import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripvs/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  void nextPage() {
    if (_controller.page != 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to another screen or handle the final action
      print("Last page reached!");
    }
  }

  void loginpage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                OnboardingPage(
                  image: 'assets/images/img.png',
                  title: 'Life is short and the world is wide',
                  description:
                      'At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world.',
                  buttonText: 'Next',
                  onNext: nextPage,
                ),
                OnboardingPage(
                  image: 'assets/images/2.png',
                  title: 'It’s a big world out there, go explore',
                  description:
                      'To get the best of your adventure, you just need to leave and go where you like. We are waiting for you.',
                  buttonText: 'Next',
                  onNext: nextPage,
                ),
                OnboardingPage(
                  image: 'assets/images/image.png',
                  title: 'People don’t take trips, trips take people',
                  description:
                      'To get the best of your adventure, you just need to leave and go where you like. We are waiting for you.',
                  buttonText: 'Get Started',
                  onNext: loginpage,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const WormEffect(
              activeDotColor: Colors.blue,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onNext;

  const OnboardingPage({super.key, 
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
          ), // Replace with your asset paths
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: onNext,
              child: Text(
                buttonText,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
