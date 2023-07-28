import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/screens/orders/component/order_status.dart';
import 'package:my_try/screens/orders/order_place.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Order",
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirmed",
                showDone: data['order_confirmed']),
            orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: "On Delivery",
                showDone: data['order_on_delivery']),
            orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Delivered",
                showDone: data['order_delivered']),
            Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlaceDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method"),
                orderPlaceDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method"),
                orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postal']}".text.make()
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data['total_amount']}"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            Divider(),
            10.heightBox,
            "Orderd Product"
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView(
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  children: [
                    orderPlaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']}X",
                        d2: "Refundable"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          width: 30,
                          height: 10,
                          color: Color(data['orders'][index]['color'])),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            )
                .box
                .shadowMd
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
            10.heightBox,
            Row(
              children: [
                "SUB TOTAL:"
                    .text
                    .size(16)
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .make()
              ],
            )
          ],
        ),
      ),
    );
  }
}
