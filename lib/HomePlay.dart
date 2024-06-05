// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/SongProvider.dart';
import 'package:g_application/pages/Main_screen/Audio/screen/AudioPlay.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

  


class PlayerHome extends StatefulWidget {
  const PlayerHome({super.key});

  @override
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SongProvider>(
      context,
    );
    
    return  GestureDetector(


 onHorizontalDragEnd: (details) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      // Swiped right
      provider.previous_song(provider.currentSong!);
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
      // Swiped left
      // Add your action for swiping left here
      provider.next_song(provider.currentSong!);
    }
  },
  
     onTap: () {

          
        
Navigator.pushNamed(context, Audioplay.routeName,arguments: provider.currentSong!);
        
          
        },
        child: Column(
          children: [
            
            Container(
        width: MediaQuery.of(context).size.width,
        
        margin: EdgeInsets.zero,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0), // Remove overlay padding
            trackHeight: 7,
            trackShape:  const RectangularSliderTrackShape(),
          ),
          child: Slider(
            value: provider.sliderValue,
            max:provider.sliderMaxVAlue,
            min: 0,
            inactiveColor: Colors.grey,
            activeColor:Colors.black, // Change this to your desired color
            onChanged: (value) {
               provider.sliderValue = value;
                                provider.change_duration(value);
            },
          ),
        ),
      ),
            
            Container(
              height: MediaQuery.of(context).size.height * 0.074,
              
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
               
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                              SizedBox(
                        height: 30,
                        width: 30,
                        child: CircleAvatar(
                                radius: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Selector<SongProvider, int>(
                                    selector: (_, provider) => provider.currentSong!.id,
                                    builder: (_, playingSongId, __) {
                                      return Container(
                                        width: 230,
                                        height: 230,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                        ),
                                        
                                        child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: QueryArtworkWidget(
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkBorder: BorderRadius.circular(8),
          artworkClipBehavior: Clip.antiAliasWithSaveLayer,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.asset('assets/images/music_symbol.png', fit: BoxFit.cover),
          ),
          id: provider.currentSong!.albumId!,
          keepOldArtwork: true,
          type: ArtworkType.ALBUM,
        ),
      )
                                        
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                SizedBox(
                                  width:  MediaQuery.of(context).size.width*0.7,
                                  child: Text(
                                    provider.currentSong!.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:  MediaQuery.of(context).size.width*0.6,
                                  child: Text(
                                    provider.currentSong!.artist!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon:   Icon(
                          
                          provider.isplaying?Icons.pause:Icons.play_arrow, color: Colors.white, size: 30),
                          onPressed: (){
                            provider.isplaying?provider.pause_Song():provider.resume_Song();
                            setState(() {
                              provider.isplaying?provider.pause_Song():provider.resume_Song();
                            });
                          },
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.02,
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      );
  }
 
}

