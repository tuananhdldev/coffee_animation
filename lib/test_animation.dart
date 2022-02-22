import 'package:flutter/material.dart';

class TestAnimation extends StatefulWidget {
  const TestAnimation({Key? key}) : super(key: key);

  @override
  _TestAnimationState createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation> {

  bool _isSwitch = false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(child: Container(
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                // child: Container(
                //   key:Key(_isSwitch?"1":"2"),
                //   width: 100, height: 100,
                // color: _isSwitch?Colors.amber:Colors.blue,
                // ),
                child: Text(_isSwitch?"love":"gratitude",
                  key:Key(_isSwitch?"1":"2"),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
      )),
      floatingActionButton: ElevatedButton( onPressed: (){
        setState(() {
          _isSwitch = !_isSwitch;
        });

      },
      child: const Text("switch"),
      ),
    );
  }
}
