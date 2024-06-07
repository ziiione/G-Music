import 'package:flutter/material.dart';
import 'package:g_application/common/widget/text_widget.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);
  static const routeName = '/TermsAndConditionsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Terms and Conditions', style: TextStyle(color: Colors.white) ,),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: ListView(
          children: <Widget>[
           
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'By using G Music, you agree to be bound by these terms and conditions. If you do not agree, please do not use our app.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '2. Use of Service',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'You agree to use G Music only for lawful purposes. You must not use our service to infringe on the rights of others or violate any applicable laws.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '3. Intellectual Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'All content provided on G Music, including but not limited to music, graphics, and text, is the property of G Music or its content suppliers. Unauthorized use of this content is prohibited.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '4. Offline Mode',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'G Music operates in offline mode. No internet connection is required to use the app, and no user accounts are necessary.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '5. Privacy Policy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'We respect your privacy and do not collect personal data through the G Music app. Any data stored on your device remains solely on your device.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '6. Limitation of Liability',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'To the fullest extent permitted by law, G Music shall not be liable for any indirect, incidental, or consequential damages arising out of your use of the service.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '7. Changes to Terms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'We reserve the right to update these terms at any time. We will notify you of any changes by posting the new terms on this page. Your continued use of G Music after any changes constitutes your acceptance of the new terms.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              '8. Contact Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions about these terms, please contact us at support@gmusic.com.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            
            Terms_and_condition()
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
