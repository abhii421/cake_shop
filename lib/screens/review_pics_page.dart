import 'dart:io';
import 'package:capstone_1/screens/homepage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReviewPicsPage extends StatefulWidget {
  const ReviewPicsPage({super.key, required this.myFile, required this.currentCakeName});

  final XFile myFile;
  final String currentCakeName;
  @override
  State<ReviewPicsPage> createState() => _ReviewPicsPageState();
}

String uploadedImageURL = '';
bool anyError = false;
//var currentCakePageName = currentCakeName;

// final firebaseStorage = FirebaseStorage.instance;
// final rootReference = firebaseStorage.ref();
final cakeReviewsFolder_Reference = FirebaseStorage.instance.ref().child('Cake Reviews');






// final strawberryVanillaCake_Reviews_Ref = storageRef.child("Strawberry Vanilla Cake");
// final strawberryPeanutCake_Reviews_Ref = storageRef.child("Strawberry peanut Cake");
// final strawberryFrostedPeanut_Reviews_Ref = storageRef.child("Strawberry Frosted Peanut");
// final pureChocolateCake_Reviews_Ref = storageRef.child("Pure Chocolate Cake");
// final vanillaWithSpreadingCake_Reviews_Ref = storageRef.child("Vanilla with Spreading Cake");
// final butterScotchStrawberryCake_Reviews_Ref = storageRef.child("ButterScotch Strawberry Cake");
// final mixedFruitLeafCake_Reviews_Ref = storageRef.child("Mixed Fruit Leaf Cake");



class _ReviewPicsPageState extends State<ReviewPicsPage> {


  Future <void> uploadImageGetURL() async{


    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final imgToUpload = cakeReviewsFolder_Reference.child(uniqueFileName);

    try {
      await imgToUpload.putFile(File(widget.myFile.path));
      uploadedImageURL = await imgToUpload.getDownloadURL();
      print('inside try block');
      print(uploadedImageURL);
      !anyError;
    }

    catch(err){
      print('error*******************************');
      print(err.toString());
    }
    //print(imgToUpload.getMetadata().toString());

  }


  Future<void> uploadURL()async{

  }



  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(title: Text(widget.currentCakeName),),
      body: Column(
        children: [
          Container(
            height: 240,
            child: Image.file(File(widget.myFile.path)),
          ),

          Text(widget.myFile.path),
          SizedBox(height : 20),
          Text(userkaName ?? 'No User Name'),
          SizedBox(height : 10),
          Text(userkaUID),
          Spacer(),

          userkaName!=null ?
          InkWell(
            onTap: () {
                uploadImage();
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
