import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/playlistProvider.dart';
import 'package:g_application/common/utils/height_width.dart';
import 'package:g_application/pages/Main_screen/playlist/screens/playlistPlay.dart';
import 'package:glossy/glossy.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';


class PlaylistDetail extends StatefulWidget {
  static const routeName = '/playlist_detail';
  final PlaylistModel play;
  PlaylistDetail({super.key,required this.play});

  @override
  State<PlaylistDetail> createState() => _PlaylistDetailState();
}

class _PlaylistDetailState extends State<PlaylistDetail> {
    final OnAudioQuery audioQuery = OnAudioQuery();

@override
  void initState() {
    // TODO: implement initState
   

    super.initState();
     Future.delayed(const Duration(microseconds: 0), () async {
      Provider.of<playlistProvider>(context,listen: false).clear_song();
   await  Provider.of<playlistProvider>(context,listen: false).getSongsFromPlaylist( widget.play);
 print('---------------------------------------------songs---------------------');

List<SongModel> songs= Provider.of<playlistProvider>(context,listen: false).songs;
print(songs);
    });
  }
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
            Stack(
              children: [
               

                Center(
                  child: GlossyContainer(height: 200, width: getWidth(context)*0.9,
                    borderRadius: BorderRadius.circular(20),
                    child: Center(
                      child: Container(
                        height: getHeight(context)*0.18,
                        width: getWidth(context)*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: QueryArtworkWidget(id: widget.play.id, type: ArtworkType.PLAYLIST, artworkFit: BoxFit.cover,
                        nullArtworkWidget: Center(child: Image.asset('assets/images/music_symbol2.png',fit: BoxFit.cover,)), ),
                        ),
                      ),
                    )
                  ),
                ),
                
                
                Container(height: getHeight(context)*0.26,),
             
                Positioned(
                right: 30,
                top: 10,
                 child: IconButton(onPressed: (){
                  //  Navigator.pushNamed(context, SearchScreen.routeName);
                 }, icon: const Icon(Icons.search,color: Colors.white,size: 30,)
                 ),
               )   ,
               Positioned(
                left: 30,
                top: 10,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back,color: Colors.white,size: 30,)))  ,
      
            
              ]
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
                   Text(widget.play.numOfSongs.toString(),style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 12,),),
                          
                       
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
            SizedBox(height: getHeight(context)*0.01,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),

              child: Text('${widget.play.playlist}',
              maxLines:1,style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
            ),
            Expanded(child: Consumer<playlistProvider>(
              builder: (context,providers,child) {
                return FutureBuilder<List<SongModel>>(
                        future: audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, widget.play.playlist,sortType: SongSortType.DATE_ADDED,orderType: OrderType.ASC_OR_SMALLER),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                return ListView.builder(
                  physics:const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    SongModel song = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        print('---------------------------------------------uri is pressed---------------------');
                        print(song.uri);
                         print('---------------------------------------------uri is pressed---------------------');
                       Vibration.vibrate();
                       providers.currentSong=song;
                       providers.stop_Song();
                      //  Provider.of<SongProvider>(context,listen: false).play_song(song);
                       providers.play_song(song);
                       Navigator.pushNamed(context, PlaylistPlay.routeName ,arguments: { 'song': song});
                        
                      },
                      leading: QueryArtworkWidget(
                        id: song.albumId!,
                        type: ArtworkType.ALBUM,
                        keepOldArtwork: true,
                        artworkFit: BoxFit.cover,
                              nullArtworkWidget:        ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset('assets/images/cover.jpg'),
                                    )
                      ),
                      title: Text(
                        song.title,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${song.artist}',
                        maxLines: 1,
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                      trailing: IconButton(onPressed: (){
                        providers.deleteSongFromPlaylist(widget.play.playlist, song);
                    
                      }, icon: const Icon(Icons.delete,color: Colors.white,)),
                    );
                  },
                );
                          }
                        },
                      );
              }
            ))
          ],
        ),
      ),
    );
  }
}