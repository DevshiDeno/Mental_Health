import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Components/MessageContainer.dart';
import '../Services/feelings.dart';
import '../Services/qoutes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FeelingScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DateTime? selectedDate;
  String? _quote;
  DateTime? _time;
  late AnimationController _controller;
bool failed=false;
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
        failed=!failed;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )
      ..repeat();
    fetchQuote();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery
        .of(context)
        .size
        .width;
    var he = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.red.withOpacity(0.5),
          elevation: 0,
          title: Center(
              child: Text(
                "COMPANION",
                style: GoogleFonts.pacifico(
                    color: Colors.white, letterSpacing: 3, fontSize: 20),
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
                  size: 25,
                  Icons.notifications,
                  color: Colors.black,
                ))
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: we,
            height: he,
            child: CachedNetworkImage(
              imageUrl:
              'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExazc0ZjNqNm1sdXN4MGZ5eXplNmZzaW9rM201dTdyMGtid3F6eG50aCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/s9cu1TZU37KY8/giphy.gif',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: ( context, Widget? child) {
                      return Container(
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 80,
                        child: CustomPaint(
                          painter: WaterDropletsPainter(_controller.value),
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
                      );
                    },
                  ),
                ),
                // SizedBox(height: 15),
                buildSizedBox(context),
                const SizedBox(height: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: const Color.fromRGBO(255, 255, 255, 0.5),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          left: 5,
                          child: SvgPicture.asset(
                            'images/leftquote.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                           Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '$_quote',
                                style: GoogleFonts.pacifico(
                                  color: Colors.black,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),

                        Positioned(
                          bottom: 15,
                          right: 5,
                          child: SvgPicture.asset(
                            'images/rightquote.svg',
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildSizedBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: Feelings.feelings.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final feeling = Feelings.feelings[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FeelingScreen(
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
                                    child: feeling.image,
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
        const SizedBox(height: 10),
      ],
    );
  }
}
