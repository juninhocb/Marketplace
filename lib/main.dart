import 'package:flutter/material.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_popular_controller.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/food_page_body.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/pages/product/popular_product_detail.dart';
import 'package:food_app/pages/product/recommended_product_detail.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_app/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //home: MainFoodPage()
      home: MainFoodPage(),
      //initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes
    );
  }
}

