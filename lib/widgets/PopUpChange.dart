import 'package:tracker_app/widgets/BottomNavigation.dart';
import 'package:tracker_app/widgets/DogProvider.dart';
import 'package:tracker_app/widgets/DataProvider.dart';
import 'package:tracker_app/data/data.dart';
import 'package:tracker_app/data/Database.dart';
import 'package:tracker_app/data/dog.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog(this.value, this.dog, this.data);

  final value;
  final dog;
  final data;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _age;
  String _oldname;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, widget.value, widget.dog, widget.data),
    );
  }

  dialogContent(context, String value, Dog dog, Data data) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(30.0),
            decoration:
            new BoxDecoration(
                color: Colors.white, shape: BoxShape.rectangle, boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              )
            ]),
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        'Change your $value',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      getText(value, dog, data),
                    ]))),
      ],
    );
  }

  getText(String value, Dog dog, Data data) {
    _oldname = dog.name;
    if (value == 'name') {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.pets),
                hintText: 'Enter your dogs name',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name';
                }
                if (value == dog.name) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (dog.name != _name)) {
                        print(_name);
                        await DBProvider.db.changeName(_name, _oldname);
                        dog = await DBProvider.db.getUser(1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DogProvider(
                                      dog: dog,
                                      child: DataProvider(
                                          data: data,
                                          child: MyBottomNavigationBar(
                                        currentIndex: 1,
                                      )))),
                        );
                      }
                      // Process data
                      return null;
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
                ))
          ],
        ),
      );
    }

    if (value == 'age') {
      _name = dog.name;
      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.pets),
                hintText: 'Enter your dogs age',
              ),
              style: TextStyle(fontSize: 20.0),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an age';
                }
                if (int.tryParse(value) == dog.age) {
                  return 'Nothing changed';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 24.0),
            Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (true && (dog.age != _age)) {
                        await DBProvider.db.changeAge(_age, _name);
                        dog = await DBProvider.db.getUser(1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DogProvider(
                                      dog: dog,
                                      child: DataProvider(
                                        data: data,
                                          child: MyBottomNavigationBar(
                                        currentIndex: 1,
                                      )))),
                        );
                      }
                      return null;
                      // Process data
                    }
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
                ))
          ],
        ),
      );
    }

  }
}