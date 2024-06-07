import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../pages/Main_screen/Audio/widget/icon_row.dart';
import '../../Provider/SongProvider.dart';
import '../../Provider/Timer.dart';
import '../../widget/snackbar.dart';

class SleepTimerScreen extends StatelessWidget {
  const SleepTimerScreen({Key? key}) : super(key: key);
  static const routeName = '/SleepTimerScreen';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sleep Timer', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.alarm,
              color: Colors.white,
              size: 100.0,
            ),
            SizedBox(height: 20),
            Consumer<SongProvider>(
              builder: (context,provider,child) {
                return Text(
                  '${provider.currentDuration.toString().split(".")[0]}', // replace with your countdown timer
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                );
              }
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:  () async {
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
  
              child: Text('Start Timer'),
              style: ElevatedButton.styleFrom(
                
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sleep well',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20), 
          const  CancelTimer()
          ],
        ),
      ),
    );
  }
}

class CancelTimer extends StatelessWidget {
  const CancelTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<SongProvider>(context);  
    return provider.startTimer? ElevatedButton(
      onPressed: () {
       
         removeTimerPopup(context);
      },
      child: Text('Cancel Timer'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ):SizedBox();
  }
}