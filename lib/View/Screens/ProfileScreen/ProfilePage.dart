import 'package:flutter/material.dart';

import '../../../Utils/global.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double WIDTH=500;
    return Scaffold(
      // appBar: AppBar(title: Text('Profile page'),),
      body: Stack(
        children:[
          Container(
            child: CustomPaint(
              size: Size(WIDTH, (WIDTH*2.2222222222222223).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            )
            ,
          ),
        ]
      ),
    );
  }
}

