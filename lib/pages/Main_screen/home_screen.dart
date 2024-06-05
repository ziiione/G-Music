// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:g_application/common/utils/screen/Drawer.dart';
import 'package:g_application/pages/Main_screen/Album/Screens/Album_page.dart';
import 'package:g_application/pages/Main_screen/Artist/screens/ArtistPage.dart';
import 'package:g_application/pages/Main_screen/Audio/screen/AudioPage.dart';
import 'package:g_application/pages/Main_screen/Genres/Screens/GeneresPage.dart';
import 'package:g_application/pages/Main_screen/playlist/screens/playlist_page.dart';

import '/pages/Main_screen/home_screen/widget/appbar_builder.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});
  static const routeName = '/Homepage';

  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController = PageController();
  late final TabController _tabController =
      TabController(length: _children.length, vsync: this);

  final List<Widget> _children = [
   
   const AudioPlayer(),
  const  PlaylistPage(),
 const   AlbumPage(),
    ArtistPage(),
    GenresPage()
  ];

    @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final ui = Provider.of<Ui_changer>(context);
  
    return Scaffold(
      backgroundColor: Colors.black,
     
      //building the appbar
      appBar:
          appBarBuilder(context, _pageController, _tabController, _children),
    
      //drawer seaction
      drawer: DrawerSection(),
    
    //showing the page view
      body: PageView(
        physics:const BouncingScrollPhysics(),
        controller: _pageController,
        children: _children,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },

      ),
      
    );
  }
}

