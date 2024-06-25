import 'package:fit_zone/View/nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  Image img = Image.asset(
    "assets/ob1.png",
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.cover,
    key: ValueKey<int>(1),
  );
  String tit = "Fun Exercises";
  String subTit =
      "Discover fun workouts, track your progress,\nand stay motivated!";
  int counter = 1;

  void _updateContent() {
    setState(() {
      if (counter == 1) {
        img = Image.asset(
          "assets/ob2.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          key: ValueKey<int>(2),
        );
        tit = "Stay Healthy";
        subTit = "Get nutritional value of food, and hit your calorie goals effortlessly!";
        counter++;
      } else if (counter == 2) {
        img = Image.asset(
          "assets/ob3.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          key: ValueKey<int>(3),
        );
        tit = "Nutritional Insights";
        subTit = "Get nutritional value of food, and hit your calorie goals effortlessly!";
        counter++;
      } else if (counter == 3) {
        _completeOnboarding();
      }
    });
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: img,
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Text(
                      tit,
                      key: ValueKey<String>(tit),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Text(
                      subTit,
                      key: ValueKey<String>(subTit),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _updateContent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
