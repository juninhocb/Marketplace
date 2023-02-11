import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/expandable_text_widget.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class RecommendedProductDetail extends StatelessWidget {
  const RecommendedProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
                child: Container(
                  child: Center(child: BigText(size: Dimensions.font26, text: "VeryPet")),
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
              background: Image.asset(
                  "assets/image/verypet.png",
                  width: double.maxFinite,
                  fit: BoxFit.cover
              ),

            ),

          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandableText(text: 
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam a augue quis erat tincidunt laoreet nec in ipsum. Vestibulum eu nunc sed lorem efficitur efficitur at sed metus. Vivamus pretium dapibus purus, vel volutpat ipsum aliquam non. Vivamus sit amet mollis libero. Nunc ac erat nibh. Aenean pulvinar nisi sit amet augue dapibus maximus. Maecenas egestas metus eu mauris mollis, et blandit justo mollis. Quisque feugiat pretium purus, vel condimentum nibh viverra et. Quisque at gravida felis, et pellentesque lacus. Duis urna lorem, hendrerit sagittis sapien non, commodo tempus tortor. Maecenas nec blandit ex, eu pellentesque diam. Mauris feugiat nisi magna, nec accumsan lectus posuere eu. In sit amet hendrerit lectus. Quisque volutpat, purus et feugiat elementum, tortor lectus pulvinar neque, at porttitor lectus mi et nulla.Vivamus blandit libero at dolor auctor pharetra at ut quam. Donec nisl lectus, vestibulum sit amet augue in, maximus commodo lacus. Fusce lacus neque, sollicitudin vel nibh ut, imperdiet ultricies sapien. Ut lobortis id leo sit amet sodales. Donec luctus suscipit tristique. Praesent urna tortor, interdum quis consequat fringilla, interdum vitae neque. Praesent cursus eget felis eget lacinia. Sed tincidunt leo quis lacinia semper. Nulla tincidunt ut justo at por Phasellus venenatis quam purus, nec cursus dolor sollicitudin et. Maecenas iaculis elit a arcu fringilla, a volutpat ligula cursus. Ut scelerisque est vel commodo elementum. Nam leo leo, vestibulum in nibh et, commodo tincidunt nulla. In hac habitasse platea dictumst. Sed dictum dolor vitae ligula euismod venenatis. Quisque feugiat mi in finibus ullamcorper. Cras fringilla lacus orci, eget dictum purus ultricies id. Integer semper mauris a ligula fringilla ornare. Aenean condimentum justo ut ligula sollicitudin, id viverra lectus tristique. Sed at efficitur ex. Praesent iaculis suscipit varius. Suspendisse sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor. se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor.se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor.se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor.se sed maximus mi. Ut aliquam mauris quis sollicitudin dignissim. Donec sagittis feugiat auctor."
                    ),
                  )
                ],
              )
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
                BigText(text: "\$12.88 " + "X" + " 0", color: AppColors.mainBlackColor, size: Dimensions.font26,),
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
