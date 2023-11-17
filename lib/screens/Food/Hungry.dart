import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  const Food({super.key});

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> with SingleTickerProviderStateMixin {
   AnimationController? _controller;
   TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 100),
    // );
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.stop();
      }
    });
    _controller?.forward();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _controller?.dispose();
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
                  child: const Stack(children: [
                    ListTile(
                      title: Text(
                        "You are feeling,",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: Text(
                        "Hungry",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      //add emoji from previois screen
                    ),
                    Positioned(
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
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.delivery_dining_rounded),
                      text: "ORDER ONLINE",
                    ),
                    Tab(
                      icon: Icon(Icons.food_bank_outlined),
                      text: "PREPARE A MEAL WITH RECIPE ONLINE",
                    )
                  ],
                ),
                SizedBox(
                  width: we,
                  height: he,
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        buildOrder(),
                        buildOrder()]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrder() => Container(

  );
}


