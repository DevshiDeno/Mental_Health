import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:microphone/microphone.dart';

class RecordAudio extends StatefulWidget {
  const RecordAudio({super.key});

  @override
  _RecordAudioState createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  late AudioPlayer audioPlayer;
  late MicrophoneRecorder recorder;
  late Uint8List audioData;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    recorder = MicrophoneRecorder()..init();
    audioData = Uint8List(0);
  }

  Future<void> startRecording() async {
    await recorder.start();
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  Future<void> stopRecording() async {
    await recorder.stop();
    // Play the recorded audio (optional)
    final recordingUrl = recorder.value.recording?.url;
    _isRecording = !_isRecording;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(_isRecording)
            const Text("Recording..."),
            IconButton(
              onPressed: () {
                startRecording();
              },
              icon: Icon(
                Icons.mic,
                size: 30,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                stopRecording();
              },
              child: Text("Stop Recording"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    recorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
