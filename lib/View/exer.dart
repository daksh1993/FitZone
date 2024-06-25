import 'dart:convert';

import 'package:fit_zone/Modal/ExerListModal.dart';
import 'package:fit_zone/View/exerDetails.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  
  List<ExerciseListModal> exerciseList = [];
  exerciseResponse() async {
    var resp = await http.get(Uri.parse(
        "https://appy.trycatchtech.com/v3/fit_zone/exercise_list?category_id=1,2,3"));
    if (resp.statusCode == 200) {
      exerciseList =
          ExerciseListModal.ExerciseListMethod(jsonDecode(resp.body));
      // print(resp.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    exerciseResponse();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
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
                          hintText: "Type here to search something",
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
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
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
              exerciseList.isEmpty
                  ? Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: Colors.black,
                    )))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: exerciseList.length,
                        itemBuilder: (BuildContext context, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExerciseDetails(
                                          id: exerciseList[i].id ?? "1")));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                height: 150,
                                child: Stack(
                                  children: [
                                    // Container for the image
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              exerciseList[i].image ??
                                                  "assets/find.png"),
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                    // Container for the overlay
                                    Positioned(
                                      left: 20,
                                      top: 25,
                                      bottom: 25,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),

                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        // Adjust opacity here
                                        child: Column( 
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              exerciseList[i].catDifficulty ??
                                                  "Fetching",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                                exerciseList[i].name ??
                                                    "Fetching",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      top: 110,
                                      right: 0,
                                      bottom: 0,
                                      left: MediaQuery.sizeOf(context).width /
                                          1.6,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExerciseDetails(
                                                          id: exerciseList[i]
                                                                  .id ??
                                                              "1",
                                                        )));
                                            // Add your onPressed functionality here
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white
                                                .withOpacity(
                                                    0.6), // Adjust opacity here
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12),
                                              ),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
