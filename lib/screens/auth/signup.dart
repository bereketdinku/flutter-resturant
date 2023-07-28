import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/controllers/auth_controller.dart';
import 'package:my_try/screens/auth/login.dart';
import 'package:my_try/screens/home/home.dart';
import 'package:my_try/widget/bg_widget.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:my_try/widget/custom_textfeild.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    // var nameController = TextEditingController();
    // var emailcontroller = TextEditingController();
    // var passwordController = TextEditingController();
    // var retypeController = TextEditingController();
    bool? ischeck = false;
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          7.heightBox,
          "Log in to Ecom".text.fontFamily(bold).white.size(18).make(),
          20.heightBox,
          Column(
            children: [
              customTextField(
                  hint: nameHint, title: name, controller: nameController),
              customTextField(
                  hint: emailHint, title: email, controller: emailContoller),
              customTextField(
                      hint: passwordHint,
                      title: pasword,
                      controller: passwordController)
                  .box
                  .rounded
                  .make(),
              customTextField(
                  hint: passwordHint,
                  title: retypePass,
                  controller: retypePassController),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: forgetPass.text.make(),
                ),
              ),
              5.heightBox,
              Row(
                children: [
                  Checkbox(
                    
                      value: ischeck,
                      onChanged: (newValue) {
                        setState(() {
                          ischeck = newValue;
                        });
                      }),
                  10.heightBox,
                  Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                    TextSpan(
                        text: "I agree to the",
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: termandcondition,
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: " & ",
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: privacyPolicy,
                        style: TextStyle(fontFamily: bold, color: fontGrey))
                  ])))
                ],
              ),
              btnWidget(
                  color: ischeck == true ? Colors.blueGrey : lightGrey,
                  title: signup,
                  textColor: whiteColor,
                  onPress: () async {
                    if (ischeck == false) {
                      try {
                        await controller
                            .signupMethod(
                                context: context,
                                email: emailContoller.text,
                                password: passwordController.text)
                            .then((value) {
                          return controller.storeUserData(
                              email: emailContoller.text,
                              name: nameController.text,
                              password: passwordController.text);
                        }).then((value) {
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(() => Home());
                        });
                      } catch (e) {
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                      }
                    }
                  }).box.width(context.screenWidth - 50).make(),
              5.heightBox,
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: haveAccount,
                    style: TextStyle(fontFamily: bold, color: fontGrey)),
                TextSpan(
                    text: login,
                    style: TextStyle(fontFamily: bold, color: fontGrey))
              ])).onTap(() {
                Get.to(() => LoginScreen());
              })
            ],
          )
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .make()
        ],
      )),
    ));
  }
}
