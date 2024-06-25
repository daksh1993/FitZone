import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fit_zone/Modal/foodModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodDetails extends StatefulWidget {
  final String id;
  const FoodDetails({super.key, required this.id});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  List<SingleFoodItemModal> singleFood = [];
  foodResponse() async {
    var resp = await http.get(Uri.parse(
        "https://appy.trycatchtech.com/v3/fit_zone/single_food?id=${widget.id}"));
    if (resp.statusCode == 200) {
      singleFood =
          SingleFoodItemModal.SingleFoodItemMethod(jsonDecode(resp.body));
      print(resp.body);
      setState(() {});
    }
  }
  @override
  void initState() {
    foodResponse();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: singleFood.isEmpty
          ? null
          : AppBar(
              title: Text(singleFood[0].name ?? ""),
              centerTitle: true,
              elevation: 1,
            ),
      body: singleFood.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Container(
                      child: Image.network(singleFood[0].image ?? ""),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          singleFood[0].name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                        Text(
                          "100.00 gm",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 12),
                    child: Text(
                      singleFood[0].description ?? "",
                      softWrap: true,
                      maxLines: null,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/cal.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Calories",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              "${singleFood[0].calories} Kcal",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700]),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/sodium.png"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sodium",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            Text(
                              "${singleFood[0].sodium}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700]),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  progressbar(
                      "Fats", Colors.green.shade400, "${singleFood[0].fats}"),
                  SizedBox(
                    height: 12,
                  ),
                  progressbar("Carbs", Colors.amber, "${singleFood[0].carbs}"),
                  SizedBox(
                    height: 12,
                  ),
                  progressbar(
                      "Protien", Colors.red, "${singleFood[0].protein}"),
                ],
              ),
            ),
    );
  }
}

Widget progressbar(String label, Color color, String value) {
  double val = double.parse(value);
  if (val < 11) {
    val = 24;
  }
  double progressValue = val / 100; // Convert val to percentage

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
        child: Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: color,
                  width: 1,
                ),
                color: color.withOpacity(0.2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  minHeight: 25,
                  value: progressValue, // Progress value set to 76%
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  '${val.toStringAsFixed(0)}%',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
