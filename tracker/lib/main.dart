import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      routes: {
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _title = 'Add your dog here';
  bool _showPlusButton = true;
  bool _showDeleteButton = false;

  void _hidePlusButton() { //_hidePlusBotton(); has to be called to hide the botton again
    setState(() {
      _showPlusButton = false;
      _showDeleteButton = true;
    });
  }

  void _shPlusButton() { //_shPlusBotton(); has to be called to hide the botton again
    setState(() {
      _showPlusButton = true;
      _showDeleteButton = false;
    });
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
        body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: 200.0,
           child: ListTile(
            title: InkWell(
              child: Container(
                width: 20.0,
                height: 150.0,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onTap: () {
                // Add your onTap code here!
              },
            ),
          ),
          ),
          ),
        ],
      ),
      floatingActionButton: _showPlusButton
      ? FloatingActionButton(
        child: Icon(Icons.add),
              onPressed: () { 
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondPage(),
                ),
              );
             _hidePlusButton();
            },
      )
      : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: BottomAppBar(
        child: _showPlusButton
            ? Container(
                height: 50.0,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _shPlusButton();
                    },
            ),
          ],
        ),
      ),
    );
  }
}



class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Second Page'),
      ),
    );
  }
}


