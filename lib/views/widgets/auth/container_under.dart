
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/text_utils.dart';
import '../../../utils/theme.dart';

class Container_Under extends StatelessWidget {
  final String text;
  final String typetext;
  final Function() onPressed;
  const Container_Under(
      {required this.text,
      required this.typetext,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextUtils(
            text: text,
            color: labalColor,
            fontWeight: FontWeight.normal,
            fontSize: 10.sp,
            underLine: TextDecoration.none),
        TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(12.72.w, 3.52.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft),
            child: TextUtils(
                text: typetext,
                color: buttonColor,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
                underLine: TextDecoration.underline))
      ],
    );
  }
}
