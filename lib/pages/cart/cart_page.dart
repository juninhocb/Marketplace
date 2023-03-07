import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/no_data_page.dart';
import 'package:food_app/controllers/cart_controller.dart';
import 'package:food_app/controllers/popular_product_controller.dart';
import 'package:food_app/controllers/recommended_popular_controller.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

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
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24)),
                AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor, iconSize: Dimensions.iconSize24)
              ],
          )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length > 0 ? Positioned(
                top: Dimensions.height20*6,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (controller){
                        var _cartList = controller.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index){
                              return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20*5,
                                child:  Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        var popularIndex = Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(_cartList[index].product!);
                                        if (popularIndex >= 0){
                                          Get.toNamed(RouteHelper.getPopularProduct(popularIndex));

                                        } else {
                                          var recommendedIndex = Get.find<RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(_cartList[index].product!);
                                          if(recommendedIndex < 0 ){
                                            Get.snackbar(
                                                "Histórico de produtos", "Produto de revisão não está disponível para exibir",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white
                                            );
                                          }else {
                                            Get.toNamed(RouteHelper.getRecommendedProduct(recommendedIndex));
                                          }

                                        }

                                      },
                                      child: Container(
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
                                          SmallText(text: "Produto: " + controller.getItems[index].name!),
                                          SizedBox(height: Dimensions.height15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: "\$ ${controller.getItems[index].price!}", color: Colors.red,),
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
                                                          controller.addItem(_cartList[index].product!, -1);
                                                        },
                                                        child: Icon(Icons.remove, color: AppColors.signcolor)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartList[index].quantity.toString()!),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          controller.addItem(_cartList[index].product!, 1);

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
                )) : NoDataPage(text: "Não tem items no carrinho", imgPath: "img");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30, left: Dimensions.width20, bottom: Dimensions.height30, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2)
              )
          ),
          child: GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length > 0? Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: BigText(text: " Valor total: R\$ ${controller.totalAmount.toString()}"),
                ),
                GestureDetector(
                  onTap: (){
                    //print(controller.getItems.length);
                    controller.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    child: BigText(text: "Confirmar ", color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ) : Container();
          })
        );
      }),
    );
  }
}
