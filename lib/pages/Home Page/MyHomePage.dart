import 'package:flutter/material.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/BottomNavigation.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tracker_app/data/data.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> with SingleTickerProviderStateMixin{
//Maxi Geolocator
  late Position? _currentPosition;
  late Position? _previousPosition;
  double _distance = 0;
  late Timer _timer;
  bool _isTracking = false;
  late StreamSubscription<Position> _locationSubscription;
  final Geolocator _location = Geolocator();
  double _totalDistance = 0;
  bool _stopwatch = true;
  Stopwatch stopwatch = Stopwatch();
  late AnimationController _controller;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
    _requestLocationPermission();
    _getCurrentLocation();
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      _previousPosition = _currentPosition;
      _getCurrentLocation();
      _calculateDistance();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
    });
    _locationSubscription = Geolocator.getPositionStream().listen((location) {
      if(_isTracking) {
        _calculateDistance();
      }
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
      //_totalDistance += _distance;
      _distance = 0;
    });
    _locationSubscription.cancel();
  }


  void _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status != PermissionStatus.granted) {
      var future = await Permission.location.request();
      if (future == PermissionStatus.granted) {
        _getCurrentLocation();
      } else {
        print('error');
        // Handle the error
      }
    }
    else _getCurrentLocation();
  }
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      _currentPosition = position;
    });
  }

    Future<void> _calculateDistance() async {
      if (_isTracking) {
        final distanceInKm = await Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          _previousPosition!.latitude,
          _previousPosition!.longitude,
        )/1000;
        setState(() {
          _distance += distanceInKm;
          _totalDistance += distanceInKm;
        });
        _previousPosition = _currentPosition;
      }
    }

  int? _getdismod(int? _age, int? _distance){
    if(_age!<3||_age!>8) _distance = (_distance!-2)!;
    return _distance;
  }

  @override
  Widget build(BuildContext context) {
    Dog dog = DogProvider.of(context)!.dog;
    Data data = DataProvider.of(context)!.data!;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white70,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                        //height: 60,
                            alignment: Alignment.center,
                            child: TextButton(
                          child: _stopwatch ? Text('Start',
                              style: TextStyle(
                                  fontSize: 22,
                                  letterSpacing: 2
                              )) : Text('Stop',
                              style: TextStyle(
                                  fontSize: 22,
                                  letterSpacing: 2,
                                  color: Colors.orange
                              )),
                          onPressed: () {
                            setState(() {
                              if(_stopwatch){
                                _startTracking();
                                _controller.repeat();
                                stopwatch.start();
                              }
                              else{
                                _stopTracking();
                                _controller.stop();
                                stopwatch.stop();
                              }
                              _stopwatch = !_stopwatch;
                            });
                          },
                        )),
                      ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white70,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(50, 0, 0, 0),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                      //height: 60,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text('Reset',
                            style: TextStyle(
                                fontSize: 22,
                                letterSpacing: 2
                            )),
                          onPressed: () {
                              setState(() {
                              _controller.stop();
                              stopwatch.reset();
                              _stopwatch = true;
                          });}
                      ),
                      ),
                  )
                  ]),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      blurRadius: 15,
                    ),
                  ],
                ),
                //height: 90,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Walk time:',
                        style: TextStyle(
                          fontSize: 22,
                          letterSpacing: 2)
                      ),
                      Text(
                          stopwatch.elapsed.inMinutes.toString().padLeft(2, '0') +
                              ':' +
                              (stopwatch.elapsed.inSeconds % 60)
                                  .toString()
                                  .padLeft(2, '0'),
                          style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 0, 0, 0),
                      blurRadius: 15,
                    ),
                  ],
                ),
                //height: 270,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Last distance:",
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 2)),
                    Text("${_distance.toStringAsFixed(2)} km",
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2)),
                    //SizedBox(height: 10,),
                    Text("Total distance:",
                        style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 2)),
                    Text("${_totalDistance.toStringAsFixed(2)} / ${_getdismod(dog.age, data.distance)}  km",
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
