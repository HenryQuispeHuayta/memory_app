import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int time = 0;
  Timer? timer;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage('assets/imgs/0.jpg')),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tiempo $time',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) => FlipCard(
                    onFlip: () {},
                    direction: FlipDirection.HORIZONTAL,
                    flipOnTouch: true,
                    front: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.deepOrange.withOpacity(0.3),
                    ),
                    back: Container(
                      margin: EdgeInsets.all(4.0),
                      color: Colors.deepOrange,
                      child: Center(
                        child: Text(
                          '$index',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  contador() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contador();
  }
}
