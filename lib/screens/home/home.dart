import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_try/consts/consts.dart';
import 'package:my_try/controllers/home_controller.dart';
import 'package:my_try/screens/cart/cart_screen.dart';
import 'package:my_try/screens/categories/category.dart';
import 'package:my_try/screens/home/home_screen.dart';
import 'package:my_try/screens/profile/profile_screen.dart';
import 'package:my_try/widget/exit_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];
    var navBody = [
      HomeScreen(),
      CategoriesScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)))
          ],
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: navbarItem,
              currentIndex: controller.currentNavIndex.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              selectedItemColor: Colors.blueGrey,
              selectedLabelStyle: TextStyle(fontFamily: semibold),
              onTap: (value) {
                controller.currentNavIndex.value = value;
              },
            )),
      ),
    );
  }
}
