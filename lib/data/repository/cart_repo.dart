import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void initCart (){
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      cart = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
  }

  void addToCartList(List<CartModel> cartList){
    //sharedPreferences.remove(AppConstants.CART_HISTORY);
    //sharedPreferences.remove(AppConstants.CART_LIST);
    var time = DateTime.now().toString();
    cart =[];
    cartList.forEach((element) {
       element.time = time;
       cart.add(jsonEncode(element));
    });


    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    carts.forEach((element) { 
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  List<CartModel> getCartHistory(){
    print("The first of cart: ${cart.length}");
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }

    List<CartModel> listCartHistory = <CartModel>[];
    cartHistory.forEach((element) {
      listCartHistory.add(CartModel.fromJson(jsonDecode(element)));
    });

    return listCartHistory;

  }

  void addToCartHistoryList(){
    //sharedPreferences.remove(AppConstants.CART_HISTORY);
    //sharedPreferences.remove(AppConstants.CART_LIST);
    print("The first: ${cartHistory.length}");
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    for (int i =0; i < cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);


  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }



}