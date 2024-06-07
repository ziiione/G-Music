import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_application/common/utils/screen/settings_pages/Private_policy.dart';
import 'package:g_application/common/utils/screen/settings_pages/terms_and_condition.dart';
import 'package:g_application/common/widget/text_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const routeName = '/SettingsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:    AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    title: const Text('Settings', style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.black,
    automaticallyImplyLeading: true,
       ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            
            ListTile(
              title: const Text('Choose Sound technology', style: TextStyle(color: Colors.white)),
             trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap:() async {
                        try {
                          await EqualizerFlutter.open(0);
                        } on PlatformException catch (e) {
                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('${e.message}\n${e.details}'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
            ),

            ListTile(
              title: const Text('Rate', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Do you like the app? Please rate us', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to Data Usage settings
              },
            ),
             ListTile(
              title: const Text('Share G Music', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Want to Share the app to friends', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to Data Usage settings
              },
            ),
             ListTile(
              title: const Text('Feedbacks', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Report Bug and tell what to improve', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to Data Usage settings
              },
            ),
             ListTile(
              title: const Text('Terms and Condition', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Our Terms and Conditions', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context, TermsAndConditionsPage.routeName);
              },
            ),
             ListTile(
              title: const Text('Private Policy', style: TextStyle(color: Colors.white)),
              subtitle: const Text('Our Private Policy', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                Navigator.pushNamed(context,PrivacyPolicyPage.routeName);
              },
            ),
             ListTile(
              title: const Text('Version', style: TextStyle(color: Colors.white)),
              subtitle: const Text('0.0.0.1', style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to Data Usage settings
              },
            ),
              ListTile(
              title: const Text('Help', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              onTap: () {
                // Navigate to Data Usage settings
              },
            ),

            Terms_and_condition()
          ],
        ).toList(),
      ),
      backgroundColor: Colors.black,
    );
  }
}