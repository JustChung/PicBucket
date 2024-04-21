import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:bucket/preview_memory.dart';

class MemoriesPage extends StatefulWidget {
  const MemoriesPage({super.key, required this.title});

  final String title;

  @override
  State<MemoriesPage> createState() => _MemoriesPageState();
}

class _MemoriesPageState extends State<MemoriesPage> {

  final fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  void openMemory(String url, String title, String description) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PreviewMemory(
              url: url,
              title: title,
              description: description,
            )
        )
    );
  }

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
        child: StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection(user.uid).where('type', isEqualTo: "image" ).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text('No memories to display.');
            } else {
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 5), // shadow direction: bottom right
                        ),
                      ],
                    ),
                    child: GridTile(
                      // header: Text(data['taskTitle']),
                      child: Material(
                        // needed
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => openMemory(data['url'], data['taskTitle'], data['taskDesc']),
                          child: Image.network(
                            data['url'],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                      // footer: Text(data['taskDesc']),
                      // trailing: PopupMenuButton(
                      //   itemBuilder: (context) {
                      //     return [
                      //       PopupMenuItem(
                      //         value: 'edit',
                      //         child: const Text(
                      //           'edit',
                      //           style: TextStyle(fontSize: 13.0),
                      //         ),
                      //         onTap: () => {},
                      //       ),
                      //       PopupMenuItem(
                      //         value: 'delete',
                      //         child: const Text(
                      //           'Delete',
                      //           style: TextStyle(fontSize: 13.0),
                      //         ),
                      //         onTap: () => {}
                      //       ),
                      //     ];
                      //   },
                      // ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
        // GridView.count(
        //   primary: false,
        //   padding: const EdgeInsets.all(20),
        //   crossAxisSpacing: 10,
        //   mainAxisSpacing: 10,
        //   crossAxisCount: 2,
        //   children: <Widget>[
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text("2015"),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text('2016'),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text('2017'),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text('2018'),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text('2019'),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(8),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(20),
        //         color: Colors.grey[200],
        //       ),
        //       child: const Text('2020'),
        //     ),
        //   ],
        // )
      ),
    );
  }
}
