import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  late final String text;
  double? fontsize;
   Color? color;
  late final bool isBold;

  Alignment? alignment;

  CustomText({
    this.color,
    required this.text,
     this.fontsize,
    this.isBold=false,
    this.alignment,

  }
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        "$text",style:(TextStyle(
        fontSize: fontsize,fontWeight: isBold?FontWeight.bold:FontWeight.normal









        ,
      ))
      ),

    );
  }
}
