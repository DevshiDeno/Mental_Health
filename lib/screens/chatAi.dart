import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/Model/Question.dart';
import 'package:mental_health/Providers/Provider_home.dart';
import 'package:mental_health/Components/test.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.feeling});

  final String feeling;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  final TextEditingController _textEditingController = TextEditingController();

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
      chatData.addChatMessage(userQuestion!, generatedAnswer!);
    });
    print(generatedAnswer);
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
      ),
      body: Stack(children: [
        Image.network(
          "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.87,
          decoration: const BoxDecoration(

          ),
          child: ListView.builder(
            reverse: false,
              shrinkWrap: true,
              itemCount: ChatData.messages.length,
              itemBuilder: (context, index) {
                final QA = ChatData.messages[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  ChatBubble(text: QA.userQuestion!, isUser1: false),
                  SizedBox(height: 10),
                  // FutureBuilder(
                  //     future: Future.delayed(Duration(seconds: 3)),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return ChatBubble(text: '...', isUser1: true);
                  //       }
                  //       return ChatBubble(
                  //           text: QA.generatedAnswer!, isUser1: true);
                  //     }),
                ChatBubble(
                text: QA.generatedAnswer!, isUser1: true)

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
              suffixIcon: IconButton(onPressed: (){}, icon:
              Icon(loading ?Icons.stop_circle_outlined : Icons.mic)
              ),
              hintText: !loading ? "Type a message..." : 'Generating',
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
