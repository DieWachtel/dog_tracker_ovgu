import 'package:flutter/material.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/BottomNavigation.dart';



class MyWelcomePage extends StatefulWidget {
  MyWelcomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyWelcomePageState createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {

  // ignore: non_constant_identifier_names
  Future<void> pushtoWelcome() async{
    Dog dogy = await DBProvider.db.getUser();
    if(dogy == null){
      var newDog = Dog(name: 'please create Profile', age: 5);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DogProvider(
                dog: newDog,
                child: MyBottomNavigationBar(
                  currentIndex: 0,
                ))),
      );
    }
    else{
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DogProvider(
              dog: dogy,
              child: MyBottomNavigationBar(
                currentIndex: 0,
              ))),
    );
    }
  }


  @override
  Widget build(BuildContext context) {
    // bool dogname = DogProvider.of(context).dog.name?.isEmpty;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Let us go on a Walk!',
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 2
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              color: Colors.blue,
              highlightElevation: 2,
              elevation: 8,
              child: Text('Go!',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 2
                  )
              ),
              onPressed: () async {
               pushtoWelcome();
              }
            )
          ],
        ),
      ),
    );
  }
}
