import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/colors.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/controllers/profile_controller.dart';
import 'package:my_try/widget/bg_widget.dart';
import 'package:my_try/widget/custom_textfeild.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../widget/btn_widget.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    controller.nameController.text = data['name'];
    controller.passController.text = data['password'];
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            btnWidget(
                color: Colors.blueGrey,
                onPress: () {
                  controller.changeImage(context);
                },
                title: 'change',
                textColor: whiteColor),
            Divider(),
            20.heightBox,
            customTextField(
                hint: nameHint,
                title: name,
                controller: controller.nameController),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: oldpass,
                controller: controller.passController),
            10.heightBox,
            customTextField(
                hint: passwordHint,
                title: pasword,
                controller: controller.passController),
            10.heightBox,
            controller.isLoading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : btnWidget(
                    color: Colors.blueGrey,
                    onPress: () async {
                      controller.isLoading(true);
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink = data['imgUrl'];
                      }
                      if (data['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.passController.text);
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.passController.text);
                        VxToast.show(context, msg: "updated");
                      } else {
                        VxToast.show(context, msg: 'Wrong old password');
                        controller.isLoading(false);
                      }
                    },
                    textColor: whiteColor,
                    title: 'Save')
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(10))
            .margin(EdgeInsets.only(top: 40, left: 10, right: 10))
            .make(),
      ),
    ));
  }
}
