import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:food_app/data/repository/recommended_popular_repo.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_popular_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/cart_repo.dart';

Future <void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  //initialize the shared preferences
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(()=> CartRepo(sharedPreferences: Get.find()));
  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}