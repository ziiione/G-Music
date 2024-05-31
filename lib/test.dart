import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:g_application/common/utils/height_width.dart';
import 'package:on_audio_query/on_audio_query.dart';


class PlaylistDetails extends StatefulWidget {
  static const routeName = '/playlist_detail';

  PlaylistDetails({super.key,});

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
    final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
   
     return Scaffold( 

      body:Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
         gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.black.withOpacity(0.9)],)
        ),
        child: Column(
         
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),  
//             Stack(
//               children: [
//                 Positioned(
//   top: 10,
//   child: Container(
//     height: 190,
//     width: MediaQuery.of(context).size.width, // Set the width to the full width of the screen
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//     ),
//     child: QueryArtworkWidget(
//       id: 1, 
//       type: ArtworkType.PLAYLIST, 
//       artworkFit: BoxFit.fill, // Make the image fill the container
//       nullArtworkWidget: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.asset('assets/images/man.png'),
//       )
//     ),
//   ),
// ),
                
                
//                 Container(height: getHeight(context)*0.26,),
//                 Positioned(
//                   top: 100,
//                   left: 135,
//                   child: Text('song title',style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
//                 ),
//                 Positioned(
//                 right: 10,
//                  child: IconButton(onPressed: (){
//                   //  Navigator.pushNamed(context, SearchScreen.routeName);
//                  }, icon: const Icon(Icons.search,color: Colors.white,size: 30,)
//                  ),
//                )   ,
//                Positioned(
//                 left: 10,
//                 child: IconButton(onPressed: (){
//                   Navigator.pop(context);
//                 }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)))  ,
      
              
//               ]
//             ),

Container(
    height: 190,
    width: MediaQuery.of(context).size.width, // Set the width to the full width of the screen
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
    ),
    child: QueryArtworkWidget(
      id: 1, 
      type: ArtworkType.PLAYLIST, 
      artworkFit: BoxFit.fill, // Make the image fill the container
      nullArtworkWidget: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/background.jpg',fit: BoxFit.cover,),
      )
    ),
  ),

             Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                width: MediaQuery.of(context).size.width*0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   Text('28',style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 12,),),
                          
                       
                    const Icon( Icons.shuffle,color: Colors.white,),
                  ],
                ),
              ),            Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.skip_previous,color: Colors.white,),
                    Icon(Icons.skip_next,color: Colors.white,),
                               
                    Icon(Icons.check_circle_outline,color: Colors.white,),
                  ],
                ),
              )
                          ],),
            ),
      //       Expanded(child: FutureBuilder<List<SongModel>>(
      //   future: audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, widget.play.playlist,sortType: SongSortType.DATE_ADDED,orderType: OrderType.ASC_OR_SMALLER),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       return ListView.builder(
      //         physics:const BouncingScrollPhysics(),
      //         itemCount: snapshot.data?.length ?? 0,
      //         itemBuilder: (context, index) {
      //           SongModel song = snapshot.data![index];
      //           return ListTile(
      //             onTap: () {
                    
                    
      //             },
      //             leading: QueryArtworkWidget(
      //               id: song.albumId!,
      //               type: ArtworkType.ALBUM,
      //               artworkFit: BoxFit.cover,
      //     nullArtworkWidget:        ClipRRect(
      //                             borderRadius: BorderRadius.circular(10),
      //                             child: Image.asset('assets/images/cover.jpg'),
      //                           )
      //             ),
      //             title: Text(
      //               song.title,
      //               maxLines: 1,
      //               style: const TextStyle(color: Colors.white),
      //             ),
      //             subtitle: Text(
      //               '${song.artist}',
      //               maxLines: 1,
      //               style: TextStyle(color: Colors.white.withOpacity(0.7)),
      //             ),
      //             trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: Colors.white,)),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ))
          ],
        ),
      ),
    );
  }
}