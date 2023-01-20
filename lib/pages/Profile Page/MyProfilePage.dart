import 'package:flutter/material.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/data/data.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/PopUpChange.dart';


class MyProfilePage extends StatefulWidget {
  MyProfilePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {


  @override
  Widget build(BuildContext context) {
    Dog dog = DogProvider.of(context)!.dog;
    Data data = DataProvider.of(context)!.data!;
    print(data.size);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
          automaticallyImplyLeading: false,
          title: Text('Dog Profile')
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name:',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 195,
                      child: Text(dog.name!,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20, color: Colors.blue,),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("name", dog, data),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Age:',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0)),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 195,
                      child: Text(dog.age.toString(),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0)),
                    ),
                    IconButton(
                      icon: Icon(Icons.create, size: 20, color: Colors.blue,),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog("age", dog, data),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Size:',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0)),
                SizedBox(
                  width: 195,
                  child: Text(data.size!,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                ),
                IconButton(
                  icon: Icon(Icons.create, size: 20, color: Colors.blue,),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog("size", dog, data),
                    );
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Recommended\ndistance:',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0)),
                Text('${data.distance} km',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0)),
                Icon(Icons.directions_walk, size: 20, color: Colors.blue,),
                // get from predefined database
              ],
            ),
          ],
        ),
      ),)
    );
  }
}
