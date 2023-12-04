import 'package:flutter/material.dart';
import '../Components/CustomTextStyle.dart';
import 'package:intl/intl.dart';

import '../Model/Journal.dart';

class SavedNotes extends StatelessWidget {
   const SavedNotes({Key? key,
   }) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.black,
              ),
            ),
          ),
          title: const Text('Notes',
          style:TextStyle(color:Colors.black)
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                ))
          ],
          backgroundColor: Colors.white,
        ),
        body: Note.noteList.isEmpty
            ? Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
              child: const Center(
                  child: Text(
                  "No saved Journals",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                )),
            )
            : Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Saved Notes",
                          style: CustomTextStyle.large,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView.builder(
                        itemCount:  Note.noteList.length,
                        itemBuilder: (context, index) {
                          final journal = Note.noteList[index];
                          DateTime? journalDate = journal.date; // Replace this with your actual DateTime object
                          String formattedDate = DateFormat('dd MMMM yyyy').format(journalDate!);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black38
                                    )
                                  ]
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 70,
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                    journal.written_notes!,
                                      style: const TextStyle(color: Colors.black)),
                                 trailing: Text(formattedDate),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ));
  }
}
