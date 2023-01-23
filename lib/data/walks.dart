import 'dart:convert';

Walk userFromJson(String str) => Walk.fromJson(json.decode(str));

String userToJson(Walk data) => json.encode(data.toJson());

class Walk {
  int? id;
  String? name;
  String? date;
  int? distance;

  Walk({
    this.id,
    this.name,
    this.date,
    this.distance,
  });

  factory Walk.fromJson(Map<String, dynamic> json) => Walk(
    id: json["id"],
    name: json["name"],
    date: json["date"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "date": date,
    "distance": distance,
  };
}