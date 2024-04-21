import 'dart:io';
import 'package:flutter/material.dart';


class PreviewMemory extends StatefulWidget {
  const PreviewMemory({
    Key? key,
    required this.url,
    required this.title,
    required this.description
  }) : super(key: key);

  final String url;
  final String title;
  final String description;

  @override
  State<PreviewMemory> createState() => _PreviewMemoryState();
}

class _PreviewMemoryState extends State<PreviewMemory> {
  // final storage = FirebaseStorage.instance;
  // final _user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.url,
                      width: 250,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  // Text(picture.name)
                ]
            ),
          )
        ),
      )
    );
  }
}