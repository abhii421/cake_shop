import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReviewUploadedScreen extends StatefulWidget {
  const ReviewUploadedScreen({super.key});

  @override
  State<ReviewUploadedScreen> createState() => _ReviewUploadedScreenState();
}

class _ReviewUploadedScreenState extends State<ReviewUploadedScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //fetch data from the particular doc which was just uploaded right now.****************
      //Dont just show review has been uploaded**********************************************
      body:
          Column(
            children: [
              SizedBox(height: deviceHeight*0.45,),
              Center(
                  child: Text('Review Uploaded', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ),),),
            ],
          ),

    );
  }
}
