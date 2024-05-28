import 'package:flutter/material.dart';

Widget appImage({

  double height = 16,
  double width = 16, required String imagePath,

}){
  return Image.asset(imagePath,
  height: height,
  width: width,
  filterQuality: FilterQuality.high,);
}