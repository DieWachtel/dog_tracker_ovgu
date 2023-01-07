import 'package:flutter/material.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/BottomNavigation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tracker_app/data/data.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/pages/Home Page/StartStopp.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Dog dog = DogProvider.of(context).dog;
    Data data = DataProvider.of(context).data;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        automaticallyImplyLeading: false,
        title: Text('Hello, ${dog.name}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StartStopp(),
                Container(
                  width: 180,
                  height: 60,
                  alignment: Alignment.center,
                  color: Colors.white70, // changing dependent on km
                  child: AutoSizeText(
                    '0/${data.distance.toString()} km',
                    style: TextStyle(fontSize: 22),
                    maxLines: 1,
                    )
                ), // changing dependent on km
              ],
            )),
            Container(
              width: 376,
              height: 120,
              color: Colors.grey,
            ),
            Container(
              width: 376,
              height: 240,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }


}
