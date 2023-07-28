import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/lists.dart';
import 'package:my_try/screens/auth/signup.dart';
import 'package:my_try/screens/home/home.dart';
import 'package:my_try/widget/applogo.dart';
import 'package:my_try/widget/bg_widget.dart';
import 'package:my_try/widget/btn_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import '../../widget/custom_textfeild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    // var emailContoller = TextEditingController();
    // var emailContoller = onChanged();
    // var passwordController = TextEditingController();
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Log in to Ecom".text.fontFamily(bold).make(),
                  10.heightBox,
                  Column(
                    children: [
                      customTextField(
                              hint: emailHint,
                              title: email,
                              controller: controller.emailController)
                          .box
                          .margin(const EdgeInsets.all(5))
                          .make(),
                      customTextField(
                              hint: passwordHint,
                              title: pasword,
                              controller: controller.passController)
                          .box
                          .margin(const EdgeInsets.all(5))
                          .make(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      5.heightBox,
                      btnWidget(
                          color: Colors.blueGrey,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            await controller
                                .loginmethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              }
                            });
                            // Get.offAll(() => const Home());
                          }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text
                          .color(whiteColor)
                          .fontFamily(semibold)
                          .make(),
                      5.heightBox,
                      btnWidget(
                          color: lightGolden,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () {
                            Get.to(() => SignUpScreen());
                          }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      loginwith.text.color(whiteColor).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(socialIconList[index],
                                      width: 30),
                                )),
                      )
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .make()
                ],
              ),
            )));
  }
}
