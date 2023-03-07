import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get
        .find<CartController>()
        .getCartHistoryList()
        .reversed
        .toList();

    Map<String, int> carItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++){
      if (carItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        carItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        carItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<String> cartOrderTimeToList(){
      return carItemsPerOrder.entries.map((element) => element.key).toList();
    }

    List<int> cartItemsPerOrderToList(){
      return carItemsPerOrder.entries.map((element) => element.value).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;

    Widget timeWidget(int index){
      var outputData = DateTime.now().toString();
      if (index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
        outputData = outputFormat.format(inputDate);

      }
      return BigText(text: outputData);
    }
    
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.height10*10,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white, size: Dimensions.font26,),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined, iconColor: AppColors.mainColor, backgroundColor: Colors.white, )
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length > 0 ? Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      //carItemsPerOrder.length
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    spacing: Dimensions.width10/2,
                                    children: List.generate(itemsPerOrder[i], (index) {
                                      if(listCounter < getCartHistoryList.length){
                                        listCounter++;
                                      }
                                      return index <= 2 ? Container(
                                        height: Dimensions.height20*4,
                                        width: Dimensions.width20*4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL+AppConstants.UPLOADS_URL+getCartHistoryList[listCounter- 1].img!
                                                ))
                                        ),
                                      ) : Container();
                                    }),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallText(text: "Total", color: AppColors.titleColor),
                                        SizedBox(height: Dimensions.height10,),
                                        BigText(text: (itemsPerOrder[i] == 1 ? itemsPerOrder[i].toString() + " Item " : itemsPerOrder[i].toString() + " Items "), color: AppColors.titleColor,),
                                        SizedBox(height: Dimensions.height10,),
                                        GestureDetector(
                                          onTap: (){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for (int j = 0; j < getCartHistoryList.length; j++){
                                              if (getCartHistoryList[j].time == orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                border: Border.all(width: 1, color: AppColors.mainColor)
                                            ),
                                            child: SmallText(text: "one more", color: AppColors.mainColor,),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )


                    ],

                  ),
                ),
              ),
            ) : NoDataPage(text: "Não há itens no histórico", imgPath: "imgPath");
          })

        ],
      ),
    );
  }
}
