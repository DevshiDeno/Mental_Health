import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class RecordAudio extends StatefulWidget {
  const RecordAudio({super.key});

  @override
  State<RecordAudio> createState() => _RecordAudioState();
}

class _RecordAudioState extends State<RecordAudio> {
  late final RecorderController recorderController;
  String? path;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;

  void _initialiseControllers() {
    recorderController = RecorderController();
  }

  @override
  void initState() {
    _initialiseControllers();
    super.initState();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Recorder'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Row(
              children: [
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    child: isRecording
                        ? AudioWaveforms(
                            size: Size(we / 2, 50),
                            recorderController: recorderController,
                            waveStyle: WaveStyle(
                              waveColor: Colors.white,
                              extendWaveform: true,
                              showMiddleLine: false,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: const Color(0xFF1E1B26),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15),
                          )
                        : Container(
                            width: we / 1.7,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1B26),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _refreshWave();
                              },
                              icon: Icon(
                                  isRecording ? Icons.refresh : Icons.send),
                              color: Colors.white,
                            ),
                          )),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _startOrStopRecording,
                  icon: Icon(isRecording ? Icons.stop : Icons.mic),
                  color: Colors.white,
                  iconSize: 28,
                ),
              ],
            )),
    );
  }
  void _startOrStopRecording()async{
    try{
      if(isRecording){
        recorderController.reset();
        final path =await recorderController.stop(false);
        if(path!=null){
          isRecordingCompleted=true;
          debugPrint(path);
        //  debugPrint("Recorded file size: ${File(path as List<Object>).lengthSync()}");
        }else{
          await recorderController.record(path: path);
        }
      }
    }catch(e){
debugPrint(e.toString());
      }finally{
      setState(() {
        isRecording=!isRecording;
      });
    }
  }
  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}
