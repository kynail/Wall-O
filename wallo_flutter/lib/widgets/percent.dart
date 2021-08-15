import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Percent extends StatelessWidget {
  const Percent({Key key, this.pourcent}) : super(key: key);
  final double pourcent;
  

  @override
  Widget build(BuildContext context) {
    return new CircularPercentIndicator(
                      radius: 55.0,
                      lineWidth: 5.0,
                      percent: pourcent,
                      center: new Text((pourcent * 100).toStringAsFixed(0) + "%"),
                      
                      progressColor:  pourcent > 0.5 ? Colors.green : Colors.redAccent,      
                      animation: true,  
                      animationDuration: 1200,
                      circularStrokeCap: CircularStrokeCap.butt,
                    );
  }
}