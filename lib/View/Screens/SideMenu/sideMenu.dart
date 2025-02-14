import 'package:chat_app/View/Screens/SideMenu/menu_Item.dart';
import 'package:chat_app/View/Screens/SideMenu/menu_Row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// import 'flutter';

final List<MenuItemModel> _browseMenuIcons = MenuItemModel.menuItems;
final List<MenuItemModel> _historyMenuIcons = MenuItemModel.menuItems2;
final List<MenuItemModel> _themeMenuIcons = MenuItemModel.menuItems3;
bool _isDarkMode = false;
String _selectedMenu = MenuItemModel.menuItems[0].title;

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  void onThemeRiveIconInit(artboard) {
    final controller = StateMachineController.fromArtboard(
        artboard, _themeMenuIcons[0].riveIcon.stateMachine);
    artboard.addController(controller!);
    _themeMenuIcons[0].riveIcon.status =
    controller.findInput<bool>("active") as SMIBool;
  }

  void onMenuPress(MenuItemModel menu) {
    setState(() {
      _selectedMenu = menu.title;
    });
  }

  void onThemeToggle(value) {
    setState(() {
      _isDarkMode = value;
    });
    _themeMenuIcons[0].riveIcon.status!.change(value);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery
                .of(context)
                .padding
                .top,
            bottom: MediaQuery
                .of(context)
                .padding
                .bottom),
        constraints: const BoxConstraints(maxWidth: 288),
        decoration: BoxDecoration(
          color: const Color(0xff18213A),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.person_2_outlined),
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: w * 0.08,
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Yash",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
                        "Software Engineer",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  )
                ],
              ),
            ),
            MenuButtonSection(
              title: 'BROWSE',
              selectedMenu: _selectedMenu,
              menuIcons: _browseMenuIcons,
              onMenuPress: onMenuPress,
            ),
            MenuButtonSection(
              title: 'HISTORY',
              onMenuPress: onMenuPress,
              selectedMenu: _selectedMenu,
              menuIcons: _historyMenuIcons,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  SizedBox(
                      height: 32,
                      width: 32,
                      child: Opacity(
                        opacity: 0.6,
                        child: RiveAnimation.asset(
                          "assets/Animations/icons.riv",
                          stateMachines: [
                            _themeMenuIcons[0].riveIcon.stateMachine
                          ],
                          artboard: _themeMenuIcons[0].riveIcon.artboard,
                          onInit: onThemeRiveIconInit,
                        ),
                      )),
                  Expanded(
                    child: Text(
                      _themeMenuIcons[0].title,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  CupertinoSwitch(value: _isDarkMode, onChanged: onThemeToggle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuButtonSection extends StatelessWidget {
  const MenuButtonSection({Key? key,
    required this.title,
    required this.menuIcons,
    this.selectedMenu = "Home",
    this.onMenuPress})
      : super(key: key);

  final String title;
  final String selectedMenu;
  final List<MenuItemModel> menuIcons;
  final Function(MenuItemModel menu)? onMenuPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 40,
            bottom: 8,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              for (var menu in menuIcons) ...[
                Divider(
                  color: Colors.white.withOpacity(0.1),
                  height: 1,
                  indent: 16,
                  thickness: 1,
                  endIndent: 16,
                ),
                MenuRow(
                  menu: menu,
                  selectedMenu: selectedMenu,
                  onMenuPress: () => onMenuPress!(menu),
                ),
              ],
            ],
          ),
        )
      ],
    );
  }
}
