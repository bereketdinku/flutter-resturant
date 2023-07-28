import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/controllers/auth_controller.dart';
import 'package:my_try/controllers/profile_controller.dart';
import 'package:my_try/screens/auth/login.dart';
import 'package:my_try/screens/chat/message_screen.dart';
import 'package:my_try/screens/orders/order_screen.dart';
import 'package:my_try/screens/profile/component/detail_card.dart';
import 'package:get/get.dart';
import 'package:my_try/screens/profile/component/edit_profile.dart';
import 'package:my_try/screens/wish_list/wishlist_screen.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/loading_indicator.dart';
import '../../widget/bg_widget.dart';
import "package:velocity_x/velocity_x.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    FirestoreServices.getCounts();
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser?.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(redColor),
          ));
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
              child: Column(
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: whiteColor,
                ),
              ).onTap(() {
                Get.to(() => EditProfile(data: data));
              }),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      data['imgUrl'] == ''
                          ? Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.fill,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imgUrl'],
                              width: 100,
                              fit: BoxFit.fill,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "${data['name']}"
                            //     .text
                            //     .fontFamily(semibold)
                            //     .white
                            //     .make(),
                            "${data['email']}".text.white.make()
                          ],
                        ),
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context: context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).white.make())
                    ],
                  )),
              10.heightBox,
              FutureBuilder(
                  future: FirestoreServices.getCounts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else {
                      var countData = snapshot.data;
                      return Row(
                        children: [
                          detailCard(
                              width: context.screenWidth / 4,
                              count: countData[0].toString(),
                              title: " card"),
                          detailCard(
                              width: context.screenWidth / 4,
                              count: countData[1].toString(),
                              title: " wishlist"),
                          detailCard(
                              width: context.screenWidth / 4,
                              count: countData[2].toString(),
                              title: " orders")
                        ],
                      );
                    }
                  }),
              20.heightBox,
              ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            // switch (index) {
                            //   case 0:
                            //     Get.to(() => const OrderScreen());
                            //     break;
                            //   case 1:
                            //     Get.to(() => const WishList());
                            //     break;
                            //   case 2:
                            //     Get.to(() => const MessageScreen());
                            //     break;
                            // }
                          },
                          leading: Image.asset(
                            profileButtonicon[index],
                            width: 25,
                          ),
                          title: profileButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonicon.length)
                  .box
                  .rounded
                  .margin(const EdgeInsets.all(4))
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .white
                  .shadowSm
                  .make()
                  .box
                  .color(Colors.blueGrey)
                  .make()
            ],
          ));
        }
      },
    )));
  }
}
