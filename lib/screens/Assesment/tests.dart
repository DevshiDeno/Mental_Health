import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../Services/assessmentInfo.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: we,
        height: he,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1647BF), Color(0xFFCC3DE5), Color(0xFF933DC8)],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 2)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 70, left: 30),
                child: const Text(
                  "Explore",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: he * 0.007,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 32),
                child: const Row(
                  children: [
                    Text(
                      "Assesments",
                      style: TextStyle(color: Colors.white70, fontSize: 20.0),
                    ),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                height: 500,
                child: Swiper(
                  itemCount: behaviour.length,
                  layout: SwiperLayout.STACK,
                  itemWidth: we - 2 * 64,
                  itemBuilder: (context, int index) {
                    return Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: he * 0.1,
                            ),
                            Container(
                              width:400,
                              height:400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                image: DecorationImage(
                                  image: NetworkImage(behaviour[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: he * 0.06,
                                    ),
                                    Text(
                                      behaviour[index].name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Text(
                                      "Assessment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      height: he * 0.1,
                                    ),
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Let's get started",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                          fontWeight: FontWeight.w900),
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt_outlined,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Hero(tag: behaviour[index].position, child: Expanded(
                        //   child: Image.asset(behaviour[index].iconImage),
                        // ))
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
