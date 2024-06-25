import 'dart:convert';

import 'package:fit_zone/Modal/exerciseModal.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class ExerciseDetails extends StatefulWidget {
  final String id;

  const ExerciseDetails({super.key, required this.id});

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  YoutubePlayerController? controller;

  List<ExerciseModal> singleExercise = [];

  singleExerciseResponse() async {
    var resp = await http.get(Uri.parse(
        "https://appy.trycatchtech.com/v3/fit_zone/single_exercise?id=${widget.id}"));
    if (resp.statusCode == 200) {
      singleExercise =
          ExerciseModal.SingleExerciseListMethod(jsonDecode(resp.body));
      setState(() {
        if (singleExercise.isNotEmpty) {
          controller = YoutubePlayerController(
            initialVideoId: singleExercise[0].url ?? "SALxEARiMkw",
            flags: YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }
      });
    }
  }

  @override
  void initState() {
    singleExerciseResponse();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: singleExercise.isEmpty
          ? null
          : AppBar(
              title: Text(singleExercise[0].name ?? ""),
              centerTitle: true,
              elevation: 1,
            ),
      body: singleExercise.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      singleExercise[0].image ?? "",
                      width: double.infinity,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 24),
                              child: Text(
                                singleExercise[0].name ?? "",
                                softWrap: true,
                                maxLines: null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 26,
                                    color: Colors.grey[850]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Container(
                                width:
                                    MediaQuery.sizeOf(context).width / 2 - 12,
                                child: Text(
                                  singleExercise[0].timimg ?? "",
                                  softWrap: true,
                                  maxLines: null,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                      color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width / 2 - 12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 24, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Type: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.grey[700])),
                                    Text(
                                        singleExercise[0]
                                                .exerciseType
                                                ?.split(',')
                                                .join(',\n') ??
                                            "",
                                        softWrap: true,
                                        maxLines: null,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Muscles: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.grey[700])),
                                    Text("Chest",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    //---------------------------------------

                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 10),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 4, bottom: 12),
                      child: Text(
                        "The deadlift is a strengthening exercise where a loaded barbell is lifted off the ground from a stabilized, bent over position, knees free to bend. It is one of the three canonical powerlifting exercises, along with the squat and bench press.\t",
                        softWrap: true, // Enable soft wrapping
                        maxLines:
                            null, // Allow unlimited lines (wrap to fit container)
                        textAlign: TextAlign.left,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 10),
                      child: Text(
                        "Video Tutorials",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 18, bottom: 10),
                      child: YoutubePlayer(
                        controller: controller!,
                        showVideoProgressIndicator: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 10),
                      child: Text(
                        "Steps",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 24, right: 24, top: 4, bottom: 12),
                      child: Text(
                        "Step 1: Stance. 1” from your shins, 4-6” between your heels, 15° toe angle. \r\nStep 2: Grip. Narrow but outside your legs.\r\nStep 3: Assume the Position. \r\nStep 4: Set your back. \r\nStep 5: Execution.\t",
                        softWrap: true, // Enable soft wrapping
                        maxLines:
                            null, // Allow unlimited lines (wrap to fit container)
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
