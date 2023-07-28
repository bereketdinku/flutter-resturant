import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/controllers/chat_controller.dart';
import 'package:my_try/services/firestore.dart';
import 'package:my_try/widget/loading_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/consts.dart';
import 'component/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "${controller.friendName}"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make()),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              // Obx(
              //   () => controller.isLoading.value
              //       ? Center(
              //           child: loadingIndicator(),
              //         )
              //       : Expanded(
              //           child: StreamBuilder(
              //               stream: FirestoreServices.getChatMessages(
              //                   controller.chatDocId),
              //               builder: (BuildContext context,
              //                   AsyncSnapshot<QuerySnapshot> snapshot) {
              //                 if (!snapshot.hasData) {
              //                   return Center(
              //                     child: loadingIndicator(),
              //                   );
              //                 } else if (snapshot.data!.docs.isEmpty) {
              //                   return Center(
              //                     child: "Send a message"
              //                         .text
              //                         .color(darkFontGrey)
              //                         .make(),
              //                   );
              //                 } else {
              //                   return ListView(
              //                     children: snapshot.data!.docs
              //                         .mapIndexed((currentValue, index) {
              //                       var data = snapshot.data!.docs[index];
              //                       return Align(
              //                           alignment:
              //                               data['uid'] == currentUser!.uid
              //                                   ? Alignment.centerRight
              //                                   : Alignment.centerLeft,
              //                           child: senderBubble(data));
              //                     }).toList(),
              //                   );
              //                 }
              //               })),
              // ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: textfieldGrey,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: textfieldGrey,
                        )),
                        hintText: "Type a message",
                      )),
                ),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(Icons.send, color: redColor))
              ])
                  .box
                  .height(60)
                  .padding(const EdgeInsets.all(12))
                  .margin(const EdgeInsets.only(bottom: 8))
                  .make()
            ])));
  }
}
