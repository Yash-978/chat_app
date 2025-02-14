import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuItemModel {
  UniqueKey? id = UniqueKey();
  String title;
  TabItem riveIcon;

  MenuItemModel({this.id, this.title = "", required this.riveIcon});

  static List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: "Home",
      riveIcon: TabItem(stateMachine: "HOME_interactivity", artboard: "HOME"),
    ),
    MenuItemModel(
      title: "Search",
      riveIcon:
          TabItem(stateMachine: "SEARCH_Interactivity", artboard: "SEARCH"),
    ),
    MenuItemModel(
      title: "Favorites",
      riveIcon:
          TabItem(stateMachine: "STAR_Interactivity", artboard: "LIKE/STAR"),
    ),
    MenuItemModel(
      title: "HELP",
      riveIcon: TabItem(stateMachine: "CHAT_Interactivity", artboard: "CHAT"),
    ),
  ];

  static List<MenuItemModel> menuItems2 = [
    MenuItemModel(
      title: "History",
      riveIcon: TabItem(stateMachine: "TIMER_Interactivity", artboard: "TIMER"),
    ),
    MenuItemModel(
      title: "Notification",
      riveIcon: TabItem(stateMachine: "BELL_Interactivity", artboard: "BELL"),
    ),
  ];
  static List<MenuItemModel> menuItems3 = [
    MenuItemModel(
      title: "Dark Mode",
      riveIcon:
      TabItem(stateMachine: "SETTINGS_Interactivity", artboard: "SETTINGS"),
    ),
  ];
}

class TabItem {
  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  late SMIBool? status;

  TabItem({
    this.id,
    this.stateMachine = "",
    this.artboard = "",
    this.status,
  });

  static List<TabItem> tabItemList = [
    TabItem(stateMachine: "CHAT_interactivity", artboard: "CHAT"),
    TabItem(stateMachine: "SEARCH_interactivity", artboard: "SEARCH"),
    TabItem(stateMachine: "TIMER_interactivity", artboard: "TIMER"),
    TabItem(stateMachine: "BELL_interactivity", artboard: "BELL"),
    TabItem(stateMachine: "USER_interactivity", artboard: "USER"),
  ];
}
