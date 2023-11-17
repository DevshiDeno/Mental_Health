import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import '../Services/feelings.dart';
import '../Services/qoutes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FeelingScreen.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("Videos/heg.mp4")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DateTime? selectedDate;
  String? _quote;

  Future<void> fetchQuote() async {
    try {
      String quote = await fetchRandomQuote();
      setState(() {
        _quote = quote;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _quote = 'Failed to fetch quote';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }



  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          elevation: 0,
          title: Center(
              child: Text(
            "COMPANION",
            style: GoogleFonts.pacifico(
              color: Colors.white,
              letterSpacing: 3,
              fontSize: 20
            ),
          )),
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
                  size:25,
                  Icons.notifications,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: NetworkImage(
                'https://source.unsplash.com/random',
              ),
              fit: BoxFit.fill),
          gradient: const LinearGradient(
              colors: [Color(0xFF1647BF), Color(0xFFCC3DE5), Color(0xFF933DC8)],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 2)),
          //  borderRadius: BorderRadius.circular(32),
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
        width: we,
        height: he,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: he * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const ShapeDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.5),
                    // Adjust alpha value as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        "Good Afternoon,",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text(
                        "Devshi !",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 15),
              buildSizedBox(context),
              //const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 12,
                        left: 5,
                        child: SvgPicture.asset(
                          'images/leftquote.svg',
                          color: Colors.deepOrange,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '$_quote',
                              style: GoogleFonts.pacifico(
                                color: Colors.black,
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 5,
                        child: SvgPicture.asset(
                          'images/rightquote.svg',
                          color: Colors.deepOrange,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSizedBox(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedContainer(
            width: 335,
            height: 411,
            decoration: ShapeDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.5),
              // Adjust alpha value as needed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            duration: const Duration(seconds: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        'How are you feeling today?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF782D03),
                          fontSize: 36,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: Feelings.feelings.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final feeling = Feelings.feelings[index];
                        return GestureDetector(
                          onTap: () {
                            print("Tapped");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeelingScreen(
                                          id: Feelings.feelings[index].title,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: Text(
                                      feeling.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF913704),
                                        fontSize: 24,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: SizedBox(
                                      width: 300,
                                      height: 200,
                                      // color: feeling.color,
                                      child: Image.network(
                                        "https://images.unsplash.com/photo-1583511655826-05700d52f4d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
