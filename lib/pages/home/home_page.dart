import 'package:flutter/cupertino.dart';
import 'package:food_app/pages/home/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List pages = [
  MainFoodPage(),
  Container(child: Text("1st"),),
  Container(child: Text("2nd"),),
  Container(child: Text("3rd"),)

];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return pages[0];
  }
}
