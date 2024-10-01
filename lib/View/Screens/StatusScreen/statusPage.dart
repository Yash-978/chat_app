import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as r;

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            // height: 100,
            bottom: 200,
            width: w*1.7,
            left: 100,
            child: Image.asset("assets/images/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 20,sigmaX: 10),
              child: SizedBox(),
            ),
          ),
          r.RiveAnimation.asset('assets/Animations/shapes.riv'),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 30,sigmaX: 30),
              child: SizedBox(),
            ),
          ),

          // Positioned.fill(
          //
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          //     child: SizedBox(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
