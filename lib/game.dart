import 'package:flutter/material.dart';
import 'package:dingo_matchcard/main.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

int level = 8;

class MyGame extends StatefulWidget {
  final int size;

  const MyGame({Key key, this.size = 8}) : super(key: key);
  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List <GlobalKey<FlipCardState>> cardStateKeys= [];
  List <bool> cardFlips =[];
  List<String> data=[];
  List<String> matchPictures() {
    return[
      'assets/AC.png',
      'assets/AC.png',
      'assets/AD.png',
      'assets/AD.png',
      'assets/AH.png',
      'assets/AH.png',
      'assets/AS.png',
      'assets/AS.png',
      'assets/JC.png',
      'assets/JC.png',
      'assets/JD.png',
      'assets/JD.png',
      'assets/JH.png',
      'assets/JH.png',
      'assets/JS.png',
      'assets/JS.png',
      'assets/KC.png',
      'assets/KC.png',
      'assets/KD.png',
      'assets/KD.png',
      'assets/KH.png',
      'assets/KH.png',
      'assets/KS.png',
      'assets/KS.png',
      'assets/QC.png',
      'assets/QC.png',
      'assets/QD.png',
      'assets/QD.png',
      'assets/QH.png',
      'assets/QH.png',
      'assets/QS.png',
      'assets/QS.png',
      'assets/red_back.png',
      'assets/red_back.png',
      'assets/yellow_back.png',
      'assets/yellow_back.png',
      'assets/purple_back.png',
      'assets/purple_back.png',
      'assets/green_back.png',
      'assets/green_back.png',
    ];
  }

  int previousNumber =-1;
  bool flip =false;

  int time = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();

    List sourceArray = matchPictures();

    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(sourceArray[i]);
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(sourceArray[i]);
    }
    startTimer();
    data.shuffle();

  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  Widget getItem(int index){
    return Container(
        margin: EdgeInsets.all(4.0),
          child: Image.asset(data[index]),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousNumber = index;
                        } else {
                          flip = false;
                          if (previousNumber != index) {
                            if (data[previousNumber] != data[index]) {
                              cardStateKeys[previousNumber]
                                  .currentState
                                  .toggleCard();
                              previousNumber = index;
                            } else {
                              cardFlips[previousNumber] = false;
                              cardFlips[index] = false;
                              print(cardFlips);

                              if (cardFlips.every((t) => t == false)) {
                                print("Won");
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.teal.withOpacity(0.3),
                      ),
                      back: getItem(index),
                  ),
                      itemCount: data.length,
                    ),
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Congratulations! You Won!"),
        content: Text(
          "Time: $time",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyGame(
                    size: level,
                  ),
                ),
              );
              level *= 2;
            },
            child: Text("Next Level"),
            textColor: Colors.green,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                  ),
                ),
              );
            },
            child: Text("Exit"),
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}