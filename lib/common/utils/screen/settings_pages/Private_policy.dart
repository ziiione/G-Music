import 'package:flutter/material.dart';
import 'package:g_application/common/widget/text_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});
  static const routeName = '/PrivacyPolicyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.white) ,),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: ListView(
          children: <Widget>[
           
            const Text(
              '1. Introduction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to G Music. We are committed to protecting your privacy. This policy outlines how we handle your personal data when you use our app.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Data Collection',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'G Music does not collect any personal data from users. The app operates in offline mode, and no internet connection is required to use its features.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Local Data Storage',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Any data related to your music library, playlists, and app settings are stored locally on your device. This data is not transmitted to any external servers.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '4. Security',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'We take the security of your local data seriously. Please ensure your device is secured to protect your data.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page. You are advised to review this Privacy Policy periodically for any changes.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              '6. Contact Us',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'If you have any questions about this Privacy Policy, please contact us at support@gmusic.com.',
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
