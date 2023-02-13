import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';


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
                AppIcon(icon: Icons.shopping_cart)
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
      bottomNavigationBar: Column(
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
                AppIcon(iconColor: Colors.white ,iconSize: Dimensions.iconSize24, backgroundColor: AppColors.mainColor, icon: Icons.remove),
                BigText(text: "\$ ${product.price!} X 0", color: AppColors.mainBlackColor, size: Dimensions.font26,),
                AppIcon(iconColor: Colors.white, iconSize: Dimensions.iconSize24, backgroundColor: AppColors.mainColor, icon: Icons.add)
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
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "\$10 | Adicionar ao carrinho", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
