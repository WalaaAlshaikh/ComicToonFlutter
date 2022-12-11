
import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controllers.dart';
import '../../../routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_form_field.dart';
import '../../widgets/auth/container_under.dart';



class RegisterScreen extends StatelessWidget {
  final formKey=GlobalKey<FormState>();
  final TextEditingController nameController =TextEditingController();
  final TextEditingController emailController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  final controller= Get.find<AuthController>();
   RegisterScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: AppBar(
            backgroundColor:Get.isDarkMode? Colors.grey.shade700: Colors.white ,
            elevation: 0,
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width:double.infinity,
                  height: MediaQuery.of(context).size.height / 1.27,
                  child:Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Form(
                    key:formKey ,
                    child: Column(
                      children: [
                        Row(
                          children:  [
                            TextUtils(
                                text: "SIGN",
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Get.isDarkMode ?mainColor : mainColor),
                            SizedBox(width: 5,),
                            TextUtils(
                                text: "UP",
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                                color: Get.isDarkMode ?Colors.white: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 50,),
                        AuthTextFromField(
                          controller: nameController,
                          maxLines: 1,
                          obscureText: false,
                          validator: (value){

                            if(value.toString().length<=2 || !RegExp(validationName).hasMatch(value)){
                              return "Enter valid Username";
                            } else{
                              return null;
                            }


                          },
                          prefixIcon: Image.asset("assets/images/user.png",color: mainColor,),
                          suffixIcon: const Text(""),
                          hintText: 'Username',

                        ),
                        const SizedBox(height: 20,),
                        AuthTextFromField(
                          maxLines: 1,
                          controller: emailController,
                          obscureText: false,
                          validator: (value){
                            if( !RegExp(validationEmail).hasMatch(value)){
                              return "Invalid Email";
                            } else{
                              return null;
                            }
                          },
                          prefixIcon: Image.asset("assets/images/email.png",color: mainColor,),
                          suffixIcon: const Text(""),
                          hintText: 'Email',

                        ),
                        const SizedBox(height: 20,),
                        GetBuilder<AuthController>(
                            builder:(_) {
                              return AuthTextFromField(
                                maxLines: 1,
                                controller: passwordController,
                                obscureText: controller.isVisible ?false : true,
                                validator: (value){
                                  if(value.toString().length <6){
                                    return 'Password should be longer than 6 characters';
                                  }else{
                                    return null ;
                                  }
                                },
                                prefixIcon: Image.asset("assets/images/lock.png",color: mainColor,),
                                suffixIcon: IconButton(onPressed: (){
                                  controller.visible();


                                },icon: controller.isVisible? const Icon(Icons.visibility_off , color: Colors.black54,)
                                  : const Icon(Icons.visibility, color: Colors.black54,),),
                                hintText: 'Password',

                              );
                            } ),
                       SizedBox(height: 10.h,),

                       GetBuilder<AuthController>(builder: (_){
                         return  AuthButton(
                           text: "REGISTER",
                           onPressed: () {
                             if(formKey.currentState!.validate()){

                               String name=nameController.text.trim();
                               String email=emailController.text.trim();
                               String password=passwordController.text;
                               controller.registerFirebase(
                                   name: name,
                                   email: email,
                                   password: password);


                             }

                         }
                         ,);
                       }),
                        Align(
                          alignment: Alignment.centerRight,
                          child:
                          Container_Under(
                            text: "Already have an account?",
                            onPressed: () {
                              Get.offNamed(Routes.loginScreen);
                            },
                            typetext: 'Login',
                          ),
                        ),

                      ],
                    ),
                  ),),),

              ],
            ),
          ),


        ),);
  }
}
