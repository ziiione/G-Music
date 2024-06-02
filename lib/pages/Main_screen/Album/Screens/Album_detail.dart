import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';
import 'package:g_application/common/Provider/playlistProvider.dart';
import 'package:g_application/common/utils/height_width.dart';
import 'package:g_application/pages/Main_screen/Album/Screens/AlbumPlay.dart';
import 'package:glossy/glossy.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';


class AlbumDetail extends StatefulWidget {
  static const routeName = '/Album_detail';
  final AlbumModel play;
  AlbumDetail({super.key,required this.play});

  @override
  State<AlbumDetail> createState() => _AlbumDetailState();
}

class _AlbumDetailState extends State<AlbumDetail> {
    final OnAudioQuery audioQuery = OnAudioQuery();
List<SongModel> _songs = [];
@override
  void initState() {
    // TODO: implement initState
   

    super.initState();
     Future.delayed(const Duration(microseconds: 0), () async {
      Provider.of<AlbumProvider>(context,listen: false).clear_song();
   await  Provider.of<AlbumProvider>(context,listen: false).getSongsFromPlaylist( widget.play);
 print('---------------------------------------------songs---------------------');
 _fetchSongs();
List<SongModel> songs= Provider.of<playlistProvider>(context,listen: false).songs;
print(songs);
    });
  }
  void _fetchSongs() async {
  _songs = await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM, widget.play.album, sortType: SongSortType.DATE_ADDED, orderType: OrderType.ASC_OR_SMALLER);
  setState(() {});
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
                          child: QueryArtworkWidget(id: widget.play.id, type: ArtworkType.ALBUM, artworkFit: BoxFit.cover,
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
                

                  Text(_songs.length.toString(),style: TextStyle(color: Colors.white,),),
                          
                       
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

              child: Text('${widget.play.album}',
              maxLines:1,style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
            ),
            Expanded(child: Consumer<AlbumProvider>(
              builder: (context,providerss,child) {
                return  ListView.builder(
                  physics:const BouncingScrollPhysics(),
                  itemCount: _songs.length ,
                  itemBuilder: (context, index) {
                    SongModel song = _songs[index];
                    return ListTile(
                      onTap: () {
                        print('---------------------------------------------uri is pressed---------------------');
                        print(song.uri);
                         print('---------------------------------------------uri is pressed---------------------');
                       Vibration.vibrate();
                      
                       providerss.stop_Song();
                      //  Provider.of<SongProvider>(context,listen: false).play_song(song);
                       providerss.play_song(song);
                       Navigator.pushNamed(context, AlbumPlay.routeName);
                        
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
                        // setState(() {
                        //    provider.deleteSongFromPlaylist(widget.play.playlist, song);
                        //    _songs.remove(song);
                        // });
                       
                    
                      }, icon: const Icon(Icons.more_vert,color: Colors.white,)),
                    );
                  },
                );
                          }
                        
            ),) 
              
            
          ],
        ),
      ),
    );
  }
}