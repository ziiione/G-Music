import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/ArtistProvider.dart';
import 'package:g_application/pages/Main_screen/Artist/screens/ArtistDetail.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../HomePlay.dart';

class ArtistPage extends StatefulWidget {
 

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
@override
  void initState() {
    // TODO: implement initState
    LoadArtists();
    super.initState();
  }
void LoadArtists() async {
  await Provider.of<ArtistProvider>(context, listen: false).loadArtist();
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<ArtistProvider>(context,listen: false);
   
    return  Container(
        color:Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                itemCount:  provider.Artist.length,
                itemBuilder: (context, index) {
                  final song=provider.Artist[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: (){
                          
                        if(mounted){
                          setState(() {
                             Navigator.pushNamed(context, ArtistDetail.routeName,arguments: {'artist':song});
                                  });
                        }
                        },
                              leading:  QueryArtworkWidget(
                                      quality: 100,
                                       artworkBorder: BorderRadius.circular(25),
                                       artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                      artworkFit: BoxFit.cover,
                                      keepOldArtwork: true,
                                      nullArtworkWidget: Image.asset('assets/images/music_symbol.png',fit: BoxFit.cover,),
                                       
                                      id: song.id,
                                      type: ArtworkType.ARTIST,
                              ),
                        title: Text(
                          song.artist,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${song.numberOfAlbums} Albums  |  ${song.numberOfTracks} Songs',
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(onPressed: (){
                      
                        }, icon: Icon(Icons.more_vert,color: Colors.white.withOpacity(0.7),))
                      ),
                    ],
                  );
                },
              ),
            ),
            // PlayerHome()
          ],
        ),
      );
  }
}