import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes.dart';

class AuthController extends GetxController{
  bool isVisible= false;
  bool isCheckbox=false;
  var displayName="".obs;
  var displayUserPic="".obs;
  var displayUserEmail="".obs;
  var googleSignin=GoogleSignIn();

  FirebaseAuth auth = FirebaseAuth.instance;
  var isSignedIn=false;

  final GetStorage authbox=GetStorage();
  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName.value =
    (userProfile != null ? userProfile!.displayName : "")!;
    // displayUserPic.value =
    // (userProfile != null ? userProfile!.photoURL : "assets/images/email.png")!;
    displayUserEmail.value = (userProfile != null ? userProfile!.email : "")!;

    super.onInit();
  }


  void visible(){
    isVisible= !isVisible;
    update();
  }

  void checkBox(){
    isCheckbox=!isCheckbox;
    update();
  }

  void registerFirebase(
      { required String name,
        required String email,
        required String password,
      }) async{

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value)  {
        displayName.value=name;
        auth.currentUser!.updateDisplayName(name);
        print(" this is username${displayName.value}");
        displayUserEmail.value=email;

      }
      );
      update();
      Get.offNamed(Routes.mainScreen);
    } on FirebaseAuthException catch (e) {

      String title= e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message='';
      if (e.code == 'weak-password') {
        message="The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email.';
      }else{
        message=e.message.toString();
      }

      Get.snackbar(
          title,
          message,
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
          "Error!",
          e.toString(),
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }
  void loginFirebase({

    required String email,
    required String password,
  }) async{
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) =>
      displayName.value=auth.currentUser!.displayName!);
      isSignedIn=true;
      authbox.write("auth", isSignedIn);
      update();
      Get.offNamed(Routes.mainScreen);

    } on FirebaseAuthException catch (e) {
      String title= e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message='';
      if (e.code == 'user-not-found') {
        message="No user found for that $email";
      } else if (e.code == 'wrong-password') {
        message='Wrong password provided for that user.';
      }else{
        message=e.message.toString();
      }

      Get.snackbar(
          title,
          message,
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
          "Error!",
          e.toString(),
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }

  }


  void resetPass(String email) async{

    try {
      await auth.sendPasswordResetEmail(email: email);
      update();
      Get.back();

    } on FirebaseAuthException catch (e) {
      String title= e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message='';
      if (e.code == 'user-not-found') {
        message="No user found for that $email";
      }
      else{
        message=e.message.toString();
      }

      Get.snackbar(
          title,
          message,
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar(
          "Error!",
          e.toString(),
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }
  }
  void signOut()async{
    try{

      await auth.signOut();
      await googleSignin.signOut();
      displayName.value="";
      displayUserPic.value='';
      isSignedIn=false;
      authbox.remove("auth");
      update();



      Get.offNamed(Routes.mainScreen);

    }catch(e){
      Get.snackbar(
          "Error!",
          e.toString(),
          snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.grey,
          colorText: Colors.white);
    }

  }





}