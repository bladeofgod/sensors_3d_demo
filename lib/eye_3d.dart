


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class Eye3d extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Eye3dState();
  }

}

class Eye3dState extends State<Eye3d> {

  late AccelerometerEvent acceleration;
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late Size size;

  double x = 0;
  double y = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) async {
          acceleration = event;
          final ax = acceleration.x;
          final ay = acceleration.y;
          //if(timer != null && timer!.isActive) timer!.cancel();
          void doFrame() {
            setState(() {
              x = ax*3;
              y = ay*3;
            });
          }
          doFrame();
          // timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
          //   doFrame();
          // });


          // WidgetsBinding.instance!.scheduleFrameCallback((timeStamp) {
          //   setState(() {
          //     x = 20 * (ax / 20);
          //     y = 20 * (ay / 20);
          //   });
          // });
        });
  }


  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  int duration = 16 *10;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.greenAccent,
            width: size.width, height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                    top: y - 40,
                    right: x,
                    duration: Duration(milliseconds: duration),
                    child: _bottom()),
                Positioned(
                    child: _middle()),
                AnimatedPositioned(
                    bottom: y - 10,
                    left: x + size.width/3,
                    duration: Duration(milliseconds: duration),
                    child: _top()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottom() {
    return Container(
      width: size.width+60,height: 230,
      child: Image.asset('assets/images/bg.png',fit: BoxFit.fill,),
    );
  }

  Widget _middle() {
    return Text('悄悄滴进村，打枪滴不要',style: TextStyle(fontSize: 22),);
  }

  Widget _top() {
    return Container(
      width: 100, height: 100,
      child: Image.asset('assets/images/car.png',fit: BoxFit.fill),
    );
  }


}











