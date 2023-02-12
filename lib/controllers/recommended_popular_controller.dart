import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_popular_repo.dart';
import '../models/products_model.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController ( { required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList; //made to be called by UI
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;


  Future <void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200){
      print("got products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products as Iterable);
      _isLoaded = true;
      update(); //like set state
    } else {

    }
  }


}