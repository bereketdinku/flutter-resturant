import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/controllers/cart_controller.dart';
import 'package:my_try/screens/cart/payment_method.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:my_try/widget/custom_textfeild.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: btnWidget(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            color: redColor,
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Column(
        children: [
          customTextField(
              hint: "Address",
              title: "Address",
              controller: controller.addressController),
          customTextField(
              hint: "City",
              title: "City",
              controller: controller.cityController),
          customTextField(
              hint: "State",
              title: "State",
              controller: controller.stateController),
          customTextField(
              hint: "Postal code",
              title: "Postal Code",
              controller: controller.postalcodeController),
          customTextField(
              hint: "Phone",
              title: "Phone",
              controller: controller.phoneController),
        ],
      ),
    );
  }
}
