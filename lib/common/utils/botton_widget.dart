import 'package:flutter/material.dart';
import 'app_color.dart';

Widget appBotton({required String text, required Function() onPressed,Color color=AppColors.primaryElement,Color textColor=Colors.white,}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: AppColors.primaryFourElementText),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      
    ),
  );
}