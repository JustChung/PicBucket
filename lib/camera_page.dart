import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({
    Key? key,
    required this.picture,
    required this.taskId,
  }) : super(key: key);

  final XFile picture;
  final String taskId;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  // final storage = FirebaseStorage.instance;
  final _user = FirebaseAuth.instance.currentUser!;

  Future uploadPicture() async {
    final file = File(widget.picture.path);

    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

    // Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef
        .child("${_user.uid}/${widget.picture.name}")
        .putFile(file, metadata);
    uploadTask.then((res) async {
      String url = await res.ref.getDownloadURL();
      updateTask(url);
    }).catchError((onError) {
      print(onError);
    });
  }

  Future updateTask(url) async {
    await FirebaseFirestore.instance.collection(_user.uid).doc(widget.taskId).update(
      {'type': 'image',
        'url': url,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                File(widget.picture.path),
                fit: BoxFit.cover,
                width: 250,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              child: Text("Save"),
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                side: BorderSide(
                  color: Colors.green,
                ),
              ),
              onPressed: uploadPicture,
            ),
            // Text(picture.name)
          ]
        ),
      ),
    );
  }
}

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras, required this.taskId}) : super(key: key);

  final List<CameraDescription>? cameras;
  final String taskId;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPage(
                picture: picture,
                taskId: widget.taskId,
              )));
    } on CameraException catch (e) {
      debugPrint('Error occurred while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(children: [
            (_cameraController.value.isInitialized)
                ? CameraPreview(_cameraController)
                : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.black),
                  child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                              _isRearCameraSelected
                                  ? CupertinoIcons.switch_camera
                                  : CupertinoIcons.switch_camera_solid,
                              color: Colors.white),
                          onPressed: () {
                            setState(
                                    () => _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                          },
                        )),
                    Expanded(
                        child: IconButton(
                          onPressed: takePicture,
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.white),
                        )),
                    Expanded(
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.cancel, color: Colors.red),
                        )),
                  ]),
                )),
          ]),
        ));
  }
}