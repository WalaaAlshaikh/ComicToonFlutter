import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../routes.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {




  bool isVisibilty = false;
  bool isCheckBox = false;

  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  var displayDescription = ''.obs;


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  var isSignedIn = false;
  final GetStorage authBox = GetStorage();

  User? get userProfile => auth.currentUser;



  @override
  void onInit() {
    displayUserPhoto.value =
        (userProfile != null ? userProfile!.photoURL : "") ?? "";

    displayUserEmail.value =

        (userProfile != null ? userProfile!.email : "") ?? "";


    super.onInit();
  }




  void Visibilty() {
    isVisibilty = !isVisibilty;
    update();
  }





  loginUsingFierbase({
    required String email,
    required String password,
  }) async {
    try {
      print("in auth $email");
      print("in auth controller var $displayUserEmail");
      print("in auth controller var $displayUserName");
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(displayUserEmail.value)
            .get();
        Map<String, dynamic> docData = userDoc.data() as Map<String, dynamic>;
        displayUserName.value = docData['displayName'];
        displayUserEmail.value = docData['email'];
        displayDescription.value = docData['description'];
        displayUserPhoto.value = docData['image'];
      });

      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return CircularProgressIndicator();
      //   },
      // );

      isSignedIn = true;
      authBox.write("auth", isSignedIn);
      update();
      Get.offNamed(Routes.mainScreen);
      //getEmailDoc();

    } on FirebaseAuthException catch (error) {
      String title = error.code
          .replaceAll(RegExp('-'), ' ')
          .capitalize!;
      String message = '';
      if (error.code == 'Wrong E-mail') {
        message = 'Wrong E-mail';
      } else if (error.code == 'wrong-password') {
        message = 'Wrong password ';
      } else {
        message = error.message.toString();
      }
      Get.snackbar(title, message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code
          .replaceAll(RegExp('-'), ' ')
          .capitalize!;
      String message = '';
      if (e.code == 'user-not-found') {
        message = "No user found for that $email";
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }



  void signOut() async {
    try {
      await auth.signOut();
      displayUserName.value = "";
      displayUserPhoto.value = '';
      displayUserEmail.value = '';
      displayDescription.value = '';
      isSignedIn = false;
      authBox.remove("auth");

      update();
      Get.offNamed(Routes.loginScreen);
    } catch (e) {
      Get.snackbar("Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }

  void signUpUsingFirebase({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayUserName.value = name;
        auth.currentUser!.updateDisplayName(name);
        print(" this is username ${displayUserName.value}");
        print(" this is userprofile ${userProfile!.displayName}");
        displayUserEmail.value = email;
      });

      DocumentReference doc =
      FirebaseFirestore.instance.collection("users").doc(email);

      doc.set({
        "email": email,
        "password": password,
        "displayName": name,
        "image": "",
        "description": "",
      });

      update();
      Get.offNamed(Routes.mainScreen);
      // getEmailDoc();
    } on FirebaseAuthException catch (e) {
      String title = e.code
          .replaceAll(RegExp('-'), ' ')
          .capitalize!;
      String message = '';

      if (e.code == 'email-already-in-use') {
        message = 'Email already used';
      } else {
        message = e.message.toString();
      }

      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }



  Future updateFields(TextEditingController value,
      TextEditingController value1, String imageUrl) async {
    try {
      // value is the email user inputs in a textfield and is validated
      DocumentReference doc = FirebaseFirestore.instance
          .collection("users")
          .doc(displayUserEmail.value);
      if (value.text.isNotEmpty) {
        await doc.update({"displayName": value.text});
        displayUserName.value = value.text;
      }
      if (value1.text.isNotEmpty) {
        await doc.update({"description": value1.text});
        displayDescription.value = value1.text;
      }
      if (imageUrl.isNotEmpty) {
        await doc.update({"image": imageUrl});
        displayUserPhoto.value = imageUrl;
      }
      print(displayUserEmail.value);


      Get.snackbar(
        'Success!',
        "Updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
      );
    } catch (error) {
      Get.snackbar(
        'Error!',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
      );
    }
  }



}