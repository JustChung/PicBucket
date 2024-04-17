import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/delete_dialog.dart';
import 'package:camera/camera.dart';
import 'camera_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection(user.uid).where('type', isEqualTo: "task" ).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No tasks to display');
          } else {
            return ListView(
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
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            // TEST
                            backgroundColor: Colors.grey[600],
                          ),
                        ),
                      ]
                    ),
                    title: Text(data['taskTitle']),
                    subtitle: Text(data['taskDesc']),
                    isThreeLine: true,
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text(
                              'Complete',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: () async {
                                await availableCameras().then((value) => Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value, taskId: data['id'],))));
                              },
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text(
                              'Delete',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: (){
                              String taskId = (data['id']);
                              String taskName = (data['taskTitle']);
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(
                                  context: context,
                                  builder: (context) => DeleteTaskDialog(taskId: taskId, taskName:taskName),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                    dense: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}