import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/text_utils.dart';
import '../../../utils/theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const AuthButton({required this.onPressed, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10),
        ) ,
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity, 5.6.h),
      ),
      child: TextUtils(
        color: Colors.white,
        text: text,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        underLine: TextDecoration.none,
      ),
    );
  }
}
