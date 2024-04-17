import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key, required this.title});

  final String title;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
              Color(0xff31a078),
              Color(0xff31a05f),
             ],
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child:
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                Column(
                  children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, right:20.0, left: 20.0),
                    child:
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 25,
                          child:
                          FittedBox(
                            fit: BoxFit.cover,
                            child:
                            Container(
                                margin: const EdgeInsets.only(right:10.0),
                                decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(2.0),
                                  color: Colors.grey[300],
                                ),
                                child:
                                Icon(Icons.account_circle_outlined)
                            ),
                          )
                        ),
                        Expanded(
                          flex: 75,
                          child:
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom:5.0),
                                child:
                                Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                    Text(
                                      "Header",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    )
                                  )
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child:
                                  Text("Description.")
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Text("8m ago")
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, right:20.0, left: 20.0),
                    child:
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 25,
                            child:
                            FittedBox(
                              fit: BoxFit.cover,
                              child:
                              Container(
                                  margin: const EdgeInsets.only(right:10.0),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(2.0),
                                    color: Colors.grey[300],
                                  ),
                                  child:
                                  Icon(Icons.account_circle_outlined)
                              ),
                            )
                        ),
                        Expanded(
                          flex: 75,
                          child:
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom:5.0),
                                child:
                                Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                    Text(
                                        "Header",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        )
                                    )
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child:
                                  Text("Description.")
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Text("8m ago")
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, right:20.0, left: 20.0),
                    child:
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 25,
                            child:
                            FittedBox(
                              fit: BoxFit.cover,
                              child:
                              Container(
                                  margin: const EdgeInsets.only(right:10.0),
                                  decoration: new BoxDecoration(
                                    borderRadius: new BorderRadius.circular(2.0),
                                    color: Colors.grey[300],
                                  ),
                                  child:
                                  Icon(Icons.account_circle_outlined)
                              ),
                            )
                        ),
                        Expanded(
                          flex: 75,
                          child:
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom:5.0),
                                child:
                                Align(
                                    alignment: Alignment.topLeft,
                                    child:
                                    Text(
                                        "Header",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        )
                                    )
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child:
                                  Text("Description.")
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child:
                            Text("8m ago")
                        ),
                      ],
                    ),
                  ),
                  ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
