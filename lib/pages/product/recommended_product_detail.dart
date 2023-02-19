import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/cart/cart_page.dart';
import 'package:food_app/pages/home/main_food_page.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';





import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_popular_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class RecommendedProductDetail extends StatelessWidget {
  int pageId;
  RecommendedProductDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.initial);
                    } ,
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (controllerProduct){
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            /*
                            Fluttertoast.showToast(
                              msg: "Carrinho vazio",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );*/
                            Get.to(() => CartPage());

                          },
                          child: AppIcon(icon: Icons.shopping_cart_checkout_outlined)),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                      Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                              onTap: (){
                                Get.to(() => CartPage());
                              } ,
                              child: AppIcon(icon: Icons.circle, size: 16, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor))) :
                      Container(),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                      Positioned(
                          right: 5,
                          top: 2,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(), size: 12, color:  Colors.white)) :
                      Container()
                    ],
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
                child: Container(
                  child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                  ),
                ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOADS_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover
              ),

            ),

          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(text:
                      product.description!
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(iconColor: Colors.white ,iconSize: Dimensions.iconSize24, backgroundColor: AppColors.mainColor, icon: Icons.remove)),
                  BigText(text: "\$ ${product.price!} X ${controller.inCartItems}", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(iconColor: Colors.white, iconSize: Dimensions.iconSize24, backgroundColor: AppColors.mainColor, icon: Icons.add))
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimensions.height30, left: Dimensions.width20, bottom: Dimensions.height30, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20*2),
                      topRight: Radius.circular(Dimensions.radius20*2)
                  )
              ),
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white
                      ),
                      child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                        controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text: "\$ ${product.price!} | Adicionar ao carrinho", color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}
