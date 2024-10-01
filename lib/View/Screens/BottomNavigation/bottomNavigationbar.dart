import 'package:chat_app/View/Screens/StatusScreen/statusPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../CallScreen/callPage.dart';
import '../HomeScreen/homeScreen.dart';
import '../ProfileScreen/ProfilePage.dart';

var bottomNavigationBgColor = const Color(0xff17203A);
int selectedNavIndex = 0;
final List<Widget> Screen = <Widget>[
  const HomePage(),
  const StatusPage(),
  const CallPage(),
  const ProfilePage(),
];

List<SMIBool> riveIconInput = [];

class BottomNavWithAnimatedIcons extends StatefulWidget {
  const BottomNavWithAnimatedIcons({super.key});

  @override
  State<BottomNavWithAnimatedIcons> createState() =>
      _BottomNavWithAnimatedIconsState();
}

class _BottomNavWithAnimatedIconsState
    extends State<BottomNavWithAnimatedIcons> {
  List<StateMachineController?> controllers = [];

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (var controller in controllers) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screen[selectedNavIndex],
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
                        selectedNavIndex = index;
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
