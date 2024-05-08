import 'package:rickandmorty/home.dart';
import 'package:rickandmorty/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:rickandmorty/screens/dashboard_screen.dart';
// import 'package:rickandmorty/screens/items_screen.dart';
// import 'package:rickandmorty/login.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatefulWidget {
   DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
        return [
          HomePage(),
          ProfileScreen()
        ];
    }

  
    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.person),
                title: ("Profile"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}