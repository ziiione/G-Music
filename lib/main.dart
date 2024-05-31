// ignore_for_file: library_private_types_in_public_api
import 'package:equalizer_flutter/equalizer_flutter.dart';
import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/playlistProvider.dart';
import 'package:g_application/common/utils/screen/Equalizer.dart';
import 'package:g_application/pages/Main_screen/Playlist%20screen/PlaylistDetail.dart';
import 'pages/Main_screen/Audio/screen/AudioPlay.dart';
import './pages/getting_permission/permission.dart';
import './pages/welcome/page_provider/page_provider.dart';
import './pages/welcome/welcome.dart';
import 'package:g_application/test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/Provider/SongProvider.dart';
import 'common/Provider/app_ui_provider.dart';
import 'pages/Main_screen/home_screen.dart';

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
    EqualizerFlutter.init(0);
    _loadPreferences().then((_) {
      setState(() {});
    });
  }

 @override
  void dispose() {
    EqualizerFlutter.release();
    super.dispose();
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
              ),
              ChangeNotifierProvider(create: (_) => Ui_changer()),
              ChangeNotifierProvider(create: (_) => SongProvider()),
              ChangeNotifierProvider(create: (_)=>playlistProvider())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
               
              // home: PlaylistDetails(),
              onGenerateRoute: (RouteSettings setting ) {
                switch (setting.name) {
                  case '/':
                    if (!_welcomePageShown) {
                      return createRoute(Welcome());
                    } else if (!_permissionGranted) {
                      return createRoute(const permission_page());
                    } else {
                        
                      return createRoute(const Home_page());
                      
                     
                    }
                  case permission_page.routeName:
                    return createRoute(const permission_page());
                  case Home_page.routeName:

                    return createRoute(const Home_page());

                  case Audioplay.routeName:
                    return createRoute( Audioplay());

                  case EqualizerPage.routeName:
                    return createRoute( const EqualizerPage());  

                    case PlaylistDetail.routeName:
                           var args = setting.arguments as Map;
                           var playlist = args['playlist'];
                    return createRoute( PlaylistDetail( play: playlist,));
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
