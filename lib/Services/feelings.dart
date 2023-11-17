import 'package:flutter/material.dart';

class Feelings {
  final int id;
  final String title;
  Color? color;
  final String videoPath;

  Feelings({ required this.id,required this.videoPath, required this.title, required this.color});

  static final List<Feelings> feelings = [
    Feelings(title: "Angry", color: Colors.green, videoPath: "Videos/heg.mp4", id: 1),
    Feelings(title: "Happy", color: Colors.black12, videoPath: "Videos/bliss.mp4",id: 2),
    Feelings(title: "Hungry", color: Colors.yellow, videoPath: 'Videos/hungry.mp4',id:3),
    Feelings(title: "Funny", color: Colors.deepOrange, videoPath: "Videos/meme.mp4",id:4),
    Feelings(title: "Sick", color: Colors.white, videoPath: "Videos/sick.mp4",id:5),
    // Feelings(title: "annoyed", color: Colors.red, imagePath: 'images/annoyed.jpg',id:6),
    // Feelings(title: "sick", color: Colors.grey, imagePath: 'images/sick.jpg',id:7),
  ];
}
