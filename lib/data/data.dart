import 'dart:convert';

Data userFromJson(String str) => Data.fromJson(json.decode(str));

String userToJson(Data data) => json.encode(data.toJson());

class Data {
  String race;
  int distance;

  Data({
    this.race,
    this.distance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    race: json["race"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "race": race,
    "distance": distance,
  };
}