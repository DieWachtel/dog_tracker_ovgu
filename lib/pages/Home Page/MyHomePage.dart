import 'package:flutter/material.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/BottomNavigation.dart';



class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Dog dog = DogProvider.of(context).dog;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 180,
                    height: 60,
                    color: Colors.grey,
                    child: FlatButton(
                      onPressed: () async {},
                      child: Text('Start',
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2
                        ))
                )),
                Container(
                  width: 180,
                  height: 60,
                  alignment: Alignment.center,
                  color: Colors.grey, // changing dependent on km
                  child: Text('0/10 km',
                    style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 2
                    ))
                ), // changing dependent on km
              ],
            ),
            Container(
              width: 375,
              height: 120,
              color: Colors.grey,
            ),
            Container(
              width: 375,
              height: 240,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }


}
