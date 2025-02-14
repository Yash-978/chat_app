import 'package:chat_app/View/Screens/StatusScreen/statusPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../../Utils/global.dart';
import '../CallScreen/callPage.dart';
import '../HomeScreen/homeScreen.dart';
import '../ProfileScreen/ProfilePage.dart';
import '../SideMenu/sideMenu.dart';

late AnimationController? _animationController;

late Animation<double> _sidebarAnim;

var bottomNavigationBgColor = const Color(0xff17203A);

int selectedNavIndex = 0;
Widget _tabBody = Container(color: Colors.white,);
final List<Widget> Screen = <Widget>[
  const HomePage(),
  const StatusPage(),
  const CallPage(),
  const ProfilePage(),
];
final springDesc = SpringDescription(
  mass: 0.1,
  stiffness: 40,
  damping: 5,
);

List<SMIBool> riveIconInput = [];

class BottomNavWithAnimatedIcons extends StatefulWidget {
  const BottomNavWithAnimatedIcons({super.key});

  @override
  State<BottomNavWithAnimatedIcons> createState() =>
      _BottomNavWithAnimatedIconsState();
}

class _BottomNavWithAnimatedIconsState extends State<BottomNavWithAnimatedIcons>
    with TickerProviderStateMixin {
  List<StateMachineController?> controllers = [];

  late SMIBool _menuBtn;

  void animateTheIcon(int index) {
    riveIconInput[index].change(true);
    Future.delayed(const Duration(seconds: 1), () {
      riveIconInput[index].change(false);
    });
  }

  void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? stmController =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(stmController!);
    controllers.add(stmController);
    riveIconInput.add(stmController.findInput<bool>("active") as SMIBool);
  }

  void _onMenuIconInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine");
    artboard.addController(controller!);
    _menuBtn = controller.findInput<bool>("isOpen") as SMIBool;
    _menuBtn.value = true;
  }

  void onMenuPress() {
    if (_menuBtn.value) {
      final springAnim = SpringSimulation(springDesc, 0, 1, 0);
      _animationController?.animateWith(springAnim);
    } else {
      _animationController?.reverse();
    }
    _menuBtn.change(!_menuBtn.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );
    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );
    _tabBody = Screen.first;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
    for (var controller in controllers) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SideMenu(),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context, child) {
              return Transform.translate(
                  offset: Offset(_sidebarAnim.value * 265, 0), child: child);
            },
            child: _tabBody,
          ),
          SafeArea(
            child: GestureDetector(
              onTap: onMenuPress,
              child: Container(
                height: 44,
                width: 44,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44 / 2),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff18213A).withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: RiveAnimation.asset(
                  "assets/Animations/menu_button.riv",
                  stateMachines: ["State Machine"],
                  animations: ["open", "close"],
                  onInit: _onMenuIconInit,
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(

        child: Container(
          height: 56,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bottomNavigationBgColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: bottomNavigationBgColor.withOpacity(0.3),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                bottomNavItems.length,
                (index) {
                  final riveIcon = bottomNavItems[index].rive;
                  return GestureDetector(
                    onTap: () {
                      animateTheIcon(index);
                      setState(() {
                        _tabBody = Screen[index];
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                          isActive: selectedNavIndex == index,
                        ),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: selectedNavIndex == index ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              bottomNavItems[index].rive.src,
                              artboard: bottomNavItems[index].rive.artboard,
                              onInit: (artboard) {
                                riveOnInIt(artboard,
                                    stateMachineName:
                                        riveIcon.stateMachineName);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
