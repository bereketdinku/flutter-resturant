import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Wish List".text.color(darkFontGrey).make();
            } else {
              var data = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network("${data[index]['img'][0]}",
                            width: 120, fit: BoxFit.cover),
                        title: "${data[index]['p_name']} "
                            .text
                            .fontFamily(semibold)
                            .size(16)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .text
                            .fontFamily(semibold)
                            .color(redColor)
                            .make(),
                        trailing: const Icon(Icons.favorite, color: redColor)
                            .onTap(() async {
                          await firestore
                              .collection(productsCollection)
                              .doc(data[index].id)
                              .set({
                                'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                        }),
                      );
                    }),
              );
            }
          }),
    );
  }
}
