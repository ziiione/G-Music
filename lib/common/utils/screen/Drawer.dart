// import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:g_application/common/utils/screen/Equalizer.dart';
import 'package:g_application/common/utils/screen/Sleep.dart';
import 'package:g_application/common/widget/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';

import 'About.dart';
import 'SettingPage.dart';


class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Drawer(
      backgroundColor: Colors.black.withOpacity(0.9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            
       decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
            ),
            
       child: Image.asset('assets/images/logo.png',)
          ),
          ListTileItem(
            text: 'Home',
            icon: const Icon(Icons.home, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),


          ListTileItem(text: 'Equalizer', icon: const Icon(Icons.equalizer,color: Colors.white,),onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, EqualizerPage.routeName);
      },),
            ListTileItem(
            text: 'Sleep Timer',
            icon: const Icon(Icons.timer, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, SleepTimerScreen.routeName);
              
            },
          ),
          ListTileItem(
            text: 'Track Cutter',
            icon: const Icon(Icons.cut, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTileItem(
            text: 'Custom Theme',
            icon: const Icon(Icons.palette, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
                    ListTileItem(
            text: 'Premium Features',
            icon: const Icon(Icons.verified, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
              showSnackBar(context, 'Coming Soon!');
            },
          ),
          ListTileItem(
            text: 'Rate',
            icon: const Icon(Icons.star, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTileItem(
            text: 'About',
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AboutPage.routeName);
            },
          ),
          ListTileItem(
            text: 'Settings',
            icon: const Icon(Icons.settings, color: Colors.white),
            onTap: () {
              // openAppSettings();
              Navigator.pop(context);
              Navigator.pushNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );
  }
}

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key,
  });
final String text;
final Icon icon;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title:  Text(
        text,
        style:const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
