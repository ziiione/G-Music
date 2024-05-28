// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:g_application/pages/getting_permission/permission.dart';
import 'package:g_application/pages/welcome/page_provider/page_provider.dart';
import 'package:g_application/pages/welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/Main_screen/audio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _welcomePageShown = false;
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((_) {
      setState(() {});
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _welcomePageShown = prefs.getBool('welcomePageShown') ?? false;
    _permissionGranted = prefs.getBool('permissionGranted') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadPreferences(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => PageProvider(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (RouteSettings setting) {
                switch (setting.name) {
                  case '/':
                    if (!_welcomePageShown) {
                      return createRoute(Welcome());
                    } else if (!_permissionGranted) {
                      return createRoute(const permission_page());
                    } else {
                      return createRoute(const Audio());
                    }
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
        } else {
          return const CircularProgressIndicator(); // Show a loading spinner while waiting
        }
      },
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
