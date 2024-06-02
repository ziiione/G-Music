import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/AlbumProvider.dart';
import 'package:g_application/pages/Main_screen/Album/Screens/Album_detail.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    // TODO: implement initState
    LoadAlbums();
   
    super.initState();
  }
void LoadAlbums() async {
  await Provider.of<AlbumProvider>(context, listen: false).loadAlbums();
  setState(() {});
}
  @override
  Widget build(BuildContext context) {
   
    final provider = Provider.of<AlbumProvider>(context, listen: false);
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: provider.Albums.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // number of items per row
                    childAspectRatio: 1.0, // item width to height ratio,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final album = provider.Albums[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AlbumDetail.routeName,
                        arguments: {'album': album},
                      );
                    },
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              width: 100,
                              child: GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: QueryArtworkWidget(
                                    id: album.id,
                                    type: ArtworkType.ALBUM,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget:Image.asset('assets/images/music_symbol2.png',fit: BoxFit.cover,) ,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: Column(
                              children: [
                                Text('${album.album}',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('${album.artist}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 8,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // PlayerHome()
        ],
      ),
    );
  }
}