import 'package:audio_player/detail_audio_page.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart' as AppColors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Audio Player',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          cardTheme: CardTheme(color: AppColors.tabVarViewColor)),
      home: DetailAudioPage(),
    );
  }
}
