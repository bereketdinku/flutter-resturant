import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/controllers/product_controller.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';
import '../chat/chat_screen.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetail({super.key, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        // controller.resetValues();
        return false;
      },
      child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.resetValues();
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
            title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishlist(data.id, context);
                        controller.isFav(false);
                      } else {
                        controller.addToWishlist(data.id, context);
                        controller.isFav(false);
                      }
                    },
                    icon: Icon(
                      Icons.favorite_outline,
                      color: controller.isFav.value ? redColor : darkFontGrey,
                    )),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          height: 300,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: ((context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          })),
                      title!.text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: 4,
                        // double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        maxRating: 5,
                        count: 5,
                        // stepInt: true,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Seller".text.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make()
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.messenger_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(() => ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),
                      10.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                      "Color".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      // 3,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          )),
                                )
                              ],
                            ).box.white.shadowSm.make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                data['p_price']);
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                            // data['p_price']);
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.heightBox,
                                      "(${data['p_quantity']})"
                                          .text
                                          .color(textfieldGrey)
                                          .make()
                                    ],
                                  ),
                                ),
                              ],
                            ).box.white.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: "Total"
                                        .text
                                        .color(textfieldGrey)
                                        .make()),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(Colors.blueGrey)
                                    .size(18)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            ).box.white.padding(const EdgeInsets.all(8)).make()
                          ],
                        ).box.white.shadowSm.make(),
                      ),
                      10.heightBox,
                      "${data['p_desc']}"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "This is a dummy item and dummy description"
                          .text
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            listviewbuttons.length,
                            (index) => ListTile(
                                  title: listviewbuttons[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      10.heightBox,
                      productyoumayalso.text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(18)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    children: [
                                      Image.asset(
                                        imgP1,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      10.heightBox,
                                      "Laptop 4GB/64GB"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "35000"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .rounded
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: btnWidget(
                    color: redColor,
                    onPress: () {
                      if (controller.quantity > 0) {
                        controller.addToCart(
                            title: data['p_name'],
                            img: data['p_imgs'][0],
                            sellername: data['p_seller'],
                            vendorID: data['vendor_id'],
                            color: data['p_colors']
                                [controller.colorIndex.value],
                            qty: controller.quantity.value,
                            tprice: controller.totalPrice.value,
                            context: context);
                        VxToast.show(context, msg: "Added to cart");
                      } else {
                        VxToast.show(context, msg: "Quantity can't be 0");
                      }
                    },
                    textColor: whiteColor,
                    title: "Add to Cart"),
              )
            ],
          )),
    );
  }
}
