// import 'dart:math';

// import 'package:audio_progress_bars/audio_progress_bars.dart';
// import 'package:flutter/material.dart';

// class testing extends StatefulWidget {
//   const testing({Key? key}) : super(key: key);

//   @override
//   State<testing> createState() => _testingState();
// }

// class _testingState extends State<testing> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   final List<double> values = [];
//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData queryData = MediaQuery.of(context);
//     var rng = Random();
//     for (var i = 0; i < 100; i++) {
//       values.add(rng.nextInt(70) * 1.0);
//     }
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: [
//             AudioProgressBars(
//               progressPercentage: 70,
//               listOfHeights: values,
//               width: queryData.size.width,
//               initalColor: Colors.grey,
//               progressColor: Colors.red,
//               backgroundColor: Colors.white,
//               timeInMilliSeconds: 2000,
//               isHorizontallyAnimated: true,
//               isVerticallyAnimated: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }