import 'package:flutter/material.dart';
import 'package:dingo_matchcard/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dingo Card Matching Game',
      theme: ThemeData(
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dingo Card Matching Game',
        home:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
              title: Text('Dingo Card Matching Game'),
            ),
            body: Center(
              child:Column(
                children: <Widget>[
                  const SizedBox(height:30),
                  RaisedButton(onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyGame())
                    );
                  },
                    child: Text('Let The Games Begin!', style:Theme.of(context).textTheme.headline6)),
                    ],
                  ),
            ),
    )
    );
  }
}
