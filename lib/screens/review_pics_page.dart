import 'dart:io';
import 'package:capstone_1/screens/homepage.dart';
import 'package:capstone_1/screens/review_uploaded_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import '../widgets/lottie_demo.dart';
import 'dart:async';

class ReviewPicsPage extends StatefulWidget {
  const ReviewPicsPage({super.key, required this.myFile, required this.currentCakeName});

  final XFile myFile;
  final String currentCakeName;
  @override
  State<ReviewPicsPage> createState() => _ReviewPicsPageState();
}


//String uploadedImageURL = '';
String? cakeReview;
bool anyError = false;
int? cakeRating;
bool ratingGiven = false;
bool reviewGiven = false;
//int reviewFullyUploaded = 0;
Timer? _timer;

final allCakeReviewsCollection_Reference = FirebaseStorage.instance.ref().child('Cake Reviews');

TextEditingController reviewController = TextEditingController();
final _formKey = GlobalKey<FormState>();



class _ReviewPicsPageState extends State<ReviewPicsPage> {

  double uploadingProgress = 0;

  @override
  void dispose() {

    reviewController.clear();
    super.dispose();
    cakeRating = null;
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    String nowCake = widget.currentCakeName;


    void showOrRemoveDialog(int showOrPop) {
      //if showOrPop is 1, show the dialogue, else is 0, the dialogue is already there, just remove the dialogue
      print('show Dialog called');


      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (Dialog_context) {
          return Dialog(
            child: Container(

              width: deviceWidth,
              height: deviceHeight * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showOrPop == 1?
                  Center(
                    child: Lottie.network(
                        /*'https://lottie.host/63f81e80-f2fc-4b46-8c20-3e7daf2d504d/9IIiPDHeaI.json'*/
                        'https://lottie.host/a196b738-b1d9-4d5e-bad6-c19bbdf116be/DWykJpSDwt.json' //processing animation
                    ),
                  ) : Center(child: Lottie.network(
                    /*'https://lottie.host/1ebdf132-6017-4bea-9dc2-1f62793c3f7c/xMFpPgz4yb.json'*/
                      'https://lottie.host/e814bbe7-11be-4148-a5ff-91ca5d60dcd3/TD5rzDMTT4.json',
                  //tick mark animation
                    repeat: false
                  ),),
                  const SizedBox(height: 30,),
                  if (showOrPop == 0) ElevatedButton(onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(context).pop();
                  }, child: const Text('Okay!')) else Container(),
                ],
              ),
            ),
          );
        },
      );
      
      
      
      
      
      
      
      
      // if (showOrPop == 1){
      //   showDialog(
      //     barrierDismissible: false,
      //     context: context,
      //     builder: (Dialog_context) {
      //       return Dialog(
      //         child: Container(
      //           width: deviceWidth,
      //           height: deviceHeight * 0.8,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(15),),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Center(
      //                 child: Lottie.network(
      //                     'https://lottie.host/63f81e80-f2fc-4b46-8c20-3e7daf2d504d/9IIiPDHeaI.json'),
      //               ),
      //
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   );
      //
      // }
      // if(showOrPop == 0){
      //   Navigator.of(context, rootNavigator: true).pop();
      //
      //   //keeping rootNavigator to true so that the dialog pops not the background screen below the dialog
      // }

    }


    Future<void> uploadURLAndReviewsDataToFireStore(String imgURL) async{

      final individualReviewDoc = FirebaseFirestore.instance.collection('Cake Reviews').doc(nowCake).collection(nowCake).doc();

      try{
        await individualReviewDoc.set({
          'Customer Name': userkaName,
          'Image URL' : imgURL,
          'Rating' : cakeRating,
          'Review' : cakeReview,
          'UID' : userkaUID,
        });
        showOrRemoveDialog(0);
        //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {return ReviewUploadedScreen();},));
      }
      catch(error) {
        print(error.toString());
      }
    }

    Future <void> uploadImageGetURL() async{
        print('/////////////////////////entered the upload function////////////////');

      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imgToUpload = allCakeReviewsCollection_Reference.child(uniqueFileName);

      try {
        //UploadTask task = await imgToUpload.putFile(File(widget.myFile.path));
        //series 1.0
        await imgToUpload.putFile(File(widget.myFile.path));
        String uploadedImageURL = await imgToUpload.getDownloadURL();

        // task.snapshotEvents.listen((TaskSnapshot snapshot){ series
        //   setState(() {
        //     uploadingProgress = snapshot.bytesTransferred/snapshot.totalBytes;
        //   });
        // });
        //series 1

        print('inside try block');
        print(uploadedImageURL);

         uploadURLAndReviewsDataToFireStore(uploadedImageURL);
      }

      catch(err){
        showDialog(context: context, builder: (context) {
          return Dialog(

            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.yellow, ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                  Text(err.toString()),

                ],
              ),
            ),
          );
         },);
        print('error*******************************');
        print(err.toString());
      }
      //print(imgToUpload.getMetadata().toString());

    }


    return Scaffold(
        appBar: AppBar(title: Text(widget.currentCakeName),),
      body:
      Stack(
       children: [
        SingleChildScrollView(
          child: Column(
            children: [
              //image ka container
              Container(
                height: deviceHeight*0.455,
                width: deviceWidth*0.95,
                child: Image.file(File(widget.myFile.path),
                  fit: BoxFit.scaleDown,
                ),
              ),

              //SizedBox(height : 40),
              //Spacer(),
              //const SizedBox(height: 85,),


              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: deviceHeight*0.025),
                              child: RatingBar.builder(
                                initialRating: 0,
                                itemCount: 5,
                                direction: Axis.horizontal,
                                maxRating: 5,
                                unratedColor: Colors.grey,


                                itemBuilder: (context, index) {
                                  return const Icon(Icons.star_border_rounded, color: Colors.amberAccent,);
                                },
                                onRatingUpdate: (rating) {
                                  cakeRating = rating.toInt();
                                },

                              ),
                            ),
                            // ElevatedButton(onPressed: (){
                            //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            //     return LottieDemo();
                            //   },));
                            // }, child: Text('Launch'))
                          ],
                        ),
                      ),

                      //review box------------------
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
                                    borderSide: const BorderSide(color: Colors.black12))),
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                print('review is null');
                                return 'Please share your Reviews!';
                              }

                              else{
                                //cakeReview = reviewController.text;
                                return null;
                              }

                            },
                            onSaved: (newValue) {
                              print('save called');
                              cakeReview = newValue!.trim();
                              //exclamation is saying newValue will never be null
                              //because onSaved is called inside of this condition --
                              //_formKey.currentState!.validate() && cakeRating != null
                              //if form is not validated i.e. reviewController is NULL, onSaved function will not be called
                              //every time this function is called, review is definitely non-null/ has some value.

                            },
                          ),),)],
                  )),
              //stars icon ka container



              const SizedBox(height: 25,),
              userkaName!=null ?
              InkWell(
                onTap: () {

                  if(/*reviewGiven == true*/ _formKey.currentState!.validate() && cakeRating != null){
                    _formKey.currentState!.save();
                    showOrRemoveDialog(1);
                    uploadImageGetURL();


                    // print('validated');
                    // print(cakeReview);
                    // print(cakeRating);

                    // _timer?.cancel();
                    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                    //   showLottieAnimation();
                    // },);

                    // reviewFullyUploaded = 1;
                    //showProcessingLottieAnimation();
                    //startLottieTimer();

                  }
                  else {
                    print('not validated');
                    if(cakeRating!=null){
                      print(cakeRating);
                    }

                    if(cakeRating == null){
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please give the ratings too!')));
                    }


                  }

                },
                child: Container(
                  height: 50,
                  width: deviceWidth*0.95,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [const Color.fromARGB(150, 234, 132, 176), /*Color.fromARGB(255, 178, 154, 211),*/ Colors.purpleAccent.shade100.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    //color: Colors.purpleAccent.shade100.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text('Upload',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)),
                ),
              ) : const Text('hy'),
              const SizedBox(height: 9,),
            ],
          ),
        ),
          // if (uploadingProgress>0) Center(
          //   child: Lottie.network('https://lottie.host/63f81e80-f2fc-4b46-8c20-3e7daf2d504d/9IIiPDHeaI.json'),
          // ),
      ],

      ),
    );
  }
}








// Text(widget.myFile.path),
// SizedBox(height : 20),
// Text(userkaName ?? 'No User Name'),
// SizedBox(height : 10),
// Text(userkaUID),
// Spacer(),

// final strawberryVanillaCake_Reviews_Ref = storageRef.child("Strawberry Vanilla Cake");
// final strawberryPeanutCake_Reviews_Ref = storageRef.child("Strawberry peanut Cake");
// final strawberryFrostedPeanut_Reviews_Ref = storageRef.child("Strawberry Frosted Peanut");
// final pureChocolateCake_Reviews_Ref = storageRef.child("Pure Chocolate Cake");
// final vanillaWithSpreadingCake_Reviews_Ref = storageRef.child("Vanilla with Spreading Cake");
// final butterScotchStrawberryCake_Reviews_Ref = storageRef.child("ButterScotch Strawberry Cake");
// final mixedFruitLeafCake_Reviews_Ref = storageRef.child("Mixed Fruit Leaf Cake");

