import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import '../categories/items.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  const SearchScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProduct(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products found".text.make();
          } else {
            var data = snapshot.data!.docs;
            var filterd = data
                .where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title.toString()))
                .toList();
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8),
              children: filterd
                  .mapIndexed((currentValue, index) => Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filterd[index]['p_imgs'][0],
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                              10.heightBox,
                              "${filterd[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filterd[index]['p_price']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make()
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .roundedSM
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetail(
                                  title: "${filterd[index]['p_name']}",
                                  data: filterd[index],
                                ));
                          })
                        ],
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
