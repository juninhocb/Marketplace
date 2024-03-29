import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/cart/cart_history.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    int _selectedIndex = 0;
    late PersistentTabController _controller;
    List pages = [
      MainFoodPage(),
      Container(child: Text("1st"),),
      Container(child: Text("2nd"),),
      Container(child: Text("3rd"),)

    ];

    List<Widget> _buildScreens() {
      return [
        MainFoodPage(),
        Container(child: Text("1st"),),
        CartHistory(),
        Container(child: Text("3rd"),)
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
          icon: Icon(CupertinoIcons.archivebox),
          title: ("Histórico"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.cart),
          title: ("Carrinho"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          title: ("Pessoal"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    void onTapBottomNav(int i){
      setState(() {
        _selectedIndex = i;
      });
    }

    @override
    void initState(){
      super.initState();
      _controller = PersistentTabController(initialIndex: 0);
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
        navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
      );
    }
    /*
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.mainColor,
            unselectedLabelStyle: TextStyle(
              color: AppColors.mainColor
            ),
            showUnselectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: onTapBottomNav,
            selectedItemColor: AppColors.iconColor1,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Histórico"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Carrinho"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Conta"
              )
        ])
      );
    }
    */
  }
