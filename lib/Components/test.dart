import 'package:flutter/material.dart';
import 'dart:math' as math; // Import the math library and provide an alias (e.g., math)
import 'MessageContainer.dart';


class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser1;

  const ChatBubble({super.key, required this.text, required this.isUser1});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser1 ? Alignment.centerLeft : Alignment.centerRight,
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
        child: CustomPaint(
         // painter: BubblePainter(bubbleColor: Colors.cyan[900]!, isUser1: isUser1),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUser1? Colors.cyan[900] : Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isUser1 ? 0 : 18),
                topRight: Radius.circular(isUser1 ? 18 : 0),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      )

      //   ],
      // ),
    );
  }
}

