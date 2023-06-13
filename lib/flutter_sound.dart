// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:notes_app/sound_record.dart';
//
// class FlutterSound extends StatefulWidget {
//   const FlutterSound({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterSound> createState() => _FlutterSoundState();
// }
//
// class _FlutterSoundState extends State<FlutterSound> {
//   final recoer = SoundRecoder();
//   @override
//   void initState() {
//     super.initState();
//     recoer.init();
//   }
//
//   @override
//   void dispose() {
//     recoer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // ElevatedButton(
//           //     onPressed: () async {
//           //       if (isRecording) {}
//           //     },
//           //     child: isRecording == true
//           //         ? Icon(
//           //             Icons.mic_none_outlined,
//           //             color: Colors.cyan,
//           //           )
//           //         : Icon(Icons.stop))
//           buildStart(),
//         ],
//       ),
//     );
//   }
//
//   buildStart() {
//     final isRecord = recoer.isRecord;
//     final icon = isRecord ? Icons.stop : Icons.mic;
//     final text = isRecord ? "Stop" : "Start";
//     final primary = isRecord ? Colors.pink : Colors.blue;
//     final onPrimary = isRecord ? Colors.blue : Colors.white;
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//           minimumSize: Size(100, 50), primary: primary, onPrimary: onPrimary),
//       label: Text(text),
//       icon: Icon(icon),
//       onPressed: () async {
//         final isRecord = await recoer.toggelREcoding();
//         setState(() {});
//       },
//     );
//   }
// }
