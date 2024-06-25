// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  PageController controller = PageController();
  int bmiS = 0;

  final List<ChartData> chartData = [
    ChartData(1, 35),
    ChartData(2, 23),
    ChartData(3, 34),
    ChartData(4, 25),
    ChartData(5, 40)
  ];

  void showFilterDialog(BuildContext context) {
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("BMI"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter height (cm)"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Enter weight (kg)"),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  double height = double.tryParse(heightController.text) ?? 0;
                  double weight = double.tryParse(weightController.text) ?? 0;

                  if (height > 0 && weight > 0) {
                    double bmi = weight / ((height / 100) * (height / 100));
                    bmiS = bmi.floor();
                    setState(() {
                      Navigator.of(context).pop();
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Invalid Input"),
                          content:
                              Text("Please enter valid height and weight."),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 18),
              child: Text(
                "Quick Workout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Center(
              child: Container(
                height: MediaQuery.sizeOf(context).height / 5,
                width: MediaQuery.sizeOf(context).width - 24,
                child: PageView(
                  controller: controller,
                  children: [
                    CustomCardPg(
                        context,
                        "Bicep Curls",
                        "Biceps curls are a powerful\nexercise to sculpt strong, well-\ndefined arm muscles.",
                        "assets/bicepCurl.png"),
                    CustomCardPg(
                        context,
                        "Squats",
                        "Squats are effective for building\nlower body strength and\nenhancing overall lower body",
                        "assets/squat.png"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Center(
              child: SmoothPageIndicator(
                  controller: controller,
                  count: 2,
                  effect: const WormEffect(
                      activeDotColor: Colors.black,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8),
                  onDotClicked: (index) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClickCard(
                      context,
                      "assets/weight.png",
                      "102 Kg",
                      const Color.fromRGBO(127, 125, 234, 1),
                      const Color.fromRGBO(236, 236, 252, 1),
                      "Weight",
                      () {}),
                  InkWell(
                    onTap: () {
                      showFilterDialog(context);
                      print("object");
                    },
                    child: ClickCard(
                        context,
                        "assets/bmi.png",
                        "$bmiS",
                        const Color.fromRGBO(72, 119, 41, 1),
                        const Color.fromRGBO(237, 242, 237, 1),
                        "BMI", () {
                      showFilterDialog(context);
                    }),
                  ),
                  ClickCard(
                      context,
                      "assets/water.png",
                      "4 Glass",
                      const Color.fromRGBO(237, 191, 85, 1),
                      const Color.fromRGBO(254, 249, 239, 1),
                      "Water", () {
                    print("Object12345677");
                  })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: 175,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(254, 242, 237, 1),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: Color.fromRGBO(243, 153, 110, 1),
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          backgroundColor: Color.fromRGBO(254, 242, 237, 1),
                          primaryXAxis: CategoryAxis(isVisible: false),
                          primaryYAxis: NumericAxis(isVisible: false),
                          series: <CartesianSeries>[
                            ColumnSeries<ChartData, double>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              color: Color.fromRGBO(243, 153, 110, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        'Calories',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomCardPg(
    BuildContext context, String title, String sub, String ImgPath) {
  return Container(
    height: MediaQuery.sizeOf(context).height / 5,
    width: MediaQuery.sizeOf(context).width,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 193, 193, 193),
          width: 1.0,
        ),
      ),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        sub,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.04, // Adjust coefficient as needed
                            color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.sizeOf(context).height / 6,
                child: Image.asset(ImgPath),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ClickCard(BuildContext context, String img, String valueof,
    Color TextColor, Color cardColor, String label, Function onPressed) {
  return GestureDetector(
    onTap: () {
      onPressed();
      // print("Hello World");
      // onTap();
    },
    child: Container(
      height: MediaQuery.sizeOf(context).height / 6,
      width: MediaQuery.sizeOf(context).width / 3 - 10,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
          side: BorderSide(
            color: TextColor,
            width: 1.0,
          ),
        ),
        elevation: 0,
        color: cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            Image.asset(
              img,
              height: MediaQuery.sizeOf(context).height / 16,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              valueof,
              style: TextStyle(
                  color: TextColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            )
          ],
        ),
      ),
    ),
  );
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
