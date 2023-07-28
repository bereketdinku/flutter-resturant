import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:my_try/consts/consts.dart";

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = "";

  var searchController = TextEditingController();
  getUsername() async {
    var n = await firestore
        .collection(userColection)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          return value.docs.single["name"];
        }
      },
    );
    username = n;
  }
}
