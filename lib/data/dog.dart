import 'dart:convert';

Dog userFromJson(String str) => Dog.fromJson(json.decode(str));

String userToJson(Dog data) => json.encode(data.toJson());

class Dog {
  String name;
  int age;

  Dog({
    this.name,
    this.age,
  });

  factory Dog.fromJson(Map<String, dynamic> json) => Dog(
    name: json["name"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
  };
}