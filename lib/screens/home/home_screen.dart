import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/consts/lists.dart';
import 'package:my_try/controllers/home_controller.dart';
import 'package:my_try/screens/categories/items.dart';
import 'package:my_try/screens/home/component/feature_btn.dart';
import 'package:my_try/screens/home/search_screen.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/home_buttons.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<HomeController>();
    var controller = Get.put(HomeController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              // controller: controller.searchController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search).onTap(() {
                    // if (controller.searchController.text.isNotEmptyAndNotNull) {
                    //   Get.to(() => SearchScreen(title: "one"));
                    // }
                    // ;
                  }),
                  fillColor: whiteColor,
                  filled: true,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          10.heightBox,
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    itemCount: sliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        sliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .margin(EdgeInsets.symmetric(horizontal: 8))
                          .clip(Clip.antiAlias)
                          .make();
                    }),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      2,
                      (index) => homeButttons(
                          height: context.screenHeight * 0.1,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todaydeal : flashsale,
                          onPress: () {})),
                ),
                10.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    itemCount: secondSliderList.length,
                    itemBuilder: ((context, index) {
                      return Image.asset(secondSliderList[index],
                              fit: BoxFit.fill)
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    })),
                10.heightBox,
                Row(
                  children: List.generate(
                      3,
                      (index) => homeButttons(
                          height: context.screenHeight * 0.1,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topcategories
                              : index == 1
                                  ? topBrand
                                  : topSellers,
                          onPress: () {})),
                ),
                10.heightBox,
                Align(
                    alignment: Alignment.centerRight,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .make()),
                10.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featureButton(
                                      title: featuredTitles1[index],
                                      icon: featuredImage1[index]),
                                  10.heightBox,
                                  featureButton(
                                      icon: featuredImage2[index],
                                      title: featuredTitles2[index]),
                                  10.heightBox
                                ],
                              ))),
                ),
                10.heightBox,
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.blueGrey),
                  child: Column(children: [
                    featuredProduct.text.white.fontFamily(bold).size(18).make(),
                    10.heightBox,
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                            future: FirestoreServices.getFeaturedProducts(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: loadingIndicator());
                              } else if (snapshot.data!.docs.isEmpty) {
                                return "No featured products"
                                    .text
                                    .white
                                    .makeCentered();
                              } else {
                                var featureData = snapshot.data!.docs;
                                return Row(
                                  children: List.generate(
                                      featureData.length,
                                      (index) => Column(
                                            children: [
                                              Image.network(
                                                featureData[index]['p_imgs'][0],
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              10.heightBox,
                                              "${featureData[index]['p_name']}"
                                                  .text
                                                  .fontFamily(semibold)
                                                  .color(darkFontGrey)
                                                  .make(),
                                              10.heightBox,
                                              "${featureData[index]['p_price']}"
                                                  .numCurrency
                                                  .text
                                                  .fontFamily(semibold)
                                                  .color(darkFontGrey)
                                                  .make(),
                                              10.heightBox
                                            ],
                                          )
                                              .box
                                              .white
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .padding(const EdgeInsets.all(8))
                                              .rounded
                                              .make()
                                              .onTap(() {
                                            Get.to(() => ItemDetail(
                                                title:
                                                    "${featureData[index]['p_name']}",
                                                data: featureData[index]));
                                          })),
                                );
                              }
                            }))
                  ]),
                ),
                //third swiper
                10.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    height: 150,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    itemCount: secondSliderList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSliderList[index],
                        fit: BoxFit.fill,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    }),
                10.heightBox,
                //all products
                StreamBuilder(
                    stream: FirestoreServices.getAllProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else {
                        var allproductsData = snapshot.data!.docs;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Image.network(
                                    allproductsData[index]['p_imgs'][0],
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  10.heightBox,
                                  "${allproductsData[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsData[index]['p_price']}"
                                      .text
                                      .color(darkFontGrey)
                                      .fontFamily(semibold)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(12))
                                  .roundedSM
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetail(
                                      title:
                                          "${allproductsData[index]['p_name']}",
                                      data: allproductsData[index],
                                    ));
                              });
                            });
                      }
                    })
              ],
            ),
          ))
        ],
      )),
    );
  }
}
