import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/home_page.dart';
import 'package:food_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/home/main_food_page.dart';
import '../pages/product/popular_product_detail.dart';
import '../pages/product/recommended_product_detail.dart';

class RouteHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularProduct = "/popular-product";
  static const String recommendedProduct = "/recommended-product";
  static const String cartPage = "/cart-page";

  static String getSplashPage ()=> '$splashPage';
  static String getInitial () => '$initial';
  static String getPopularProduct(int pageId) => '$popularProduct?pageId=$pageId';
  static String getRecommendedProduct(int pageId) => '$recommendedProduct?pageId=$pageId';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: initial, page: ()=> HomePage()),
    GetPage(name: popularProduct, page: () {
      var pageId = Get.parameters['pageId'];
      return PopularProductDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: recommendedProduct, page: () {
      var pageId = Get.parameters['pageId'];
      return RecommendedProductDetail(pageId: int.parse(pageId!));
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cartPage, page: () {
      return CartPage();
    },
        transition: Transition.fadeIn
    )

  ];

}