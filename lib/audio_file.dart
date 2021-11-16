import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer? advancePlayer;
  const AudioFile({Key? key, this.advancePlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
