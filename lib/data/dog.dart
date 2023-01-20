import 'dart:convert';

Dog userFromJson(String str) => Dog.fromJson(json.decode(str));

String userToJson(Dog data) => json.encode(data.toJson());

class Dog {
  int? id;
  String? name;
  int? age;
  String? size;

  Dog({
    this.id,
    this.name,
    this.age,
    this.size,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => Dog(
      id: json["id"],
      name: json["name"],
      age: json["age"],
      size: json["size"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "size": size
  };
}