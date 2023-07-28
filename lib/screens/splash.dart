import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/screens/auth/login.dart';
import 'package:my_try/widget/applogo.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(() => LoginScreen());
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            applogoWidget(),
            20.heightBox,
            "Ecom".text.fontFamily(bold).size(22).color(Colors.white).make()
          ]),
        ));
  }
}
