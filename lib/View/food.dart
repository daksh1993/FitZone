import 'dart:convert';

import 'package:fit_zone/Modal/foodListModal.dart';
import 'package:fit_zone/View/foodDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<FoodListModal> foodList = [];
  List<FoodListModal> searchedFoodList = []; // List for search results
  String searchText = ""; 
  foodResponse() async {
    var resp = await http
        .get(Uri.parse("https://appy.trycatchtech.com/v3/fit_zone/food_list"));
    if (resp.statusCode == 200) {
      foodList = FoodListModal.FoodListMethod(jsonDecode(resp.body));
      // print( );
      setState(() {});
    }
  }

  @override
  void initState() {
    foodResponse();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 75,
                  child: TextField(
                    cursorColor: Colors.black,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Type here to search food",
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      hoverColor: Colors.black,
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      searchText = value;
                      searchedFoodList = foodList
                          .where((food) =>
                              food.name?.toLowerCase().contains(searchText.toLowerCase()) ??
                              false)
                          .toList();
                      setState(() {});
                    },
                  ),
                ),

                SizedBox(
                  width: 12,
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8), // Set th1e border radius
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.filter_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
          foodList.isEmpty
              ? Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                  color: Colors.black,
                )))
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: foodList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: 3.4 / 4,
                      ),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            print("Object : ${foodList[i].name}");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodDetails(
                                          id: foodList[i].id ?? "1",
                                        )));
                            setState(() {});
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 193, 193, 193),
                                width: 1.0,
                              ),
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(14),
                                          topRight: Radius.circular(14)),
                                      color: i % 3 == 0
                                          ? Colors.redAccent
                                          : i % 2 == 0
                                              ? Colors.amber
                                              : Colors.lightGreen,
                                    ),
                                    child: Image.network(
                                      foodList[i].image ?? "assets/logo.png",
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      // color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            foodList[i].name ?? "Item",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade900,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045, // Adjust coefficient as needed
                                            ),
                                          ),
                                          Text(
                                            "Calories: ${foodList[i].calories} Kcal",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035, // Adjust coefficient as needed
                                            ),
                                          ),
                                          Text(
                                            "100 gm",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035, // Adjust coefficient as needed
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}


/*

child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GridView.builder(
                              itemCount: ofBooks.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 300,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                ofBooks[i].bookLinkImage!),
                                            fit: BoxFit.fill)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 60,
                                          color: Colors.black45,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                ofBooks[i].bookLinkName ??
                                                    "NO Data",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

*/