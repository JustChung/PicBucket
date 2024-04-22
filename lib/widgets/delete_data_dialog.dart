import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DeleteDataDialog extends StatefulWidget {
  const DeleteDataDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDataDialog> createState() => _DeleteDataDialogState();
}

class _DeleteDataDialogState extends State<DeleteDataDialog> {
  final user = FirebaseAuth.instance.currentUser!;
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Delete all user data',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: <Widget>[
              const Text(
                'Are you sure?',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Text(
                "All data will PERMANENTLY be deleted.",
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          // style: ElevatedButton.styleFrom(
          //   primary: Colors.grey,
          // ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _deleteAllData();
            Navigator.of(context, rootNavigator: true).pop();
          },
          // style: ElevatedButton.styleFrom(
          //   primary: Colors.black,
          // ),
          child: const Text('Delete'),
        ),
      ],
    );
  }


  void _deleteAllData() async {
    try {
      await FirebaseStorage.instance.ref(user.uid).listAll().then((value) {
        value.items.forEach((element) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        });
      });
      displayMessage("Images deleted.");
      var snapshots = await fireStore.collection(user.uid).get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      displayMessage("Bucket list deleted.");
    } on FirebaseException catch (e) {
      displayMessage("Error occurred: ${e.code}");
    } on Exception catch (e) {
      displayMessage("Error occurred: UNKNOWN");
    }
  }

  void displayMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}


// final collection = FirebaseFirestore.instance.collection('collection');
// collection
//     .doc('some_id') // <-- Doc ID to be deleted.
// .delete() // <-- Delete
//     .then((_) => print('Deleted'))
// .catchError((error) => print('Delete failed: $error'));