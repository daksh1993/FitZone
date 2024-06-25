import 'package:fit_zone/View/exer.dart';
import 'package:fit_zone/View/food.dart';
import 'package:fit_zone/View/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String appBarTitle = "FitZone: Your Gym Guide";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.addListener(() {
      setState(() {
        switch (tabController.index) {
          case 0:
            appBarTitle = "Featured Exercise";
          case 1:
            appBarTitle = "FitZone: Your Gym Guide";
            break;
          case 2:
            appBarTitle = "Featured Food";
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: Stack(
            children: [
              Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(color: Colors.black),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Features",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    tabController.animateTo(0);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Symbols.exercise,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Exercise",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    tabController.animateTo(2);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.restaurant_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        "Food",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  ListTile(
                    leading: Icon(Icons.share_outlined),
                    title: Text("Share"),
                  ),
                  ListTile(
                    leading: Icon(Icons.star_border_rounded),
                    title: Text("Rate us"),
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_page_outlined),
                    title: Text("Privacy Policy"),
                  ),
                ],
              ),
              Positioned(
                top: 50.0,
                right: 24.0,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context), // Close drawer
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [ExerciseScreen(), HomeScreen(), FoodScreen()],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: Icon(
                    Symbols.exercise,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(Icons.home_outlined),
                ),
                Tab(
                  child: Icon(Icons.restaurant_rounded),
                )
              ]),
        ),
      ),
    );
  }
}
