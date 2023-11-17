import 'package:flutter/material.dart';
import 'package:mental_health/Components/CustomTextStyle.dart';
import '../Services/therapist.dart';

class CustomBottomSheet extends StatefulWidget {
  final DateTime? selectedDate;

  const CustomBottomSheet({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width*0.9,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            //shadowColor: Colors.black,
            onClosing: () {
              print("Bottom sheet closed");
            },
            builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white54, Colors.white70],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.5, 2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                              title: Text(
                                "Upcoming Session",
                              ),
                              subtitle: Text("7.00 -9.30",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Text("Join Now", style: CustomTextStyle.medium)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: ListView.builder(
                          itemCount: people.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(people[index].name),
                                    subtitle: Text(people[index].specialty),
                                    trailing: Text(people[index].contact),
                                  ),
                                  Center(
                                    child: Text(
                                        " ${widget.selectedDate?.day}/${widget.selectedDate?.month}/${widget.selectedDate?.year}",
                                        style: const TextStyle(fontSize: 16)),
                                  )
                                ],
                              ),
                            );
                          },
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
