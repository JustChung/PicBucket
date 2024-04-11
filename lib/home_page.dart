import 'package:flutter/material.dart';
import './list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For checkbox
  bool isChecked = false;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            size: 30
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right:10.0),
              child:
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
              },
            )
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Bucket list",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Expanded (
              flex: 25,
              child:
                Container(
                  margin: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff31a078),
                          Color(0xff31a05f),
                        ],
                      ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding (
                            padding: const EdgeInsets.only(top: 20.0, left: 25.0),
                            child: Text(
                                "Your total bullets completed",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                )
                            ),
                          )
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding (
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "25",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    )
                                  ),
                                )
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () => print('tapped!'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    "Add more",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.green,
                                    )
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                ),
            ),
            Expanded(
                flex: 68,
                child: Tasks()
            )
          ],
        ),
      ),
    );
  }
}
