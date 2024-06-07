import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:g_application/common/Provider/SongProvider.dart';
import 'package:g_application/common/Provider/Timer.dart';
import 'package:g_application/common/utils/height_width.dart';
import 'package:g_application/common/utils/screen/Equalizer.dart';
import 'package:g_application/common/widget/snackbar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../../../common/utils/bottomSheet.dart';

class Icons_Row_items extends StatelessWidget {
  const Icons_Row_items({
    required this.song,
    Key? key,
  }) : super(key: key);
  final SongModel song;

  @override
  Widget build(BuildContext context) {
   
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EqualizerPage.routeName);
            },
            icon: const Icon(
              Icons.equalizer,
              color: Colors.white,
              size: 34,
            )),
        IconButton(
            onPressed: () {
              playlist_bottom_sheet(context, song);
            },
            icon: const Icon(
              Icons.playlist_add,
              color: Colors.white,
              size: 34,
            )),
        IconButton(
  onPressed: () async {
    final resultingDuration = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(

          data: ThemeData(
            colorScheme: const ColorScheme.light(
            
              primary: Colors.white, // change to your desired color
            ),
            dialogBackgroundColor: Colors.black, // change dialog background color
          ),
          child: const DurationPickerDialog(
            initialTime: Duration(minutes: 30),
            baseUnit: BaseUnit.minute,
            upperBound: Duration(minutes: 60),
            lowerBound: Duration(minutes: 10),
          ),
        );
      },
    );
    if (!context.mounted) return;

    if(resultingDuration == null) return;
    Provider.of<SongProvider>(context,listen: false).Timertoshow(resultingDuration);
    // showSnackBar(context, 'Sleep Timer Activated');
    SleepTimer(context: context).start(resultingDuration);
   showSnackBar(context, 'Chose duration: ${resultingDuration.split(".")[0]}');

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Chose duration: $resultingDuration'),
    //   ),
    // );
  },
  tooltip: 'Popup Duration Picker',
  icon:  const Icon(
    Icons.timer_outlined,
    color: Colors.white,
    size: 34,
  ),
),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.library_music,
              color: Colors.white,
              size: 34,
            )),
        InkWell(
            child: IconButton(
                onPressed: () async {
                  //get the absolute path of the song from uri
                  // final filePath =
                  //     await LecleFlutterAbsolutePath.getAbsolutePath(
                  //         uri: provider.currentSong.uri.toString());

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AudioTrimmerView(
                  //             file: File(filePath!))));


               
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 34,
                ))),
      ],
    );
  }
}


class SleepTimerValue extends StatelessWidget {
  const SleepTimerValue({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<SongProvider>(context,);
    return provider.startTimer? Container(
      padding: EdgeInsets.only(left: getWidth(context)*0.3,right: getWidth(context)*0.05,),
      height: getHeight(context)*0.04,
      width: getWidth(context)*0.8,
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(20)
     ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${provider.currentDuration.toString().split(".")[0]}',style: const TextStyle(color: Colors.black,fontSize: 20),),
                 InkWell(
                  onTap: (){
                    removeTimerPopup(context);
                  
                  },
                  child: const Icon(Icons.cancel_outlined,color: Colors.red,),
                 )
         ],
      )):const SizedBox(
      height: 0,
      width: 0,
      );
  }
}

//function to show the popup to confirm user want to remove the timer or not
void removeTimerPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.black,
        title: const Text('Are you sure to remove the timer?',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              SleepTimer(context: context).stop();
              Provider.of<SongProvider>(context,listen: false).stop_Timer();
              Navigator.pop(context);
            },
            child: const Text('Remove'),
          ),
        ],
      );
    },
  );
}