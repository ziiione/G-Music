import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_audio_trimmer/easy_audio_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mime/mime.dart';
import 'package:glossy/glossy.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';





class Track_cutter extends StatefulWidget {
  final File file;
  final SongModel song;
  static const routeName = '/audio-trimmer';
  const Track_cutter({super.key, required this.file,required this.song});
  @override
  State<Track_cutter> createState() => _Track_cutterState();
}

class _Track_cutterState extends State<Track_cutter> {
final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _loadAudio();
  }

  void _loadAudio() async {
    setState(() {
      isLoading = true;
    });
    await _trimmer.loadAudio(audioFile: widget.file);
    setState(() {
      isLoading = false;
    });
  }

_saveAudio() async {
  if (mounted) {
    setState(() {
      _progressVisibility = true;
    });
  }

  // Generate a unique filename
  String fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';

  _trimmer.saveTrimmedAudio(
    startValue: _startValue,
    endValue: _endValue,
    // Provide only the filename, not the path
    audioFileName: widget.song.title,
    onSave: (outputPath) async {
      if (mounted) {
        setState(() {
          _progressVisibility = false;
        });
      }
  // Edit the metadata of the saved audio file
        await MetadataGod.writeMetadata(
           file: outputPath!,
          metadata: Metadata(
            title: widget.song.title,
            artist: widget.song.artist,
            album: widget.song.album,
            albumArtist: widget.song.album,
            genre: widget.song.genre,
            
            // Add more fields as needed
          ),
        );

      // Save the file to the Music directory
      bool isSaved = await saveTrimmedAudio(outputPath.toString(), fileName);

      if (isSaved) {
        print('Audio successfully saved');

      
        // Show a confirmation to the user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Audio saved successfully!')),
          );
        }
      } else {
        print('Failed to save audio');
        // Show an error message to the user
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save audio')),
          );
        }
      }

      // Delete the original file
      await File(outputPath.toString()).delete();
    },
  );
}
Future<bool> saveTrimmedAudio(String path, String fileName) async {
  try {
    // Request storage permissions
    if (await _requestPermission(Permission.storage)) {
      final musicDirectoryPath = await _getMusicDirectoryPath();

      // Ensure the directory exists
      final directory = Directory(musicDirectoryPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Define the new path for the audio file
      final newPath = '$musicDirectoryPath/$fileName';
      print('New path for trimmed audio: $newPath');

      // Copy the trimmed audio file to the new path
      final file = await File(path).copy(newPath);
      print('Saved trimmed audio to: ${file.path}');

      // Confirm the file exists
      if (await File(newPath).exists()) {
        return true;
      } else {
        return false;
      }
    } else {
      print('Storage permission denied');
      return false;
    }
  } catch (e) {
    print('Error saving trimmed audio: $e');
    return false;
  }
}

Future<bool> _requestPermission(Permission permission) async {
  final status = await permission.request();
  print('Permission status: $status');
  return status == PermissionStatus.granted;
}

Future<String> _getMusicDirectoryPath() async {
  if (Platform.isAndroid) {
    if (await _isAndroid10OrAbove()) {
      return await _getScopedStoragePath();
    } else {
      return await _getLegacyExternalStoragePath();
    }
  } else {
    throw UnsupportedError('This platform is not supported');
  }
}

Future<String> _getLegacyExternalStoragePath() async {
  final directory = Directory('/storage/emulated/0/Music');
  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }
  return directory.path;
}

Future<String> _getScopedStoragePath() async {
  final directory = await getExternalStorageDirectory();
  final scopedPath = '${directory!.parent.parent.parent.path}/Music';
  print('Scoped storage path: $scopedPath');
  return scopedPath;
}

Future<bool> _isAndroid10OrAbove() async {
  return Platform.isAndroid && (await _getAndroidVersion()) >= 29;
}

Future<int> _getAndroidVersion() async {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  final sdkInt = androidInfo.version.sdkInt;
  print('Android SDK version: $sdkInt');
  return sdkInt;
}


  @override
  Widget build(BuildContext context) {
      
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 100,
          centerTitle: true,
          title: const Text("Audio Trimmer",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: isLoading
            ? const CircularProgressIndicator()
            : Center(
                child: Container(
                 width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black,
                       
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                    
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Visibility(
                        visible: _progressVisibility,
                        child: LinearProgressIndicator(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                      ),
                      
                      // AudioViewer(trimmer: _trimmer),
                      GlossyContainer(
                        borderRadius: BorderRadius.circular(12),
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width*0.95,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TrimViewer(
                              trimmer: _trimmer,
                              viewerHeight: 100,
                              viewerWidth: MediaQuery.of(context).size.width,
                              durationStyle: DurationStyle.FORMAT_MM_SS,
                              
                              backgroundColor: Theme.of(context).primaryColor,
                              barColor: Colors.white,
                              durationTextStyle: const TextStyle(
                                  color: Colors.white),
                              allowAudioSelection: true,
                              editorProperties: TrimEditorProperties(
                                circleSize: 10,
                                borderPaintColor: Colors.black,
                                borderWidth: 4,
                                borderRadius: 5,
                                circlePaintColor: Colors.black.withOpacity(0.8),
                              ),
                              areaProperties:
                                  TrimAreaProperties.edgeBlur(blurEdges: true),
                              onChangeStart: (value) => _startValue = value,
                              onChangeEnd: (value) => _endValue = value,
                              onChangePlaybackState: (value) {
                                if (mounted) {
                                  setState(() {
                                     _isPlaying =value;
                                     });
                                }
                              },
                            )
                          ),
                        ),
                      ),
                      TextButton(
                        child: _isPlaying
                            ? const Icon(
                                Icons.pause,
                                size: 80.0,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 80.0,
                                color: Colors.white,
                              ),
                        onPressed: () async {
                          bool playbackState =
                              await _trimmer.audioPlaybackControl(
                            startValue: _startValue,
                            endValue: _endValue,
                          );
                          setState(() => _isPlaying = playbackState);
                          
                        },
                       
                      ),
                      ElevatedButton(
                        onPressed:
                            (){
// _progressVisibility ? null : () async =>await _saveAudio();

if(mounted){
setState(() {
  _progressVisibility?null:_saveAudio();
Navigator.pop(context);
});
}

                            },
                           
                        
                        child: const Text("SAVE"),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}