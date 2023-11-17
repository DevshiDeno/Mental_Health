import 'package:flutter/material.dart';
import 'package:mental_health/screens/Assesment/tests.dart';

import '../../Components/CustomTextStyle.dart';

class Assessment extends StatefulWidget {
  const Assessment({Key? key}) : super(key: key);

  @override
  State<Assessment> createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  DateTime? dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const  Color(0xFFCC3DE5),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80"),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ))
        ],
        backgroundColor: const  Color(0xFFCC3DE5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF1647BF),Color(0xFFCC3DE5),Color(0xFF933DC8)],
                begin:  FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.5, 2)
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.8,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Hi, Devshi", style: CustomTextStyle.large),
                  ),
                  subtitle: Text("Last assessment:  ${dateTime?.day}/${dateTime?.month}/${dateTime?.year}",
                      style: CustomTextStyle.medium),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Each assessment consists of a series of questions, which should be answered honestly and in one sitting. ",
                  style: CustomTextStyle.medium),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
                child: Center(
                  child:
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const Test() )
                        );
                      },
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ), child: const Text("GOT IT"),
                      ),
                ),
              ),
              const SizedBox(height:60),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black38.withOpacity(0.1),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("If you notice these symptoms in someone, let us know and we’ll anonymously try to help them. 🤍",
                      style: CustomTextStyle.medium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
