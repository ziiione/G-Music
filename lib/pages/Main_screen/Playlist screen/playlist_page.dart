import 'package:flutter/material.dart';
import 'package:g_application/pages/Main_screen/Playlist%20screen/PlaylistDetail.dart';
import '/pages/Main_screen/Playlist%20screen/widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../common/Provider/playlistProvider.dart';
import 'popupmenu.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<playlistProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      'Playlist (${provider.playlists.length+2})',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          // code to create the playlist
                          PlaylistPopup(context);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white.withOpacity(0.7),
                        )),
                  ),
                  Flexible(
                    child: ListView.builder(
                      physics:const BouncingScrollPhysics(),
                      itemCount: provider.playlists.length + 2,
                      itemBuilder: (context, index) {
                        if (index < 2) {
                          // return your static ListTile widgets based on the index
                          return buildStaticListTile(index, context);
                        } else {
                          var item = provider.playlists[index - 2];
                          return ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            onTap: () {
                              // code to navigate to the playlist detail page
                              Navigator.pushNamed(context, PlaylistDetail.routeName,
                                  arguments: {'playlist': item});

                            },
                            leading: QueryArtworkWidget(
                                quality: 100,
                                artworkBorder: BorderRadius.circular(20),
                                artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset('assets/images/cover.jpg'),
                                ),
                                id: item.id,
                                type: ArtworkType.PLAYLIST),
                            title: Text(
                              item.playlist,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              '${item.numOfSongs} songs',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: PopupMenuBottom(
                              playlistName: item.playlist,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  // PlayerHome()
                ],
              );
            },
          );
  }
}