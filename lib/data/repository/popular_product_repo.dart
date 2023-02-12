import 'package:food_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
      return await apiClient.getData(AppConstants.POPULAR_PRDUCT_URI);
  }
}