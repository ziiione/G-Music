//playlist proivder class
// ignore_for_file: camel_case_types, slash_for_doc_comments

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Database/DatabaseHelper.dart';

class AlbumProvider extends ChangeNotifier {
    final audioQuery = OnAudioQuery();
  final databasehelper = DatabaseHelper.instance;
  final player = AudioPlayer();

  bool _isplaying = false;
  bool get isplaying => _isplaying;
  String _currentTime = '0';
  String _totalTime = '0';
  double sliderValue = 0.0;
  double sliderMaxVAlue = 0.0;
  bool is_looping = false;
  bool is_shuffling = false;
  SongModel? currentSong;
  bool _isplayingFromAlbum=false;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<Duration?>? _positionSubscription;

  List<SongModel> _songs = [];
  final ValueNotifier<bool> _isPlayingNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isPlayingNotifier => _isPlayingNotifier;

  double _sound_volume = 0.4;
  double get sound_volume => _sound_volume;
  List<AlbumModel> _Albums = [];


  List<AlbumModel> get Albums => _Albums;

  List<SongModel> get songs => _songs;
  String get currentTime => _currentTime;
  String get totalTime => _totalTime;
  bool get isplayingFromAlbum => _isplayingFromAlbum;


/**----------------------------------------playlist play control function--------------------------------- */

//function to change isplayingfromAlbum to false
  void FalseisplayingFromAlbum() {
    _isplayingFromAlbum = false;
    notifyListeners();
  }

  //function to play the song
  void play_song(SongModel song) async {
    try {
      print('--------------------going to play the song-------------------');
      if (currentSong != null && currentSong!.id != song.id) {
        await player.stop();
      }
      print(song.title);
      print(song.album);
      stop_Song();
      currentSong = song;
      await player.setAudioSource(AudioSource.uri(Uri.parse(song.data)));
      player.play();
      _isplayingFromAlbum=true;
      _isPlayingNotifier.value = true;

      Map<String, dynamic> row = {
        'title': song.title,
        'artist': song.artist,
        'album': song.album,
        'albumId': song.albumId,
      };
      await databasehelper.insert(row);
      update_time();
      _isplaying = true;
      notifyListeners();
      // Listen to the player's state and play the next song when the current song finishes
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        next_song(song);
      }
    });
    } catch (e) {
      print(e);
    }
  }

//function to stop the song playing
  void stop_Song() async {
    await player.stop();
    _isplaying = false;
    _isPlayingNotifier.value = false;
    notifyListeners();
  }

  //function to pause the song
  void pause_Song() async {
    await player.pause();

    _isplaying = false;
    _isPlayingNotifier.value = false;
    notifyListeners();
  }

  //function to resume the song
  void resume_Song() async {
    await player.play();
    _isplaying = true;
    _isPlayingNotifier.value = true;
    notifyListeners();
  }

 //function to play the next song
  void next_song(SongModel song) async {
  if(is_shuffling){
    final random = Random().nextInt(_songs.length);
    play_song(_songs[random]);
  } else {
    print(_songs);
    int index=-1;
    for(int i=0;i<_songs.length;i++){
      if((song.albumId==_songs[i].albumId)&&(song.id==_songs[i].id)&&(song.title==_songs[i].title)){
        index=i;
        break;
      }
    }
  
    print(song.data);
  
    print('doing the next song');
    if (index!=-1 && index + 1 < _songs.length) { // Check if the index is within the valid range
      play_song(_songs[index + 1]);
    } else {
      // Decide what to do if the current song is the last one in the list
     stop_Song();
     
    }
  }
}

  //function to play the previous song
  void previous_song(SongModel song) async {
    if(is_shuffling){
      final random = Random().nextInt(_songs.length-1);
      play_song(_songs[random]);}
    else{
          int index=-1;
    for(int i=0;i<_songs.length;i++){
      if((song.albumId==_songs[i].albumId)&&(song.id==_songs[i].id)&&(song.title==_songs[i].title)){
        index=i;
        break;
      }
    }
    
    if (index == 0) {
      play_song(_songs[_songs.length - 1]);
    } else {
      play_song(_songs[index - 1]);
    }}
  }

  //function to rewind 10 seconds
 void rewind() async {
  if (player.position <= const Duration(seconds: 10)) {
    await player.seek(Duration.zero);
  } else {
    await player.seek(player.position - const Duration(seconds: 10));
  }
}
  //function to fast forward 10 seconds
  void fast_forward() async {
  Duration newPosition = player.position + const Duration(seconds: 10);
  if (newPosition >= player.duration!) {
    await player.seek(player.duration);
  } else {
    await player.seek(newPosition);
  }
}
/**--------------------------song volume control ---------------------------------------------------- */
  //function to change the volume of the song
  void change_volume(double newVolume) async {
    try {
      _sound_volume = newVolume;
      await player.setVolume(newVolume);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //function to update the time of the song
     void update_time() {
    try {
      _durationSubscription = player.durationStream.listen((event) {
        _totalTime = event!.toString().split(".")[0];
        sliderMaxVAlue = event.inSeconds.toDouble();
        notifyListeners();
      });
      _positionSubscription = player.positionStream.listen((event) {
        _currentTime = event.toString().split(".")[0];
        sliderValue = event.inSeconds.toDouble();
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }
   @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
  }

  //function to change the duration of the song
  void change_duration(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  //function to loop the song
  void loop_song() async {
    is_looping = !is_looping;
    await player.setLoopMode(is_looping ? LoopMode.one : LoopMode.off);
    notifyListeners();
  }

  //function to shuffle the song
  void shuffle_song() async {
    try {
      if (is_shuffling) {
        player.setShuffleModeEnabled(false);
        print('shuffle off');
        is_shuffling = false;
      } else {
        print('shuffle on');
        player.setShuffleModeEnabled(true);
        is_shuffling = true;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /**--------------------------------------------------Playlist Function operation ------------------------------ */
// Function to create the playlist


  //function to get all the songModel of from the album
  Future<List<SongModel>> getSongsFromPlaylist(AlbumModel play) async {
    try {    

    _songs=await audioQuery.queryAudiosFrom(AudiosFromType.ALBUM, play.album,sortType: SongSortType.DATE_ADDED,orderType: OrderType.ASC_OR_SMALLER);
  
    return [..._songs];
    } catch (e) {
      print(e);
      print('Failed to get songs from playlist: $e');
      return [];
    }
  }


/** ---------------------------------------------- loading and permisssion activity and clear song------------------------------ */
  // function to load the playlist
 Future<void>  loadAlbums() async {
    print('Loading the song of playlist ');
    _Albums = await audioQuery.queryAlbums();

    

    print('.............................................................');
    notifyListeners();
    
  }


//function to clear _song list
  void clear_song() {
    _songs.clear();
    notifyListeners();
  }

}

