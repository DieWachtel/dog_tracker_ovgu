import 'dart:convert';

Data userFromJson(String str) => Data.fromJson(json.decode(str));

String userToJson(Data data) => json.encode(data.toJson());

class Data {
  String size;
  int distance;

  Data({
    this.size,
    this.distance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    size: json["size"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "distance": distance,
  };
}