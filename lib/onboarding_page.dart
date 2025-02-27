import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swafa_app_frontend/core/theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  bool _isPageControllerInitialized = false; // Track initialization

  final List<String> originalImages = [
    "assets/images/onboarding_1.png",
    "assets/images/onboarding_2.png",
    "assets/images/onboarding_3.png",
  ];

  List<String> get images {
    return [
      originalImages.last,
      ...originalImages,
      originalImages.first,
    ];
  }

  @override
  void initState() {
    super.initState();

    // Initialize PageController after the first frame to avoid initial error
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isPageControllerInitialized = true; // Mark as initialized
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4), // Background color
      body: Column(
        children: [
          // Circular slidable images with scaling
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) async  {

                  // Reset to first or last position for circular effect
                  if (index == 0) {
                    await Future.delayed(const Duration(milliseconds: 300) ,() {
                      _pageController.jumpToPage(originalImages.length);
                    });
                  } else if (index == images.length - 1) {
                    await Future.delayed(const Duration(milliseconds: 300), () {
                      _pageController.jumpToPage(1);
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      // Check if PageController is initialized
                      if (!_isPageControllerInitialized || !_pageController.hasClients) {
                        return Container();  // Skip until initialization is complete
                      }

                      // Safe to access page value after the initialization
                      double value = (_pageController.page! - index).abs();
                      value = (1 - value).clamp(0.9, 1.0); // Scale between 0.8 and 1.0
                      return Transform.scale(
                        scale: value,
                        child: _buildImage(images[index]),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Dots Indicator
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: originalImages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.black,
                dotColor: Colors.grey,
              ),
            ),
          ),

          // Title and Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text(
                  "Matches",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "We match you with people that have a huge interest in swapping fashion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Create an account button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DefaultColors.primary500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  "Create an account",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),

          // Sign In link
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0), // Adjust spacing
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

