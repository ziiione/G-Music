import 'package:flutter/material.dart';
import 'package:g_application/pages/Main_screen/Genres/Screens/GenresDetail.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../common/Provider/GenresProvider.dart';


class GenresPage extends StatefulWidget {
  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  @override
  void initState() {
    // TODO: implement initState
    LoadGenres();
    super.initState();
  }
void LoadGenres() async {
  await Provider.of<GenresProvider>(context, listen: false).loadGenres();
  setState(() {});
}
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<GenresProvider>(context,listen: false);
   final genres=provider.Genres;
    return  Column(
            children: [
              Expanded(
                child: ListView.builder(
                   physics:const BouncingScrollPhysics(),
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    final genress=genres[index];
                    return Column(
                      children: [
                          
                          
                              
                        ListTile(
                          onTap: (){
                            //navigate to the genre detail page
                        if(mounted){
                          setState(() {
                            Navigator.pushNamed(context, GeneresDetail.routeName,arguments: {'genres':genres[index]});
                             
                                 });
                        }
                          },
                           leading:  QueryArtworkWidget(
                    quality: 100,
                     artworkBorder: BorderRadius.circular(25),
                     artworkClipBehavior: Clip.antiAliasWithSaveLayer,
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Image.asset('assets/images/music_symbol.png',fit: BoxFit.cover,),
                     
                    id: genres[index].id,
                    type: ArtworkType.GENRE,
                      ),
                          
                          title: Text(
                            genress.genre,
                            style: TextStyle(color: Colors.white),
                            
                          ),
                          subtitle: Text(genres[index].numOfSongs.toString()+' songs',style: TextStyle(color: Colors.grey)),
                          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,)),
                        ),
                        
                      ],
                    );
                    
                  },
                ),
              ),
              // PlayerHome()
            ],
          );
        
  }
}