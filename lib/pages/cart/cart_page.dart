import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right:  Dimensions.width20,
              child: Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24),
                SizedBox(width: Dimensions.width20*5),
                GestureDetector(
                    onTap: (){
                      Get.to(() => MainFoodPage());
                    },
                    child: AppIcon(icon: Icons.home, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24)),
                AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24)
              ],
          )),
          Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (controller){
                    return ListView.builder(
                        itemCount: controller.getItems.length,
                        itemBuilder: (_, index){
                          return Container(
                            width: double.maxFinite,
                            height: 100,
                            child:  Row(
                              children: [
                                Container(
                                  width: Dimensions.height20 *5,
                                  height: Dimensions.height20 *5,
                                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOADS_URL+controller.getItems[index].img!
                                          )
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white
                                  ),
                                ),
                                Expanded(child: Container(
                                  margin: EdgeInsets.only(left: Dimensions.width10),
                                  height: Dimensions.height20*5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: controller.getItems[index].name!),
                                      SizedBox(height: Dimensions.height15,),
                                      SmallText(text: "Text"),
                                      SizedBox(height: Dimensions.height15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: "\$ ${controller.getItems[index].price!}}", color: Colors.red,),
                                          Container(
                                            padding: EdgeInsets.only(top: Dimensions.height10/32, bottom: Dimensions.height10/32, left: Dimensions.width10/8, right: Dimensions.width10/8),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: (){
                                                      //popularProduct.setQuantity(false);
                                                    },
                                                    child: Icon(Icons.remove, color: AppColors.signcolor)),
                                                SizedBox(width: Dimensions.width10/2,),
                                                BigText(text: "0"),
                                                SizedBox(width: Dimensions.width10/2,),
                                                GestureDetector(
                                                    onTap: (){
                                                      //popularProduct.setQuantity(true);

                                                    },
                                                    child: Icon(Icons.add, color: AppColors.signcolor))
                                              ],
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        });
                  })
                ),
            ))
        ],
      ),
    );
  }
}
