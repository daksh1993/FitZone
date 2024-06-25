class ExerciseModal {
  String? id;
  String? name;
  String? exerciseType;
  String? exerciseEquipments;
  String? exerciseMuscles;
  String? description;
  String? image;
  String? timimg;
  String? url;
  String? steps;

  ExerciseModal(
      {this.id,
      this.name,
      this.exerciseType,
      this.exerciseEquipments,
      this.exerciseMuscles,
      this.description,
      this.image,
      this.timimg,
      this.url,
      this.steps});

  ExerciseModal.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    exerciseType = json["exercise_type"];
    exerciseEquipments = json["exercise_equipments"];
    exerciseMuscles = json["exercise_muscles"];
    description = json["description"];
    image = json["image"];
    timimg = json["timimg"];
    url = json["url"];
    steps = json["steps"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["exercise_type"] = exerciseType;
    _data["exercise_equipments"] = exerciseEquipments;
    _data["exercise_muscles"] = exerciseMuscles;
    _data["description"] = description;
    _data["image"] = image;
    _data["timimg"] = timimg;
    _data["url"] = url;
    _data["steps"] = steps;
    return _data;
  }

  static List<ExerciseModal> SingleExerciseListMethod(List SingleexerciseItem) {
    return SingleexerciseItem.map((e) => ExerciseModal.fromJson(e)).toList();
  }
}
