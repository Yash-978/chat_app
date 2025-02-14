import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:rive/rive.dart';

const dividerColor = Color.fromRGBO(37, 45, 50, 1);

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffE4EFF5).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(0, 0, size.width, size.height),
            bottomRight: Radius.circular(size.width * 0.05555556),
            bottomLeft: Radius.circular(size.width * 0.05555556),
            topLeft: Radius.circular(size.width * 0.05555556),
            topRight: Radius.circular(size.width * 0.05555556)),
        paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.3462500);
    path_1.cubicTo(
        0,
        size.height * 0.3462500,
        size.width * 0.05843861,
        size.height * 0.3330913,
        size.width * 0.1135028,
        size.height * 0.2500700);
    path_1.cubicTo(
        size.width * 0.1135028,
        size.height * 0.2500700,
        size.width * 0.1873031,
        size.height * 0.1289150,
        size.width * 0.4749917,
        size.height * 0.1133899);
    path_1.cubicTo(
        size.width * 0.4749917,
        size.height * 0.1133899,
        size.width * 0.9350194,
        size.height * 0.09466012,
        size.width * 0.9833333,
        0);
    path_1.lineTo(0, 0);
    path_1.lineTo(0, size.height * 0.3462500);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4774139, size.height * 0.3420600),
        Offset(size.width * 0.4959056, size.height * -10.08061),
        [Color(0xffB04863).withOpacity(1), Color(0xff7F2E54).withOpacity(1)],
        [0.18, 1]);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 1.008333, size.height * 0.7312500);
    path_2.cubicTo(
        size.width * 0.9999778,
        size.height * 0.7548263,
        size.width * 0.9696417,
        size.height * 0.8197862,
        size.width * 0.8450611,
        size.height * 0.8715500);
    path_2.cubicTo(
        size.width * 0.7239056,
        size.height * 0.9218925,
        size.width * 0.5632889,
        size.height * 0.9390900,
        size.width * 0.4381389,
        size.height * 0.9341450);
    path_2.cubicTo(
        size.width * 0.3688833,
        size.height * 0.9313725,
        size.width * 0.3581167,
        size.height * 0.9237437,
        size.width * 0.2999972,
        size.height * 0.9248462);
    path_2.cubicTo(
        size.width * 0.1734486,
        size.height * 0.9272050,
        size.width * 0.07396472,
        size.height * 0.9662375,
        size.width * 0.008333333,
        size.height);
    path_2.lineTo(size.width * 1.001283, size.height);
    path_2.lineTo(size.width * 1.008333, size.height * 0.7312500);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5087167, size.height * 1.004209),
        Offset(size.width * 0.5094917, size.height * 1.281387), [
      Color(0xffB4B0BC).withOpacity(1),
      Color(0xffB6B3BF).withOpacity(1),
      Color(0xffC6C9D2).withOpacity(1),
      Color(0xffD1DAE2).withOpacity(1),
      Color(0xffDAE5EC).withOpacity(1),
      Color(0xffDFECF2).withOpacity(1),
      Color(0xffE0EEF4).withOpacity(1)
    ], [
      0,
      0.01,
      0.1,
      0.2,
      0.33,
      0.5,
      1
    ]);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * -0.1499353, size.height * 0.7966962);
    path_3.cubicTo(
        size.width * -0.1499353,
        size.height * 0.7966962,
        size.width * 0.2712014,
        size.height * 0.7428137,
        size.width * 0.4078250,
        size.height * 0.9407488);
    path_3.cubicTo(
        size.width * 0.4078250,
        size.height * 0.9407488,
        size.width * 0.1064758,
        size.height * 0.9415950,
        size.width * -0.06010694,
        size.height * 1.066250);
    path_3.lineTo(size.width * -0.1555556, size.height * 1.066250);
    path_3.lineTo(size.width * -0.1499353, size.height * 0.7966962);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.1255361, size.height * 0.7899000),
        Offset(size.width * 0.1263181, size.height * 1.066118),
        [Color(0xffDEEBF1).withOpacity(1), Color(0xff95C8EC).withOpacity(1)],
        [0.31, 1]);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.6930722, size.height * 1.008219);
    path_4.lineTo(size.width * -0.02222222, size.height * 1.007880);
    path_4.cubicTo(
        size.width * -0.02222222,
        size.height * 1.007880,
        size.width * 0.3214778,
        size.height * 0.8000300,
        size.width * 0.6930333,
        size.height * 1.010417);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.3372472, size.height * 0.9162363),
        Offset(size.width * 0.3354056, size.height * 1.009319),
        [Color(0xffB04863).withOpacity(1), Color(0xff9F2D61).withOpacity(1)],
        [0.5, 1]);
    canvas.drawPath(path_4, paint_4_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class RiveModel {
  final String src, artboard, stateMachineName;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
  });

  set setStatus(SMIBool state) {
    state = state;
  }
}

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({
    required this.title,
    required this.rive,
  });
}

List<NavItemModel> bottomNavItems = [
  NavItemModel(
    title: "Chat",
    rive: RiveModel(
      src: "assets/Animations/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Search",
    rive: RiveModel(
      src: "assets/Animations/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
    ),
  ),
  // NavItemModel(
  //   title: "Timer",
  //   rive: RiveModel(
  //     src: "assets/Animations/icons.riv",
  //     artboard: "TIMER",
  //     stateMachineName: "TIMER_Interactivity",
  //   ),
  // ),
  NavItemModel(
    title: "Notification",
    rive: RiveModel(
      src: "assets/Animations/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
    ),
  ),
  NavItemModel(
    title: "Profile",
    rive: RiveModel(
      src: "assets/Animations/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
  ),
];

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xff81B4FF),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

/*
final navController = Get.put(NavigationController());

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final Screen = [
    HomePage(),
    StatusPage(),
    CallPage(),
    ProfilePage(),
  ];
}

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: navController.selectedIndex.value,
          onDestinationSelected: (index) =>
          navController.selectedIndex.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Icons.chat), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.favorite_border), label: 'Status'),
            NavigationDestination(icon: Icon(Icons.call), label: 'Call'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => navController.Screen[navController.selectedIndex.value]),
    );
  }
}

*/