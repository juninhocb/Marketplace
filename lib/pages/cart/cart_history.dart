import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

    List<int> cartOrderTimeToList(){
      return carItemsPerOrder.entries.map((element) => element.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;
    
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
          Expanded(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ((){
                               DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                               var inputDate = DateTime.parse(parseDate.toString());
                               var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
                               var outputData = outputFormat.format(inputDate);
                               return BigText(text: outputData);
                             }()),
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
                                      BigText(text: (itemsPerOrder.length + 1).toString() + " Items", color: AppColors.titleColor,),
                                      SizedBox(height: Dimensions.height10,),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width10/2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                          border: Border.all(width: 1, color: AppColors.mainColor)
                                        ),
                                        child: SmallText(text: "one more", color: AppColors.mainColor,),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                      )


                  ],

                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
