import 'package:flutter/material.dart';
import 'package:tracker_app/data/dog.dart';

class DogProvider extends InheritedWidget {
  DogProvider({Key key, Widget child, @required this.dog})
      : super(key: key, child: child);
  final Dog dog;

  static DogProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: DogProvider);
  }

  @override
  bool updateShouldNotify(DogProvider old) => false;
}
