// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:g_application/common/Provider/ArtistProvider.dart';
import 'package:g_application/common/utils/app_color.dart';
import 'package:g_application/common/widget/text_widget.dart';
import 'package:g_application/pages/Main_screen/Artist/widgets/AnimationPlayArtist.dart';
import 'package:g_application/pages/Main_screen/Artist/widgets/IconRowItemArtist.dart';
import 'package:g_application/pages/Main_screen/Artist/widgets/PauseNextLoopSuffleArtist.dart';
import 'package:g_application/pages/Main_screen/Artist/widgets/SliderControlArtist.dart';
import 'package:g_application/pages/Main_screen/Artist/widgets/TimePlayValueArtist.dart';
import 'package:glossy/glossy.dart';
import 'package:siri_wave/siri_wave.dart';
import '../../../../common/utils/bottomSheet.dart';
import '../../../../common/utils/height_width.dart';
import 'package:provider/provider.dart';
import '../widgets/sfreadialgaugeArtist.dart';

class ArtistPlay extends StatelessWidget {
  ArtistPlay({super.key});
  static const routeName = '/ArtistPlay';

  final controller = IOS7SiriWaveformController(
    amplitude: 1,
    speed: 1,
    frequency: 6,
  );

  final controller2 = IOS7SiriWaveformController(
    amplitude: 0,
    speed: 0,
    frequency: 1,
  );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArtistProvider>(context);
    return Scaffold(

        //gesture detector for swipe up and down, left and right
        body: GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          // Swiped right
          provider.previous_song(provider.currentSong!);
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          // Swiped left
          provider.next_song(provider.currentSong!);
        }
      },
     
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.9),
            Colors.black, // Fully transparent
            Colors.black.withOpacity(0.9), // Fully opaque
          ],
        )),
        height: getHeight(context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(context) * 0.05,
                ),
                Stack(
                  children: [
                    // volume Control and album image
                    GlossyContainer(
                      borderRadius: BorderRadius.circular(12),
                      height: getHeight(context) * 0.35,
                      width: getWidth(context) * 0.9,
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: getHeight(context) * 0.03,
                        ),
                        child: SfreadialgaugeArtist(provider: provider),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(context) * 0.02),

                //song details

                Column(
                  children: [
                    GlossyContainer(
                      borderRadius: BorderRadius.circular(12),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/play_outline.svg'),
                                const SizedBox(
                                  width: 10,
                                ),
                                text11Bold(
                                    text:
                                        '${provider.Artist.length} Playing',
                                    color:
                                        AppColors.primarySecondaryElementText),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    provider.currentSong!.title,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // showing of modal bottom sheet
                                      buttomsheet(context, provider.currentSong!);
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white.withOpacity(0.7),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    provider.currentSong!.artist.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),

                    //play control
                    Column(
                      children: [
                       AnimationPlayArtist(
                            provider: provider,
                            controller: controller,
                            controller2: controller2),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                         IconRowItemArtist( song: provider.currentSong!,),
                        SliderControlArtist(provider: provider),
                        TimePlayValueArtist(provider: provider),
                        const PauseNextLoopSuffleArtist(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}



