import 'package:flutter/material.dart';

import '../utils/app_color.dart';


BoxDecoration appBoxshadow({Color color=AppColors.primaryElement, double radius=15,double sr=5,double br=10,}){
  return  BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 10,
        offset: const Offset(0, 5), // changes position of shadow
      ),
      
    ]
  );
}