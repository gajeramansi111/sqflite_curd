// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SoundRecoder {
//   FlutterSoundRecorder? audioRecoder;
//   bool recordInitialised = false;
//   bool get isRecord => audioRecoder!.isRecording;
//
//   File? file;
//   Future init() async {
//     audioRecoder = FlutterSoundRecorder();
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       throw 'Permission not granted';
//     }
//     await audioRecoder!.openRecorder();
//     recordInitialised = true;
//   }
//
//   void dispose() {
//     if (recordInitialised) return;
//     audioRecoder!.closeRecorder();
//     audioRecoder = null;
//     recordInitialised = false;
//   }
//
//   Future record() async {
//     await audioRecoder!.startRecorder(toFile: file!.path);
//   }
//
//   Future stopeRecord() async {
//     await audioRecoder!.stopRecorder();
//   }
//
//   Future toggelREcoding() async {
//     if (audioRecoder!.isStopped) {
//       await record();
//     } else {
//       await stopeRecord();
//     }
//   }
// }
