// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:g_application/pages/Main_screen/Audio/screen/AudioPage.dart';
import '/pages/Main_screen/home_screen/widget/appbar_builder.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});
  static const routeName = '/audio';

  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController = PageController();
  late final TabController _tabController =
      TabController(length: _children.length, vsync: this);

  final List<Widget> _children = [
    // AudioPlayerss(),
    // playlist_page(),
    // AlbumPage(),
    // ArtistPage(),
    // GenresPage(),
    AudioPlayer(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    // final ui = Provider.of<Ui_changer>(context);
    return Scaffold(
      backgroundColor: Colors.black,

      //building the appbar
      appBar:
          appBarBuilder(context, _pageController, _tabController, _children),

      //drawer seaction
      drawer: const Drawer(),

//showing the page view
      body: PageView(
        controller: _pageController,
        children: _children,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
      ),
    );
  }
}
