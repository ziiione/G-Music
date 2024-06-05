import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:g_application/pages/welcome/page_provider/page_provider.dart';
import 'package:provider/provider.dart';
import 'widget.dart';

class Welcome extends StatefulWidget {
   const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
final PageController controller=PageController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/lady3.png'), context);
    precacheImage(const AssetImage('assets/images/track_cutting.png'), context);
    precacheImage(const AssetImage('assets/images/noAds.png'), context);
  }

  @override
void dispose() {
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context,) {
    
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Consumer<PageProvider>(
              builder: (context, provider, child) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    //code for showing the pageview
                                PageView(
                      onPageChanged: (value) {
                        provider.incrementCounter( value);
                      },
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        appOnBoardingPage(
                          controller: controller,
                          imagePath: 'assets/images/lady3.png',
                          title: 'Enjoy listening to music',
                          subtitle:
                              'Enjoy the music with us, listen to your favourite music in quality sound.',
                      
                          context: context,
                        ),
                        appOnBoardingPage(
                          controller: controller,
                          imagePath: 'assets/images/track_cutting.png',
                          title: 'Cut Music Tracks',
                          subtitle:
                              'Cut your music tracks and make them your ringtone.',
                          context: context,
                        ),
                        appOnBoardingPage(
                          controller: controller,
                          imagePath: 'assets/images/noAds.png',
                          title: 'Say No to Ads',
                          subtitle:
                              'Enjoy music without any adds, listen to music without any interruption.',
                          bthtext: 'Get Started',
                          context: context,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      child: DotsIndicator(
                        position: provider.index,
                        mainAxisAlignment: MainAxisAlignment.center,
                        dotsCount: 3,  decorator: DotsDecorator(
                      color: Colors.grey, activeColor: Colors.blue,
                      size: const Size.square(9.0),
                      activeSize: const Size(22.0, 9.0),
                     activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                        
                      
                      ))
                  ],
                );
              }
            ),
          ),
          
        ),
      ),
    );
  }
}