// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:g_application/common/utils/app_color.dart';
import 'package:g_application/common/utils/botton_widget.dart';
import 'package:g_application/common/utils/height_width.dart';
import 'package:g_application/common/widget/text_widget.dart';
import 'package:g_application/pages/Main_screen/home_screen.dart';
import 'package:g_application/pages/getting_permission/permission_request.dart';
import 'popup.dart';

class permission_page extends StatelessWidget {
  const permission_page({super.key});
  static const String routeName = '/permission_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarySecondaryBackground,
        elevation: 10,
        automaticallyImplyLeading: false,
        title: text24Normal(
          text: 'Permission',
          color: AppColors.primaryText,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 200),
              SizedBox(height: getHeight(context) * 0.01),
              text24Bold(
                text: 'Storage Permission',
                color: AppColors.primary_Bg,
              ),
              SizedBox(height: getHeight(context) * 0.03),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: text16Normal(
                  text:
                      'We need to access your storage to save and retrieve data. Please grant us the permission.',
                  color: AppColors.primaryText,
                ),
              ),
              SizedBox(height: getHeight(context) * 0.03),
              appBotton(
                  text: 'Grant Permission',
                    onPressed: () async {
            // Request permission here
            bool permissionGranted = await requestPermission();
            if (permissionGranted) {
              // Update AppState
              savePermissionStatus();
              //load the audio songs in provider
        Navigator.pushNamed(context, Home_page.routeName);
            }else{
              permission_denied(context);
            }
          },),
              Terms_and_condition(),
            ],
          ),
        ),
      ),
    );
  }
}