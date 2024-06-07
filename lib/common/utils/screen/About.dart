// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_color.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
             
           
              const Text(
                'About Music App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
  'Welcome to G-Music App, your go-to for music enjoyment. Our user-friendly interface and features make managing and listening to your music effortless. Discover new songs or revisit old favorites, all at your fingertips. We\'re thrilled to enhance your music listening experience.',
  style: TextStyle(color: Colors.white),
),
              const SizedBox(height: 16),
              const Text(
                'Owner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Music App is developed and maintained by Jeevan Kumar Kushwaha. I\'m  dedicated to providing the best music listening experience to our users.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
 
 Text(
     'Contact information:',
     style: TextStyle(
       fontSize: 20,
       fontWeight: FontWeight.bold,
       color: Colors.white,
     ),
   ),
   SizedBox(height: 20,),
  const Text(
   'Jeevan Kumar Kushwaha',
   style: TextStyle(
     fontSize: 18,
     fontWeight: FontWeight.bold,
     color: Color(0xFFF59F87),
   ),
 ),
 ListTile(
   leading: Icon(Icons.email, size: 32, color: Colors.blue),
   title: InkWell(
     onTap: () {
       launch('mailto:zionekushwaha@gmail.com');
     },
     child: Text(
       'zionekushwaha@gmail.com',
       style: TextStyle(
         fontSize: 14,
         color: Colors.white),
     ),
   ),
 ),
 ListTile(
   leading: const Icon(Icons.phone, size: 32, color: Colors.green),
   title: InkWell(
     onTap: () {
       launch('tel:+9779807151008');
     },
     child: const Text(
       '+977 980-7151008',
       style: TextStyle(color: Colors.white),
     ),
   ),
 ),
 ListTile(
   leading: const Icon(FontAwesomeIcons.linkedin, size: 32, color: Colors.indigo),
   title: InkWell(
     onTap: () {
       launch('https://www.linkedin.com/in/zi-one?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
     },
     child: const Text(
       'Linkin profile link',
       style: TextStyle(color: Colors.white),
     ),
   ),
 ),

  SizedBox(height: 20,),
               Center(
                 child: Text(
                           '@2024 Copyright',
                           style: TextStyle(
                             color: AppColors.primarySecondaryElementText,
                             fontSize: 14,
                           ),
                           textAlign: TextAlign.center,
                         ),
               ),
        
        SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}