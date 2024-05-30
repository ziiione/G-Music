// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../utils/app_color.dart';

Widget text24Normal({
  String text = '',
  Color color = AppColors.primaryText,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.normal),
  );
}

Widget text16Normal({
  String text = '',
  Color color = AppColors.primarySecondaryElementText,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.normal),
  );
}

Widget text14Normal({
  String text = '',
  Color color = AppColors.primarySecondaryElementText,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.normal),
  );
}

Widget text11Bold({
  String text = '',
  Color color = AppColors.primarySecondaryElementText,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
  );
}


Widget text24Bold({
  String text = '',
  Color color = AppColors.primarySecondaryElementText,
}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold),
  );
}

BoxDecoration appBoxDecorationTextField(
    {Color color = AppColors.primaryBackground,
    double radius = 15,
    Color borderColor = AppColors.primaryFourElementText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor)); // BoxDecoration I
}

Widget Terms_and_condition() {
  return const Padding(
    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Column(
      children: [
        Text(
          'By granting the permissions, you agree to our Terms and Policy.',
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          '@2024 Copyright',
          style: TextStyle(
            color: AppColors.primarySecondaryElementText,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
