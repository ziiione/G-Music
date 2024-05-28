import 'package:flutter/material.dart';
import 'package:g_application/pages/getting_permission/permission.dart';
import 'package:g_application/pages/welcome/operation.dart';
import 'package:g_application/pages/welcome/page_provider/page_provider.dart';
import 'package:provider/provider.dart';
import '../../common/utils/app_color.dart';
import '../../common/widget/app_shadow.dart';
import '../../common/widget/text_widget.dart';

Widget appOnBoardingPage({
  String imagePath = 'assets/images/reading.png',
  String title = '',
  String subtitle = '',
  String bthtext = 'Next',
  required BuildContext context,
  required PageController controller,
}) {

  return Column(
    children: [
      Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
      Container(
          margin: const EdgeInsets.only(top: 15),
          child: text24Normal(text: title)),
      Container(
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: text16Normal(text: subtitle)),
      _nextButton(controller: controller, text: bthtext, context: context)
    ],
  );
} 

Widget _nextButton(
    {required PageController controller,
    required String text,
    required BuildContext context}) {
  int index = Provider.of<PageProvider>(context).index;
  return GestureDetector(
    onTap: () {
      if (index < 2) {
        print(index);
        index++;
        controller.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        print('done');
         saveWelcomePageStatus();
         print('saved the status of welcome page');
         print('done');

Navigator.pushNamed(context, permission_page.routeName);
      }
    },
    child: Container(
      width: 300,
      height: 70,
      decoration: appBoxshadow(),
      margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
      child: Center(
          child: text16Normal(text: text, color: AppColors.primaryElementText)),
    ),
  );
}
