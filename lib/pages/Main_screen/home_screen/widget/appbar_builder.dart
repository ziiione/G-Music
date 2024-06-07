import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/library.dart';

import '../../../../common/utils/height_width.dart';
import '../../../../common/utils/screen/SearchScreen.dart';
import '../../../../common/widget/text_widget.dart';

AppBar appBarBuilder(BuildContext context, PageController pageController, TabController tabController, List<Widget> children){
  return AppBar(
         iconTheme: const IconThemeData(
        color: Colors.white,
        size: 20.0
      ),
      elevation: 0,
    
      actions: [IconButton(onPressed: (){

      Navigator.pushNamed(context, SearchScreen.routeName);


      },
      
      
       icon: Icon(Icons.search,color: Colors.white.withOpacity(0.7),size: getHeight(context)*0.035,)),
       IconButton(onPressed: (){
        
       }, icon: Icon(Icons.refresh,color: Colors.white.withOpacity(0.7),size: getHeight(context)*0.035,)),
       ],
        title: text16Normal(text: 'Scanning...', color: Colors.white),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AnimatedBuilder(
            animation: tabController,
            builder: (BuildContext context, Widget? child) {
              return CustomTabBar(
                pinned: false,
                direction: Axis.horizontal,
                height: 40.0,
                itemCount: children.length,
                pageController: pageController,
                builder: (context, index) {
                  return Tab(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black
                          ),
                          child: Text(
                            ['SONGS', 'PLAYLIST', 'ALBUMS', 'ARTISTS', 'GENRES'][index],
                            style:  TextStyle(
                              color: tabController.index == index ? const Color(0xFF845EC2) : Colors.white.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                          ),
                        ),
                         // code to show a line under the selected tab
                          if (tabController.index == index)
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5.0,left: 3),
                              height: 2.0,
                              width: 50.0,
                              color: const Color.fromARGB(255, 112, 69, 182),
                            ),
                            
                      ],
                    ),
                  );
                },
                onTapItem: (index) {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              );
            },
          ),
        ),
      );
}