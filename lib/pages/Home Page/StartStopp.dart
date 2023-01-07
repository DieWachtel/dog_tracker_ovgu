import 'package:flutter/material.dart';

class StartStopp extends StatefulWidget {
  StartStopp({Key key}) : super(key: key);

  @override
  _StartStopp createState() => _StartStopp();
}

class _StartStopp extends State<StartStopp> {

  @override
  Widget build(BuildContext context) {
    bool _stopwatch = true;

    return Container(
        width: 180,
        height: 60,
        color: Colors.white70,
        child: TextButton(
          child: _stopwatch ? Text('Start',
              style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2
              )) : Text('Stop',
              style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2
              )),
          onPressed: () {
            setState(() {
              _stopwatch = !_stopwatch;
            });
          },
        ));
  }
}
