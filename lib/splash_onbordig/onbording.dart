import 'package:flutter/material.dart';
import 'package:foodia_chef/home.dart';
import 'package:foodia_chef/splash_onbordig/onboardingPage.dart';
import 'package:foodia_chef/splash_onbordig/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Step 3: Create a PageController to manage the onboarding pages
  final PageController _pageController = PageController();
  int _currentPage = 0; // Track the current page index

  // Step 4: Define your onboarding content (titles, descriptions, and images)
  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Text color
      ),
      image: 'assets/images/slide1.jpg',
      title: Text("مرحبًا بك في فوديا!"), // "Welcome to Foodia!" in Arabic
      description: Text("ابدأ رحلتك كطاهي محترف الآن."),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.white, // Text color
      ),
    ),
    OnboardingItem(
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Text color
      ),
      image: 'assets/images/slide2.png',
      description: Text(
        "انضم إلى منصة تجمع الطهاة الموهوبين مع العملاء الباحثين عن أفضل الأطباق المنزلية",
      ),
      title: Text(' '),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.black,
      ), // "Cook and earn money!" in Arabic
    ),
    OnboardingItem(
      textStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Text color
      ),
      image: 'assets/images/slide3.png',
      title: Text('اطبخ، قدّم، واربح!'),
      description: Text(
        'سجل كطاهٍ وابدأ في استقبال الطلبات، التواصل مع العملاء، وتنمية عملك بسهولة',
      ),
      disStyle: TextStyle(
        fontFamily: 'Changa',
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5B762), // Background color
      body: Stack(
        children: [
          // Step 6: Add a PageView for swipeable onboarding screens
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingItems.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index; // Update the current page index
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(item: _onboardingItems[index]);
            },
          ),

          // Skip button in the upper right corner
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Navigate directly to the home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text(
                "تخطي", // "Skip" in Arabic
                style: TextStyle(
                  fontFamily: 'Changa', // Use Changa font
                  fontSize: 16,
                  color: Colors.white, // Text color
                ),
              ),
            ),
          ),

          // Smooth Page Indicator
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _onboardingItems.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.white, // Active dot color
                  dotColor: Colors.white, // Inactive dot color
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8, // Space between dots
                ),
              ),
            ),
          ),

          // Next button with only ">" sign
          Positioned(
            bottom: 30,
            right: 20,
            child:
                _currentPage == _onboardingItems.length - 1
                    ? ElevatedButton(
                      onPressed: () {
                        // Navigate to the home screen after onboarding
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          0xFFFFA500,
                        ), // Button color (#FFA500)
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Rounded corners
                        ),
                      ),
                      child: Text(
                        "ابدأ الآن", // "Get Started" in Arabic
                        style: TextStyle(
                          fontFamily: 'Changa', // Use Changa font
                          fontSize: 16,
                          color: Colors.white, // Text color
                        ),
                      ),
                    )
                    : ElevatedButton(
                      onPressed: () {
                        // Go to the next page
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          0xFFFFA500,
                        ), // Button color (#FFA500)
                        padding: EdgeInsets.all(
                          12,
                        ), // Adjust padding for the ">" sign
                        shape: CircleBorder(), // Make the button circular
                      ),
                      child: Text(
                        ">", // Only ">" sign
                        style: TextStyle(
                          fontFamily: 'Changa', // Use Changa font
                          fontSize: 20,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
