import 'package:flutter/material.dart';
import 'package:food_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController ( { required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList; //made to be called by UI
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;



  Future <void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200){
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products as Iterable);
      _isLoaded = true;
      update(); //like set state
    } else {

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
    }else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity){
    if (quantity < 0){
      Get.snackbar(
          "Contagem de itens", "Não pode reduzir mais",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );

      return 0;
    } else if(quantity > 20){
      Get.snackbar(
          "Contagem de itens", "Não pode acrescentar mais",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(){
    _quantity = 0;
  }

}