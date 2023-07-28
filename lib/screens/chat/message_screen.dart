import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

import 'chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "All Message".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: loadingIndicator(),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return "No Message"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make();
        } else {
          var data = snapshot.data!.docs;
          return Column(
            children: [
              Expanded(child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                      onTap: () {
                        Get.to(() => ChatScreen(), arguments: [
                          data[index]['friend_name'],
                          data[index]['toId']
                        ]);
                      },
                      leading: const CircleAvatar(
                        backgroundColor: redColor,
                        child: Icon(Icons.person, color: whiteColor),
                      ),
                      title: "${data[index]['friend_name']}"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      subtitle: "${data[index]['last_msg']}".text.make()),
                );
              }))
            ],
          );
        }
      }),
    );
  }
}
