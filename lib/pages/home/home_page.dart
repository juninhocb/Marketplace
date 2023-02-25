import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/home/main_food_page.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    int _selectedIndex = 0;
    List pages = [
      MainFoodPage(),
      Container(child: Text("1st"),),
      Container(child: Text("2nd"),),
      Container(child: Text("3rd"),)

    ];
    void onTapBottomNav(int i){
      setState(() {
        _selectedIndex = i;
      });
    }
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
  }
