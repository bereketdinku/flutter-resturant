import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/cart_controller.dart';
import '../../widget/btn_widget.dart';
import '../../widget/loading_indicator.dart';
import '../home/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: controller.placingOrder.value
            ? Center(child: loadingIndicator())
            : btnWidget(
                onPress: () async {
                  await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethods[controller.paymentIndex.value],
                      totalAmount: controller.totalP);
                  await controller.clearCart();
                  VxToast.show(context, msg: "Order placed successfully");
                  Get.offAll(const Home());
                },
                color: redColor,
                textColor: whiteColor,
                title: "Place my order"),
      ),
      appBar: AppBar(
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => Column(
            children: List.generate(paymentMethodsList.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 5)),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsList[index],
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make())
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
