import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import '../data/api/api_client.dart';

Future <void> init()async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "url"));
  //repository
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}