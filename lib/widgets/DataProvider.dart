import 'package:flutter/material.dart';
import 'package:tracker_app/data/data.dart';

class DataProvider extends InheritedWidget {
  DataProvider({Key key, Widget child, @required this.data})
      : super(key: key, child: child);
  final Data data;

  static DataProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: DataProvider);
  }

  @override
  bool updateShouldNotify(DataProvider old) => false;
}
