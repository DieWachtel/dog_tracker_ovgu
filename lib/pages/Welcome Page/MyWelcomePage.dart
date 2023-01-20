import 'package:flutter/material.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/BottomNavigation.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracker_app/data/data.dart';


class MyWelcomePage extends StatefulWidget {
  MyWelcomePage({Key? key}) : super(key: key);
  
  @override
  _MyWelcomePageState createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {
  
  
  // ignore: non_constant_identifier_names
  Future<void> pushToWelcome() async{
    //init predefined dog distances
    Data? data = await DBProvider.db.getData('gross');
    if (data == null){

      var _gross = Data(size: 'Large', distance: 10);
      var _mittel = Data(size: 'Medium', distance: 7);
      var _klein = Data(size: 'Small', distance: 5);
      var _undef = Data(size: '', distance: 0);

      final List<Data> _dogData = [
        _gross,
        _mittel,
        _klein,
        _undef,
      ];

      for(var i = 0; i < 4; i++) {
        await DBProvider.db.newData(_dogData[i]);
      }
    }

    Dog? dogy = await DBProvider.db.getUser(1);
    if(dogy == null){
      data = await DBProvider.db.getData('');
      var newDog = Dog(id: 1, name: 'please create Profile', age: 0, size: '');
      await DBProvider.db.newUser(newDog);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DogProvider(
                dog: newDog,
                child: DataProvider(
                    data: data,
                    child: MyBottomNavigationBar(
                  currentIndex: 0,
                )))),
      );
    }
    else{
      String? _data = dogy.size;
      Data? data = await DBProvider.db.getData(_data);
      Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DogProvider(
              dog: dogy,
              child: DataProvider(
                data: data,
                  child: MyBottomNavigationBar(
                currentIndex: 0,
              )))),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),//EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                backgroundColor: Colors.blue,
                elevation: 8,
              ),
              child: Text('Go!',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 2
                  )
              ),
              onPressed: () async {
               pushToWelcome();
              }
            )
          ],
        ),
      ),
    );
  }
}
