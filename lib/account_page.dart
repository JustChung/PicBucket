import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.title});

  final String title;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

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
            Container(
              width: 130,
              child: Icon(Icons.account_circle_outlined, size: 130,),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200]),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child:
              Text(
                  "Bobby Davy",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
              child:
              ElevatedButton(
                  onPressed: () => print('tapped!'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // button's shape
                    ),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 25.0),
                              child:
                              Icon(Icons.account_box_rounded)
                          ),
                          Expanded(
                              child:
                              Text(
                                  "Edit profile",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )
                              )
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child:
                              Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        ],
                      )
                  )
              )
            ),
            Padding(
                padding: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
                child:
                ElevatedButton(
                    onPressed: () => print('tapped!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // button's shape
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 25.0),
                                child:
                                Icon(Icons.contact_page)
                            ),
                            Expanded(
                                child:
                                Text(
                                    "Friends",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )
                                )
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child:
                                Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          ],
                        )
                    )
                )
            ),
            Padding(
                padding: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
                child:
                ElevatedButton(
                    onPressed: () => print('tapped!'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // button's shape
                      ),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10.0, right: 25.0),
                                child:
                                Icon(Icons.settings_rounded)
                            ),
                            Expanded(
                                child:
                                Text(
                                    "Settings",
                                    style: TextStyle(
                                      fontSize: 15,
                                    )
                                )
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child:
                                Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            ),
                          ],
                        )
                    )
                )
            ),
          ],
        ),
      ),
    );
  }
}
