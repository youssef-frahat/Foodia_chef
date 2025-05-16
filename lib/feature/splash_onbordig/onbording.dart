import 'package:flutter/material.dart';
import 'package:foodia_chef/core/routes/routes.dart';
import 'package:foodia_chef/feature/splash_onbordig/onboardingPage.dart';
import 'package:foodia_chef/feature/splash_onbordig/onboarding_model.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: 'assets/images/slide1.jpg',
      title: Text("مرحبًا بك في فوديا!"),
      description: Text("ابدأ رحلتك كطاهي محترف الآن."),
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.white,
      ),
    ),
    OnboardingItem(
      image: 'assets/images/slide2.jpg',
      title: Text(''),
      description: Text(
          "انضم إلى منصة تجمع الطهاة الموهوبين مع العملاء الباحثين عن أفضل الأطباق المنزلية"),
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    OnboardingItem(
      image: 'assets/images/slide3.png',
      title: Text('اطبخ، قدّم، واربح!'),
      description: Text(
        'سجل كطاهٍ وابدأ في استقبال الطلبات، التواصل مع العملاء، وتنمية عملك بسهولة',
      ),
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  ];

  void _goToLogin() => context.goNamed(Routes.login);

  @override
  Widget build(BuildContext context) {
    final orange = const Color(0xFFFFA500);

    return Scaffold(
      backgroundColor: const Color(0xFFF5B762),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingItems.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) =>
                OnboardingPage(item: _onboardingItems[index]),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _goToLogin,
              child: const Text(
                "تخطي",
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingItems.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.orange,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 8,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _currentPage == _onboardingItems.length - 1
                  ? _goToLogin
                  : () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                padding: _currentPage == _onboardingItems.length - 1
                    ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                    : const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                _currentPage == _onboardingItems.length - 1
                    ? "ابدأ الآن"
                    : "التالي",
                style: const TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
