import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
// import 'package:firebase_auth/firebase_auth.dart';
import '../consts/firebase_const.dart';
import 'package:get/get.dart';
import "package:velocity_x/velocity_x.dart";
import "../consts/consts.dart";

class AuthController extends GetxController {
  var isLoading = false.obs;
  // var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  Future<UserCredential?> loginmethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data
  storeUserData({email, password, name}) async {
    DocumentReference store =
        firestore.collection(userColection).doc(currentUser!.uid);
    store.set(
        {'name': name, 'password': password, 'email': email, 'imgUrl': ''});
  }

  //signout
  signoutMethod({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
