import 'dart:ui';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health/Components/CustomTextStyle.dart';
import 'package:mental_health/Providers/Provider_home.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../Model/Journal.dart';
import 'SavedNotes.dart';
import 'chatAi.dart';
import 'package:intl/intl.dart';

class Journal extends StatefulWidget {
  const Journal({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> with TickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _animationController;
  late AnimationController _fabController;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  bool isBlurred = false;
  List<String> notes = [];
  String? inputText;
  Color _color = Colors.white;
  bool isServiceAvailable = false;
  String? result;

  @override
  void initState() {
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  void _toggleBlur() {
    setState(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
      isBlurred = !isBlurred;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;
    final journalDetails = Provider.of<NoteProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(
            Icons.edit,
            color: Colors.green,
          ),
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
        body: Container(
          width: we,
          height: he,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isBlurred)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: we,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TableCalendar(
                          pageAnimationEnabled: true,
                          headerVisible: false,
                          firstDay: DateTime.now(),
                          lastDay: DateTime(2030),
                          focusedDay: _focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            }
                          },
                          calendarFormat: CalendarFormat.week,
                          availableCalendarFormats: const {
                            CalendarFormat.week: 'Week'
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ),
                  // const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: _color,
                              child: GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  double swipeProgress = details.primaryDelta! /
                                      context.size!.width;
                                  setState(() {
                                    _color = Color.lerp(
                                      Colors.lightGreenAccent,
                                      Colors.transparent,
                                      swipeProgress.abs(),
                                    )!;
                                  });
                                },
                                onHorizontalDragEnd: (details) async {
                                  if (details.primaryVelocity! > 0) {
                                    print('swiped');
                                    if (!isServiceAvailable) {
                                      await SpeechToTextGoogleDialog
                                              .getInstance()
                                          .showGoogleDialog(
                                              onTextReceived: (data) {
                                        setState(() {
                                          inputText = data.toString();
                                        });
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                            'Service is not available'),
                                        // backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              100,
                                          left: 16,
                                          right: 16,
                                        ),
                                      ));
                                    }
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: we * 0.1,
                                      child: IconButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text("Swipe to record"),
                                                duration: Duration(
                                                    seconds:
                                                        2), // Adjust the duration as needed
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.mic)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: TextField(
                                        controller: _textEditingController,
                                        decoration: const InputDecoration(
                                          labelText: "Write Your Mind",
                                          border: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        onChanged: (value) {
                                          setState(() {
                                            inputText = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (inputText != null &&
                      inputText!.isNotEmpty &&
                      !journalDetails.containsNote(inputText!, _focusedDay))
                    Center(
                      child: SizedBox(
                        width: 75,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (inputText!.isNotEmpty &&
                                !journalDetails.containsNote(
                                    inputText!, _focusedDay)) {
                              journalDetails.addNote(inputText!, _focusedDay);
                              showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                      message: "Notes Saved"),
                                  dismissType: DismissType.onSwipe,
                                  dismissDirection: [
                                    DismissDirection.endToStart
                                  ], onAnimationControllerInit: (controller) {
                                if (!_fabController.isAnimating) {
                                  _fabController = controller;
                                }
                              });
                              setState(() {
                                print(inputText);
                                inputText = null;
                                _textEditingController.text = '';
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            // Set button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Center(child: Text('Save')),
                        ),
                      ),
                    ),
                  Note.noteList.isEmpty
                      ? Center(
                          child: Text(
                          "No saved Journals",
                          style: GoogleFonts.pacifico(
                            color: Colors.black,
                            letterSpacing: 3,
                          ),
                        ))
                      : Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Colors.white)
                              ]),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            itemCount: Note.noteList.length,
                            itemBuilder: (context, index) {
                              final journal = Note.noteList[index];
                              DateTime? journalDate = journal
                                  .date; // Replace this with your actual DateTime object
                              String formattedDate = DateFormat('dd MMMM yyyy')
                                  .format(journalDate!);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.white)
                                      ]),
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(journal.written_notes!,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      trailing: Text(
                                        formattedDate,
                                        style: GoogleFonts.pacifico(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                  if (isBlurred)
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Chat with Ai",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.settings,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                setState(() {
                  isBlurred = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Chat(
                              feeling: widget.id,
                            )));
              },
            ),
            Bubble(
              title: "Saved Notes",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.settings,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                setState(() {
                  isBlurred = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SavedNotes()));
              },
            ),
          ],
          animation: _animation,
          onPress: () {
            _toggleBlur();
          },
          iconColor: Colors.blue,
          iconData: Icons.ac_unit,
          backGroundColor: Colors.white,
        ));
  }
}
