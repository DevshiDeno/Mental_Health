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
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )
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
                Container(
                  color: Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.39,
                    child: ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey,
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
  }
}
