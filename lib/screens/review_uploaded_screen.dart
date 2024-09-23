import 'package:flutter/material.dart';

class ReviewUploadedScreen extends StatefulWidget {
  const ReviewUploadedScreen({super.key});

  @override
  State<ReviewUploadedScreen> createState() => _ReviewUploadedScreenState();
}

class _ReviewUploadedScreenState extends State<ReviewUploadedScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //fetch data from the particular doc which was just uploaded right now.****************
      //Dont just show review has been uploaded**********************************************
      body:
          Center(
              child: Text('Review Uploaded')),

    );
  }
}
