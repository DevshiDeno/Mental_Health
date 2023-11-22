import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';


class ChatBubble extends StatefulWidget {
  final String text;
  final bool isUser1;

  const ChatBubble({super.key, required this.text, required this.isUser1});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> with SingleTickerProviderStateMixin {
   late AnimationController _controller;

   @override
   void initState() {
     super.initState();
     _controller = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 100),
     );
     _controller.addStatusListener((status) {
       if (status == AnimationStatus.completed) {
         _controller.stop();
       }
     });
     _controller.forward();
   }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment:
            widget.isUser1 ? Alignment.centerLeft : Alignment.centerRight,
        child:
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     CircleAvatar(
            //       backgroundImage: isUser1
            //           ? AssetImage('assets/images/doctor_3.png')
            //           : NetworkImage(
            //           "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80") as ImageProvider<
            //           Object>,
            //     ),
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.isUser1 ? Colors.cyan[900] : Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.isUser1 ? 0 : 18),
                topRight: Radius.circular(widget.isUser1 ? 18 : 0),
                bottomLeft: const Radius.circular(18),
                bottomRight: const Radius.circular(18),
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: ( context, child) {
                return DefaultTextStyle(
                    style: const TextStyle(),
                    child: AnimatedTextKit(
                      animatedTexts: [TyperAnimatedText(widget.text)],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                    ));
              },
              // child: Text(
              //   widget.text,
              //   style: TextStyle(color: Colors.white, fontSize: 14),
              // ),
            ),
          ),
        )

        //   ],
        // ),
        );
  }
}
