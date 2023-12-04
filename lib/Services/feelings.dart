import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Feelings {
  final int id;
  final String title;
  Color? color;
  final CachedNetworkImage image;

  Feelings( { required this.id, required this.title,required this.image,required this.color});

  static final List<Feelings> feelings = [
    Feelings(title: "Angry", color: Colors.green, id: 1, image: CachedNetworkImage(imageUrl: 'https://media.giphy.com/media/ykaNntbZ3hfsWotKmA/giphy.gif')),
    Feelings(title: "Happy", color: Colors.black12, id: 2, image: CachedNetworkImage(imageUrl: 'https://media.giphy.com/media/Rpm7zINbHhG3YsXi7g/giphy.gif')),
    Feelings(title: "Hungry", color: Colors.yellow,id:3, image: CachedNetworkImage(imageUrl: 'https://media.giphy.com/media/vXufyZ1LxgV6iQ4jfO/giphy.gif',)),
    Feelings(title: "Funny", color: Colors.deepOrange, id:4, image: CachedNetworkImage(imageUrl: '')),
    Feelings(title: "Sick", color: Colors.white,id:5, image: CachedNetworkImage(imageUrl: '')),
    Feelings(title: "annoyed", color: Colors.red,id:6, image: CachedNetworkImage(imageUrl: '')),
    Feelings(title: "sick", color: Colors.grey,id:7, image: CachedNetworkImage(imageUrl: '')),
  ];
}
