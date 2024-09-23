import 'dart:io';
import 'package:capstone_1/screens/homepage.dart';
import 'package:capstone_1/screens/review_uploaded_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPicsPage extends StatefulWidget {
  const ReviewPicsPage({super.key, required this.myFile, required this.currentCakeName});

  final XFile myFile;
  final String currentCakeName;
  @override
  State<ReviewPicsPage> createState() => _ReviewPicsPageState();
}



String uploadedImageURL = '';
String cakeReview = '';
bool anyError = false;
double? cakeRating;

final cakeReviewsFolder_Reference = FirebaseStorage.instance.ref().child('Cake Reviews');
TextEditingController reviewController = TextEditingController();
// final strawberryVanillaCake_Reviews_Ref = storageRef.child("Strawberry Vanilla Cake");
// final strawberryPeanutCake_Reviews_Ref = storageRef.child("Strawberry peanut Cake");
// final strawberryFrostedPeanut_Reviews_Ref = storageRef.child("Strawberry Frosted Peanut");
// final pureChocolateCake_Reviews_Ref = storageRef.child("Pure Chocolate Cake");
// final vanillaWithSpreadingCake_Reviews_Ref = storageRef.child("Vanilla with Spreading Cake");
// final butterScotchStrawberryCake_Reviews_Ref = storageRef.child("ButterScotch Strawberry Cake");
// final mixedFruitLeafCake_Reviews_Ref = storageRef.child("Mixed Fruit Leaf Cake");



class _ReviewPicsPageState extends State<ReviewPicsPage> {

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;


    String nowCake = widget.currentCakeName;


    Future<void> uploadURLToFireStore() async{

      //cakeReview = reviewController.text;
      if(reviewController == null){
        cakeReview = '';
      }
      else{
        cakeReview = reviewController.text;
      }

      final individualReviewDoc = FirebaseFirestore.instance.collection('Cake Reviews').doc(nowCake).collection(nowCake).doc();


      try{

        await individualReviewDoc.set({
          'Customer Name': userkaName,
          'Image URL' : uploadedImageURL,
          'Rating' : cakeRating ?? 4,
          'Review' : cakeReview,
          'UID' : userkaUID,
        });


        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return ReviewUploadedScreen();
        },));
      }
      catch(error) {

        print(error.toString());

      }
    }








    Future <void> uploadImageGetURL() async{


      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imgToUpload = cakeReviewsFolder_Reference.child(uniqueFileName);

      try {
        await imgToUpload.putFile(File(widget.myFile.path));
        uploadedImageURL = await imgToUpload.getDownloadURL();
        print('inside try block');
        print(uploadedImageURL);
        !anyError;
         uploadURLToFireStore();
      }

      catch(err){
        print('error*******************************');
        print(err.toString());
      }
      //print(imgToUpload.getMetadata().toString());

    }


    return Scaffold(
        appBar: AppBar(title: Text(widget.currentCakeName),),
      body: Column(
        children: [
          Container(
            height: 340,
            width: deviceWidth*0.95,
            child: Image.file(File(widget.myFile.path),
            fit: BoxFit.scaleDown,
            ),
          ),

          //SizedBox(height : 40),
          //Spacer(),
          //const SizedBox(height: 85,),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 50,
                width: deviceWidth*0.8,
                child: RatingBar.builder(
                  initialRating: 0,
                  itemCount: 5,
                  direction: Axis.horizontal,
                  maxRating: 5,
                  unratedColor: Colors.grey,


                  itemBuilder: (context, index) {
                  return Icon(Icons.star_border, color: Colors.amberAccent,);
                  },
                  onRatingUpdate: (rating) {
                  print(rating);
                  cakeRating = rating;
                  print(cakeRating);
                  },

                ),
              ),
            ),

          Align(
            alignment: Alignment.center,
            child: Container(
              width: deviceWidth*0.92,
              child: TextFormField(
                maxLength: 400,
                controller: reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(6),
                    hintText: 'Write your views about the cake',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12))),
              ),
            ),
          ),

          // Text(widget.myFile.path),
          // SizedBox(height : 20),
          // Text(userkaName ?? 'No User Name'),
          // SizedBox(height : 10),
          // Text(userkaUID),
          // Spacer(),

          const SizedBox(height: 25,),
          userkaName!=null ?
          InkWell(
            onTap: () {
                uploadImageGetURL();
            },
            child: Container(
              height: 50,
              width: deviceWidth*0.95,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176),
                    /*Color.fromARGB(255, 178, 154, 211),*/ Colors.purpleAccent.shade100.withOpacity(0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  //color: Colors.purpleAccent.shade100.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text('Upload',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)),
            ),
          ) : Text('hy'),
          const SizedBox(height: 9,),
        ],
      ),
    );
  }
}
