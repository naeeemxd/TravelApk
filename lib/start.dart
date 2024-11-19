import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnboardingScreen extends StatefulWidget {
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
                  title: 'ʟɪꜰᴇ ɪꜱ ꜱʜᴏʀᴛ ᴀɴᴅ ᴛʜᴇ ᴡᴏʀʟᴅ ɪꜱ ᴡɪᴅᴇ',
                  description:
                      '𝘈𝘵 𝘍𝘳𝘪𝘦𝘯𝘥𝘴 𝘵𝘰𝘶𝘳𝘴 𝘢𝘯𝘥 𝘵𝘳𝘢𝘷𝘦𝘭, 𝘸𝘦 𝘤𝘶𝘴𝘵𝘰𝘮𝘪𝘻𝘦 𝘳𝘦𝘭𝘪𝘢𝘣𝘭𝘦 𝘢𝘯𝘥 𝘵𝘳𝘶𝘴𝘵𝘸𝘰𝘳𝘵𝘩𝘺 𝘦𝘥𝘶𝘤𝘢𝘵𝘪𝘰𝘯𝘢𝘭 𝘵𝘰𝘶𝘳𝘴 𝘵𝘰 𝘥𝘦𝘴𝘵𝘪𝘯𝘢𝘵𝘪𝘰𝘯𝘴 𝘢𝘭𝘭 𝘰𝘷𝘦𝘳 𝘵𝘩𝘦 𝘸𝘰𝘳𝘭𝘥.',
                  buttonText: 'Next',
                  onNext: nextPage,
                ),
                OnboardingPage(
                  image: 'assets/images/2.png',
                  title: 'ɪᴛ’ꜱ ᴀ ʙɪɢ ᴡᴏʀʟᴅ ᴏᴜᴛ ᴛʜᴇʀᴇ, ɢᴏ ᴇxᴘʟᴏʀᴇ',
                  description:
                      '𝑻𝒐 𝒈𝒆𝒕 𝒕𝒉𝒆 𝒃𝒆𝒔𝒕 𝒐𝒇 𝒚𝒐𝒖𝒓 𝒂𝒅𝒗𝒆𝒏𝒕𝒖𝒓𝒆, 𝒚𝒐𝒖 𝒋𝒖𝒔𝒕 𝒏𝒆𝒆𝒅 𝒕𝒐 𝒍𝒆𝒂𝒗𝒆 𝒂𝒏𝒅 𝒈𝒐 𝒘𝒉𝒆𝒓𝒆 𝒚𝒐𝒖 𝒍𝒊𝒌𝒆. 𝑾𝒆 𝒂𝒓𝒆 𝒘𝒂𝒊𝒕𝒊𝒏𝒈 𝒇𝒐𝒓 𝒚𝒐𝒖.',
                  buttonText: 'Next',
                  onNext: nextPage,
                ),
                OnboardingPage(
                  image: 'assets/images/image.png',
                  title: 'ᴘᴇᴏᴘʟᴇ ᴅᴏɴ’ᴛ ᴛᴀᴋᴇ ᴛʀɪᴘꜱ, ᴛʀɪᴘꜱ ᴛᴀᴋᴇ ᴘᴇᴏᴘʟᴇ',
                  description:
                      '𝑻𝒐 𝒈𝒆𝒕 𝒕𝒉𝒆 𝒃𝒆𝒔𝒕 𝒐𝒇 𝒚𝒐𝒖𝒓 𝒂𝒅𝒗𝒆𝒏𝒕𝒖𝒓𝒆, 𝒚𝒐𝒖 𝒋𝒖𝒔𝒕 𝒏𝒆𝒆𝒅 𝒕𝒐 𝒍𝒆𝒂𝒗𝒆 𝒂𝒏𝒅 𝒈𝒐 𝒘𝒉𝒆𝒓𝒆 𝒚𝒐𝒖 𝒍𝒊𝒌𝒆. 𝑾𝒆 𝒂𝒓𝒆 𝒘𝒂𝒊𝒕𝒊𝒏𝒈 𝒇𝒐𝒓 𝒚𝒐𝒖.',
                  buttonText: 'Get Started',
                  onNext: nextPage,
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: WormEffect(
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

  const OnboardingPage({
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
          ),
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
          ElevatedButton(
            onPressed: onNext,
            child: Text(buttonText),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
