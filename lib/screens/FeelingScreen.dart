import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/Providers/Provider_home.dart';
import 'package:mental_health/screens/therapistInfo.dart';
import 'package:provider/provider.dart';

import '../Components/CustomTextStyle.dart';
import 'Assesment/assesment.dart';
import 'Doctor.dart';
import 'Journal.dart';

class FeelingScreen extends StatefulWidget {
  final String id;

  const FeelingScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<FeelingScreen> createState() => _FeelingScreenState();
}

class _FeelingScreenState extends State<FeelingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  DateTime? selectedDate;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                ),
                fit: BoxFit.cover)),
        height: he,
        width: we,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Stack(children: [
                    ListTile(
                      title: const Text(
                        "You are feeling,",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text(
                        widget.id,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      //add emoji from previois screen
                    ),
                    const Positioned(
                        top: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            'https://source.unsplash.com/random',
                          ),
                        ))
                  ]),
                ),
                buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(context) {
    var he = MediaQuery.of(context).size.height;
    var we = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Journal()),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.orange,
                      ),
                      child: const Center(
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text("Journal"),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Assessment()));
                        },
                        child: Container(
                          width: we,
                          height: 60,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.lightGreenAccent),
                          child: const ListTile(
                            leading: Icon(Icons.menu_book),
                            title: Text("Get Assessed"),
                          ),
                        )))
              ],
            )),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFFECECE),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Recommended Today',
                    style: TextStyle(
                      color: Color(0xFF573926),
                      fontSize: 22,
                      fontFamily: 'Epilogue',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Opacity(
                    opacity: 0.90,
                    child: Text(
                      'How to be happy without fearing what is to come next, near-sight anxiety.',
                      style: TextStyle(
                        color: Color(0xFF573926),
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListTile(
                    title: const Text(
                      "Book Your Slot Now",
                      style: CustomTextStyle.medium,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final provider =
                            Provider.of<FirstProvider>(context, listen: false);
                        selectedDate = await provider.selectedDate(context);
                        setState(() {});
                      },
                      icon: const Icon(Icons.date_range),
                      color: Colors.blue,
                    ),
                    subtitle: selectedDate == null
                        ? const Text(
                            "Choose date",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                                fontSize: 15),
                          )
                        : Text(
                            "Booked: ${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.green,
                                fontSize: 15),
                          ),
                  ),
                  const SizedBox(height: 15),
                ]),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 84,
          decoration: ShapeDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 0.50,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFFFAFAFA),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                            '“Happiness is not the absence of problems, its the ability to deal with them.”'),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      // displayFullTextOnTapPause: true,
                      // stopPauseOnTapAnywhere: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: 130,
        //   decoration: ShapeDecoration(
        //     color: Color(0xFFFFEBEB),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           Text(
        //             'Talk to someone',
        //             style: TextStyle(
        //               color: Color(0xFF573926),
        //               fontSize: 22,
        //               fontFamily: 'Epilogue',
        //               fontWeight: FontWeight.w800,
        //             ),
        //           ),
        //           Opacity(
        //             opacity: 0.90,
        //             child: Text(
        //               'Share your thoughts with a certified therapist, friend or a chat bot',
        //               style: TextStyle(
        //                 color: Color(0xFF573926),
        //                 fontSize: 14,
        //                 fontFamily: 'Rubik',
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //           ),
        //           Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Text(
        //                   'Know more',
        //                   style: TextStyle(
        //                     color: Color(0xFF573926),
        //                     fontSize: 16,
        //                     fontFamily: 'Epilogue',
        //                     fontWeight: FontWeight.w700,
        //                   ),
        //                 ),
        //                 Icon(Icons.arrow_forward_sharp)
        //               ]),
        //         ]),
        //   ),
        // ),

        SizedBox(width: we, height: 270, child: const DoctorsList()),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                context: context,
                builder: (context) => CustomBottomSheet(
                      selectedDate: selectedDate,
                    ));
          },
          child: const Text("My appointments"),
        )
      ],
    );
  }
}
