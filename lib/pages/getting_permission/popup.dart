import 'package:flutter/material.dart';
import 'package:g_application/common/utils/app_color.dart';
import 'package:permission_handler/permission_handler.dart';
  void permission_denied(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        
        return AlertDialog(
       
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          
          title: const Text('Permission Denied', style: TextStyle(fontSize: 24, color: AppColors.primaryText)),
             
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
              openAppSettings();
              Navigator.pop(context);             
              },
              child: const Text('Request'),
            ),
          ],
        );
      },
    );
  }