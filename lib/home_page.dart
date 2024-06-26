import 'package:flutter/material.dart';
import './list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './widgets/add_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import './widgets/delete_data_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final fireStore = FirebaseFirestore.instance;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You have been signed out'))
    );
  }

  void deleteAllDataDialog() async {
    showDialog(
      context: context,
      builder: (context) => DeleteDataDialog(),
    );
  }

  // void deleteAccount() async {
  //   try {
  //     await FirebaseStorage.instance.ref(user.uid).listAll().then((value) {
  //       value.items.forEach((element) {
  //         FirebaseStorage.instance.ref(element.fullPath).delete();
  //       });
  //     });
  //     displayMessage("Images deleted.");
  //     var snapshots = await fireStore.collection(user.uid).get();
  //     for (var doc in snapshots.docs) {
  //       await doc.reference.delete();
  //     }
  //     displayMessage("Bucket list deleted.");
  //     await user.delete();
  //     displayMessage("Account deleted.");
  //   } on FirebaseException catch (e) {
  //     displayMessage("Error occurred: ${e.code}");
  //   } on Exception catch (e) {
  //     displayMessage("Error occurred: UNKNOWN");
  //   }
  // }
  //
  // void displayMessage(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(message))
  //   );
  // }

  Future getCompletedCount() async {
    int count = await fireStore.collection(user.uid).where('type', isEqualTo: "image" ).snapshots().length;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
            size: 30
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'delete-account',
                      child: const Text(
                        'Delete all data',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      onTap: deleteAllDataDialog
                    ),
                    PopupMenuItem(
                      value: 'log-out',
                      child: const Text(
                        'Log out',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      onTap: signUserOut,
                    ),
                  ];
                },
              ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
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
                              child: StreamBuilder<QuerySnapshot>(
                                stream: fireStore.collection(user.uid).where('type', isEqualTo: "image" ).snapshots(), // async work
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting: return Text('Loading....');
                                    default:
                                      if (snapshot.hasError)
                                        return Text('...');
                                      else
                                        return  Text(
                                          "${snapshot.data!.docs.length}",
                                          style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          )
                                        );
                                  }
                                },
                              )
                            )
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddTaskAlertDialog();
                                  },
                                );
                              },
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
            Expanded(
                flex: 1,
                child: Tasks()
            )
          ],
        ),
      ),
    );
  }
}
