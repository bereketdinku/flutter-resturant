import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/controllers/cart_controller.dart';
import 'package:my_try/screens/cart/shipping_screen.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: btnWidget(
              color: redColor,
              onPress: () {
                Get.to(() => const ShippingDetails());
              },
              textColor: whiteColor,
              title: "Proceed to shipping"),
        ),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: "Shopping Cart".text.color(darkFontGrey).make(),
            )),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productsnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                      "${data[index]['img']}",
                                      width: 120,
                                      fit: BoxFit.cover),
                                  title:
                                      "${data[index]['title']} (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(redColor)
                                      .make(),
                                  trailing:
                                      const Icon(Icons.delete, color: redColor)
                                          .onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  }),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          "Total price".text.fontFamily(semibold).make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          )
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGrey)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //   width: context.screenWidth - 60,
                      //   child: btnWidget(
                      //       color: redColor,
                      //       onPress: () {},
                      //       textColor: whiteColor,
                      //       title: "Proceed to shipping"),
                      // )
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(lightGrey)
                      .roundedSM
                      .make(),
                );
              }
            }));
  }
}
