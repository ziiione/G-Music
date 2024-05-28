import 'package:flutter/material.dart';
import 'package:g_application/pages/getting_permission/permission_request.dart';
  void permission_denied(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          
          title: Text('We Strickly need your permission',
              style: TextStyle(fontSize: 20, color: Colors.black)),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
              await  requestPermission();              
              },
              child: Text('Again Request Permission'),
            ),
          ],
        );
      },
    );
  }