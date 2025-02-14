import 'package:chat_app/View/Screens/SideMenu/menu_Item.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/cupertino.dart';

class MenuRow extends StatelessWidget {
  const MenuRow(
      {super.key,
      required this.menu,
      this.selectedMenu = "Home",
      this.onMenuPress});

  final MenuItemModel menu;
  final String selectedMenu;
  final Function? onMenuPress;

  void _onMenuIconInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, menu.riveIcon.stateMachine);
    artboard.addController(controller!);
    menu.riveIcon.status = controller.findInput<bool>("active") as SMIBool;
  }

  void onMenuPressed() {
    if (selectedMenu != menu.title) {
      onMenuPress!();
      menu.riveIcon.status!.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        menu.riveIcon.status!.change(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Stack(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: selectedMenu == menu.title ? 288 - 16 : 0,
        height: 56,
        //h * 0.06,
        curve: Cubic(0.2, 0.8, 0.2, 1),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      ),
      CupertinoButton(
        onPressed: onMenuPressed,
        padding: EdgeInsets.all(12),
        pressedOpacity: 1,
        child: Row(
          children: [
            SizedBox(
              height: 32,
              width: 32,
              child: Opacity(
                opacity: 0.6,
                child: RiveAnimation.asset(
                  "assets/Animations/icons.riv",
                  stateMachines: [menu.riveIcon.stateMachine],
                  artboard: menu.riveIcon.artboard,
                  onInit: _onMenuIconInit,
                ),
              ),
            ),
            SizedBox(
              width: w * 0.04,
            ),
            Text(
              menu.title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ]);
  }
}

//
// class MenuRow extends StatefulWidget {
//   const MenuRow({
//     super.key,
//     required this.menu,
//     this.selectedMenu = "Home",
//     this.onMenuPress,
//   });
//
//   final MenuItemModel menu;
//   final String selectedMenu;
//   final Function? onMenuPress;
//
//   @override
//   _MenuRowState createState() => _MenuRowState();
// }
//
// class _MenuRowState extends State<MenuRow> {
//   bool isPressed = false;
//   double containerWidth = 0;
//   Color containerColor = Colors.transparent;
//
//   void _onMenuIconInit(Artboard artboard) {
//     final controller = StateMachineController.fromArtboard(
//         artboard, widget.menu.riveIcon.stateMachine);
//     artboard.addController(controller!);
//     widget.menu.riveIcon.status = controller.findInput<bool>("active") as SMIBool;
//   }
//
//   void onMenuPressed() {
//     // Trigger Rive animation
//     widget.onMenuPress?.call();
//     widget.menu.riveIcon.status?.change(true);
//
//     // Animate container
//     setState(() {
//       isPressed = true;
//       containerWidth = 288 - 16; // Full width
//       containerColor = Colors.blue; // Desired color
//     });
//
//     Future.delayed(const Duration(seconds: 1), () {
//       widget.menu.riveIcon.status?.change(false);
//       setState(() {
//         containerWidth = 0; // Reset container width
//         containerColor = Colors.transparent; // Reset color
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           width: containerWidth, // Animate width change
//           height: 56,
//           curve: Curves.easeInOut,
//           decoration: BoxDecoration(
//             color: containerColor, // Animate color change
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         GestureDetector(
//           onTap: onMenuPressed,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 SizedBox(
//                   height: 32,
//                   width: 32,
//                   child: Opacity(
//                     opacity: 0.6,
//                     child: RiveAnimation.asset(
//                       "assets/Animations/icons.riv",
//                       stateMachines: [widget.menu.riveIcon.stateMachine],
//                       artboard: widget.menu.riveIcon.artboard,
//                       onInit: _onMenuIconInit,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Text(
//                   widget.menu.title,
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
