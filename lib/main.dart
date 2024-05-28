import 'package:flutter/material.dart';
import 'package:g_application/pages/getting_permission/permission.dart';
import 'package:g_application/pages/welcome/page_provider/page_provider.dart';
import 'package:g_application/pages/welcome/welcome.dart';
import 'package:provider/provider.dart';

import 'pages/Main_screen/audio.dart';
// A Counter example implemented with riverpod

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (RouteSettings setting){
          switch(setting.name){
            case '/':
              return createRoute(Welcome());
            case permission_page.routeName:
              return createRoute(const permission_page());

             case Audio.routeName:
              return createRoute(const Audio()); 
            default:
              return createRoute(Welcome());
          }
        },
        ),
    );
      
  }

  // Routing Animation
PageRouteBuilder createRoute(Widget destination) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return destination;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0),
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}

}
