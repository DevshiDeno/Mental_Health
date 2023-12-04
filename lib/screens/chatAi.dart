
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/Model/Question.dart';
import 'package:mental_health/Providers/Provider_home.dart';
import 'package:mental_health/Components/test.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.feeling});

  final String feeling;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final TextEditingController _textEditingController = TextEditingController();
  final bool _isRecording = false;
  //String? result;
  bool isServiceAvailable = false;
  String? userQuestion;
  String? generatedAnswer;
  bool loading = false;
  final String api = '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';
  late OpenAI openAI;
  bool isCompleted = false;

  Future _generateAnswer() async {
    final request = CompleteText(
        prompt: userQuestion!, model: TextDavinci3Model(), maxTokens: 200);
    final response = await openAI.onCompletion(request: request);
    print(response);
    setState(() {
      generatedAnswer = response?.choices.first.text;
      loading = false;
      final chatData = Provider.of<ChatDataProvider>(context, listen: false);
      chatData.addChatMessage(userQuestion!);
      chatData.addChatAnswer(generatedAnswer!);
    });
    print(generatedAnswer);
  }
Future<void> initialize() async {
    await SpeechToTextGoogleDialog();
}
  @override
  void initState() {
    super.initState();
    if (userQuestion == null) {
      userQuestion = 'I am feeling ${widget.feeling}';
      _controller = AnimationController(vsync: this);
      openAI = OpenAI.instance.build(
          token: api,
          baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
          enableLog: true);
      _generateAnswer();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(Icons.chat),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: [
        Image.network(
          "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.87,
          decoration: const BoxDecoration(

          ),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: ChatData.messages.length,
              itemBuilder: (context, index) {
                final Q = ChatData.messages[index];
                final A = ChatData.answers[index];
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChatBubble(text: Q.userQuestion!, isUser1: false),
                      const SizedBox(height: 10),
                      ChatBubble(
                          text: A.generatedAnswer!, isUser1: true)
                    ]);
              }),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: TextFormField(
            controller: _textEditingController,
            decoration: InputDecoration(
              iconColor: Colors.black,
              prefixIcon: const Icon(Icons.photo_camera),
              suffixIcon: IconButton(onPressed: () async {
                if (!isServiceAvailable){
                  await SpeechToTextGoogleDialog.getInstance().showGoogleDialog(onTextReceived: (data)   async {
                    setState(()  {
                      userQuestion=data.toString();
                      print(userQuestion);
                    });
                    await  _generateAnswer();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Service is not available'),
                   // backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height - 100,
                      left: 16,
                      right: 16,
                    ),
                  ));
                }
              }, icon:
              Icon(loading || _isRecording ? Icons.stop_circle_outlined : Icons
                  .mic)
              ),
              hintText: loading ? "Generating" : _isRecording
                  ? "Listening"
                  : 'Type message..',
              // hintStyle: ,
              // Adjust the padding as needed
            ),
            onFieldSubmitted: (value) async {
              if (value.isNotEmpty && value != userQuestion) {
                setState(() {
                  userQuestion = value;
                  loading = true;
                });
                _textEditingController.text = '';
                await _generateAnswer();
               // chatData.addChatMessage(value, generatedAnswer!);
              }
              setState(() {
                //userQuestion = null;
              });
            },
          ),
        ),
      ]),
    );
  }

}
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _lastWords = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }
//
//   /// This has to happen only once per app
//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {
//       _speechEnabled=true;
//     });
//   }
//
//   /// Each time to start a speech recognition session
//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {});
//     print('listening');
//
//   }
//
//   /// Manually stop the active speech recognition session
//   /// Note that there are also timeouts that each platform enforces
//   /// and the SpeechToText plugin supports setting timeouts on the
//   /// listen method.
//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }
//
//   /// This is the callback that the SpeechToText plugin calls when
//   /// the platform returns recognized words.
//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       _lastWords = result.recognizedWords;
//       print(_lastWords);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Text(
//                 'Recognized words:',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   // If listening is active show the recognized words
//                   _speechToText.isListening
//                       ? '$_lastWords'
//                   // If listening isn't active but could be tell the user
//                   // how to start it, otherwise indicate that speech
//                   // recognition is not yet ready or not supported on
//                   // the target device
//                       : _speechEnabled
//                       ? 'Tap the microphone to start listening...'
//                       : 'Speech not available',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//         // If not yet listening for speech start, otherwise stop
//         _speechToText.isNotListening ? _startListening : _stopListening,
//         tooltip: 'Listen',
//         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//       ),
//     );
//   }
// }