import 'dart:math';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:async';

var second1=0;

class Clock1 extends StatefulWidget {
  @override
  _clockState createState() => _clockState();
}

class _clockState extends State<Clock1> {

  /*@override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Container(
          color: Colors.white54,
          constraints: BoxConstraints.expand(
            width: 300,
            height: 300,
          ),
          //width: 300,
          //height: 300,
          child: Transform.rotate(
            angle: -pi/2,
            child: CustomPaint(
              foregroundPainter: LinePointer(),
            ),
          ),
        ),
        SizedBox(height: 50,),
        ElevatedButton(
            onPressed: (){
              print('Second');
              setState(() {
              if(second1==60){
                second1=0;
              }
              second1 +=15;
              });
            },
            child: Text('Second')),
        Text('$second1'),
      ],
    );
  }
}

class LinePointer extends CustomPainter {
  var dateTime=DateTime.now();

  //60 sec - 360, 1 sec 6 degrees
  //12 hours - 360, 1 hour - 30 degrees, 1 min - 0.5 degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush=Paint()
      ..color=Color(0xFFEAECFF);

    var secHandBrush=Paint()
      ..color=Colors.orange.shade300
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=8;

    var minHandBrush=Paint()
      ..shader=RadialGradient(colors:[Color(0xFF748EF6),Color(0XFF77DDFF)]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=12;

    var hourHandBrush=Paint()
      ..shader=RadialGradient(colors:[Color(0xFFEA74AB),Color(0XFFC279FB)]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style=PaintingStyle.stroke
      ..strokeCap=StrokeCap.round
      ..strokeWidth=16;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX=centerX+60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
    var hourHandY=centerY+60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi/180);
    canvas.drawLine(center,Offset(hourHandX,hourHandY),hourHandBrush);

    var minHandX=centerX+80 * cos(dateTime.minute * 6 * pi/180);
    var minHandY=centerY+80 * sin(dateTime.minute * 6 * pi/180);
    canvas.drawLine(center,Offset(minHandX,minHandY),minHandBrush);

    //var secHandX=centerX+80 * cos(second1 * 6 * pi/180);
    //var secHandY=centerY+80 * sin(second1 * 6 * pi/180);

    var secHandX=centerX+80 * cos(second1 * 6 * pi/180);
    var secHandY=centerY+80 * sin(second1 * 6 * pi/180);

    canvas.drawLine(center,Offset(secHandX,secHandY),secHandBrush);
    canvas.drawCircle(center,16,centerFillBrush);

    var outerCircleRadius=radius;
    var innerCircleRadius=radius-14;
    for(double i=0; i<360; i+=12){
      var x1=centerX+outerCircleRadius * cos(i * pi/180);
      var y1=centerX+outerCircleRadius * sin(i * pi/180);

      var x2=centerX+innerCircleRadius * cos(i * pi/180);
      var y2=centerX+innerCircleRadius * sin(i * pi/180);

      canvas.drawLine(Offset(x1,y1), Offset(x2,y2), dashBrush);
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

