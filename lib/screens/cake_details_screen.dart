//import 'package:capstone_1/models/cake_model.dart';
//import 'package:capstone_1/widgets/toppings_containers.dart';
import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/data/all_toppings_list.dart';
import 'package:capstone_1/screens/homepage.dart';
import 'package:capstone_1/screens/order_confirmation_page.dart';
import 'package:capstone_1/screens/review_pics_page.dart';
//import 'package:capstone_1/widgets/rating_box.dart';
import 'package:capstone_1/widgets/reviews_page.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'dart:io';

//Features to add -
//0. Add riverpod or bloc state management.
//1. To add more than 1 pic in the reviews by user
//2. to open the picture in full screen
//3. Schedule the cake order
//4. Show the delivery guy location
//5. Average review function
//6. User order UI
//7. Reviews sorting by likes -- likes field to be added in review document
//8. Date and time of ordering to be sent to firestore and orders sorted accordingly
//9. Allow the delivery guy to deliver the order only if the location of customer is in 200m radius
//10. UPI payment option
//11. Reminder to admin panel for scheduled cakes prep and delivery
//12. Extract Andrea's production course topics and search the topics separately on youtube one by one
//13. Add the number of cakes to be ordered.
//14. Add the option to add a topping at the review your order page
//15. Add the Add to cart feature.
//16. Add the cake topper feature at the review cake order page -- for reference see the image named HBD Cake Topper in assets/images
//17. Local Authentication like fingerprint & password -- https://www.youtube.com/watch?v=cYeQCGr6F7c



bool userReviewAllow = true;
double avgCakeRating = 4;
LinearGradient ratingGradient =  LinearGradient(colors: [Color(0xFF43A047), Color(0xFFAED581)], begin: Alignment.bottomRight, end: Alignment.topLeft);
final _firestore = FirebaseFirestore.instance;


class CakeDetailsScreen extends StatefulWidget {
  const CakeDetailsScreen({super.key, required this.index1});

  final int index1;


  @override
  State<CakeDetailsScreen> createState() => _CakeDetailsScreenState();
}




double cakeWeight = 1.0;
double cakeToppingPrice = 0;
double containerBorderWidth = 2.2;
var vary = 6;
int cakeToppingIndexforPassingToOrderConfirmationPage = 6;
int cakeName_index = 0;




String convertToString (List ingredientList){
  String newString = '';
  for (String item in ingredientList){
    newString = newString + item + '\n';
  }
  return newString;
}

int returnone(){
  return 1;
}




double weightDifference(double weight){

  double weightDifferenceFunctionOutput = weight-0.5;
  return weightDifferenceFunctionOutput;
}





double returnFinalPrice(int index, double cakeSize, double cakeToppingDaam){

  double Final_Price = 350;
  double finalWeightDifference = weightDifference(cakeSize);



  if(index == 1 || index == 4){
    Final_Price = 350 + (finalWeightDifference*400)+cakeToppingDaam;
  }

  if(index==5 || index==6){
    Final_Price = 400 + (finalWeightDifference*480)+cakeToppingDaam;
  }

  if(index == 0 || index == 2){
    Final_Price = 450 + (finalWeightDifference*550)+cakeToppingDaam;
  }

  if(index == 3){
    Final_Price = 500 + (finalWeightDifference*600)+cakeToppingDaam;
  }
   //print(Final_Price);
  return Final_Price;
}




class _CakeDetailsScreenState extends State<CakeDetailsScreen> {

  @override
  void initState() {

    checkUserReviewAllow();
    returnCakeAvgRating();


    super.initState();
  }

  Future <void> checkUserReviewAllow() async{

    userReviewAllow = true;

    print('***********    Entered checkUserAllow Function **********************');


    try{
      print('entered try block');
      final QuerySnapshot querySnapshot1 =
      await FirebaseFirestore.instance.collection('Cake Orders').where('Customer UID', isEqualTo: userkaUID).where('Cake Name', isEqualTo : Cakes_List[widget.index1].name).get();



      // setState(() {
      //   myCakeOrders = querySnapshot1.docs;
      // });

      //print(myCakeOrders.length);

      print(querySnapshot1.size);

      if(querySnapshot1.size>0){
        userReviewAllow = true;
      }

      else if(querySnapshot1.size == 0){
        setState(() {
          userReviewAllow = false;
        });

        print('user Review permission has changed');
      }
    }
    catch(error)
    {
      print('*****');
      print(error.toString());
      print('#######');
    }


    print(userReviewAllow);

  }


  Future<void> returnCakeAvgRating() async {
    final DocumentSnapshot<Map<String, dynamic>> cakeDoc = await FirebaseFirestore.instance
        .collection('Cake Reviews').doc(
        Cakes_List[widget.index1].name.toString()).get();

    setState(() {
      avgCakeRating = cakeDoc['Average Rating'];
      print(avgCakeRating.toString());
    });


    if(avgCakeRating >=4){
      setState(() {
        ratingGradient = const LinearGradient(colors: [Color(0xFF43A047), Color(0xFFAED581)], begin: Alignment.bottomRight, end: Alignment.topLeft);
      });
    }

    if(avgCakeRating < 4 && avgCakeRating >= 3){
      setState(() {
        ratingGradient = const LinearGradient(colors: [/*Color(0xFFFEC163),*/   Color(0xFFDE4313), Colors.yellow,], begin: Alignment.topLeft, end: Alignment.bottomRight);
      });

    }

    if(avgCakeRating < 3){
      setState(() {
        ratingGradient = const LinearGradient(colors: [Color(0xFFFEB692), Color(0xFFEA5455)]);
      });
    }

  }



  @override
  Widget build(BuildContext context) {

    XFile? pickedImage;
    XFile? clickedImage;
    ImagePicker picker = ImagePicker();
    // FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;


    Future <void> pickFromGallery () async{

      final pickedImg = await picker.pickImage(source: ImageSource.gallery);
      print(pickedImg?.path);

      try{

//flutter.ndkVersion
        if(pickedImg!=null){
          setState(() {
            pickedImage = pickedImg;
          });

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ReviewPicsPage(myFile: pickedImage!, currentCakeName: Cakes_List[widget.index1].name,);
          },));

          print('picked image is not null');
          print(pickedImg.path);
          print(pickedImage?.path);

        }

        else if(pickedImg == null){
          print('picked one is null');
          return;
        }
        else{
          print('no img selected');
        }


      } catch(err) {
        print('Error occurred in picked gallery image -- try catch block');
        print(err);

      }
    }







    Future <void> clickFromCam () async{
      final clickedImg = await picker.pickImage(source: ImageSource.camera);


      try {
        if (clickedImg != null) {
          setState(() {
            //clickedImage = File(clickedImg.path);

            clickedImage =
                clickedImg; //-- in case we change the data type of clickedImage from File to XFile
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ReviewPicsPage(myFile: clickedImage!, currentCakeName: Cakes_List[widget.index1].name);
            },));

            print('picked image is not null');
            print(clickedImg.path);
            print(clickedImage?.path);
          });
        }

        else if (clickedImg == null) {
          print('picked one is null');
          return;
        }
        else {
          print('no img selected');
        }
      }  catch(err) {
        print('Error occurred in Clicked Image -- try catch block');
        print(err);

      }


    }







    int returnIndexOfNextCake(index){
      if(index < 6) {
        return index+1;
        //if the index is not at the last element of the cakes_List, then simply increase the index by 1,
        //so that the image carousel can show another 2nd image.
      }
      else{
        return 0;
        //if the index is at last of the cakes_List, the next index will give an error of "not in range",
        //in that case, return the first cake in the list i.e. cake at 0th index
      }
    }


    int returncakeListIndex(){
      print(widget.index1);
      return widget.index1;

    }





    /*******************************************************************************************************/






    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;


    return Scaffold(
        //backgroundColor: Color(0x33E1BEE7),

        //Colors.purpleAccent.shade100.withAlpha()/*.withOpacity(0.2)*/,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [/*Colors.purpleAccent.shade100.withOpacity(0.1)*/  Color(0x33E1BEE7), Colors.white/*Colors.lightBlueAccent.shade100.withOpacity(0.01)*/],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 70),
              // CarouselSlider(items: [
              //   Image.asset(Cakes_List[widget.index1].imgPath,fit: BoxFit.contain, width : deviceWidth,),
              //   Container(color: Colors.lime, child : const Center(child: Text('Another image added to test sliding carousel'))),
              //   Image.asset(Cakes_List[returnIndexOfNextCake(widget.index1)].imgPath,fit: BoxFit.contain),
              // ],
              //     options: CarouselOptions(
              //         animateToClosest: true,
              //         autoPlay: true,
              //         autoPlayAnimationDuration: const Duration(milliseconds: 550),
              //         autoPlayCurve: Curves.elasticOut,
              //         autoPlayInterval: const Duration(seconds: 6),
              //         viewportFraction: 1.0,
              //     )
              // ),

              SizedBox(
                height: 250,
                child: CarouselView(itemExtent: deviceWidth,

                    children: [
                    Image.asset(Cakes_List[widget.index1].imgPath,fit: BoxFit.contain, width : deviceWidth,),
                    //Container(color: Colors.lime, child : const Center(child: Text('Another image added to test sliding carousel'))),
                    Image.asset(Cakes_List[returnIndexOfNextCake(widget.index1)].imgPath,fit: BoxFit.contain),
                  ],

                  controller: CarouselController(initialItem: 0),
                ),
              ),

              const SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,),
                child: Container(
                  alignment: Alignment.topLeft,
                    child: Text(Cakes_List[widget.index1].name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, ),textAlign: TextAlign.start)
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 8),
                child: Text(Cakes_List[widget.index1].description, style: const TextStyle(fontSize: 15),),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      OutlinedButton(onPressed: (){
                        setState(() {
                          cakeWeight = 0.5;
                        });
                      }, child: Text('0.5 Pound',  style: TextStyle(fontWeight: cakeWeight == 0.5 ? FontWeight.bold : FontWeight.w100),)),

                      const SizedBox(width: 15,),

                      OutlinedButton(onPressed: (){
                        setState(() {
                          cakeWeight = 1;
                        });

                        },
                        child: Text('1 Pound', style: TextStyle(fontWeight: cakeWeight == 1 ? FontWeight.bold : FontWeight.w100),)),

                      const SizedBox(width: 20,),

                      OutlinedButton(onPressed: (){
                        setState(() {
                          cakeWeight = 1.5;
                          });
                        }, child: Text('1.5 Pound', style: TextStyle(fontWeight: cakeWeight == 1.5 ? FontWeight.bold : FontWeight.w100),)),

                      const SizedBox(width: 20,),

                      OutlinedButton(onPressed: (){
                        setState(() {
                          cakeWeight = 2.0;
                        });
                        },
                          child: Text('2.0 Pounds', style: TextStyle(fontWeight: cakeWeight == 2.0 ? FontWeight.bold : FontWeight.w100),)),

                      const SizedBox(width: 10,),
                    ],
                  ),
                ),
              ),


              Divider(thickness: 3, color: Colors.grey.shade200,),


              Row(
                children: [
                  const SizedBox(width: 15,),
                  const Text('₹', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  const SizedBox(width: 7,),
                  Text(
                    returnFinalPrice(widget.index1,cakeWeight,cakeToppingPrice).toString(),
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),

              const Text('Toppings',  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),






              Container(
                width : deviceWidth,
                height: deviceHeight/4.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toppingsList.length,

                  itemBuilder: (context, index2) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      child: Container(
                        height: deviceHeight/4.7,
                        width: deviceWidth*0.36,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),
                          border: Border.all(color: Colors.purpleAccent.shade100.withOpacity(0.6),width: vary == index2 ? 3 : 0.1 ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: deviceWidth*0.38,
                              height: deviceHeight/7,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomRight: Radius.elliptical(25, 25),bottomLeft: Radius.elliptical(25, 25) ),
                                child: Image.network(toppingsList[index2].imageNetworkAddress,
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                            Text(toppingsList[index2].toppingName, style: const TextStyle(fontWeight: FontWeight.w600),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('₹'),
                                const SizedBox(width: 4),
                                Text(toppingsList[index2].price.toString(), style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),



                      onTap: (){

                        print(index2);
                        print(toppingsList[index2].toppingName);
                        print(toppingsList[index2].price);
                        setState(() {
                          cakeToppingPrice = toppingsList[index2].price.toDouble();
                          vary = index2;
                          cakeToppingIndexforPassingToOrderConfirmationPage = index2;

                        });

                      },
                    ),
                  );
                    //ToppingsContainer(indexOfToppingsList: index2, indexOfCakeList: widget.index1, weightOfCake: cakeWeight, onToppingSelected : updateToppingCost(toppingsList[index2].price.toDouble()));
                  },
                ),
              ),

              const SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){

                      print(FirebaseAuth.instance.currentUser!.uid);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return OrderConfirmation(totalPrice: returnFinalPrice(widget.index1,cakeWeight,cakeToppingPrice),
                          cakeToppingIndex: cakeToppingIndexforPassingToOrderConfirmationPage,
                          cakeSize: cakeWeight,
                          cakeNameIndex: widget.index1,
                        );
                      },));
                      //print(Fire)
                    },

                    child: Container(
                      width: deviceWidth*0.9,
                      height: deviceHeight*0.08,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176),
                            /*Color.fromARGB(255, 178, 154, 211),*/ Colors.purpleAccent.shade100.withOpacity(0.6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        //color: Colors.purpleAccent.shade100.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: const Center(
                          child: Text('                Buy Now                  ',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 23,
                                fontWeight: FontWeight.bold),)),
                               ),
                    ),
                ],
              ),
                  const SizedBox(height : 10),
              const Divider(height: 2,),

              ExpansionTile(
                 shape: Border.all(color: Colors.white,width: 0.1 ),
                title: const Text('Product Ingredients', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 230),
                    child: Text(convertToString(Cakes_List[widget.index1].ingredients), style: const TextStyle(color: Colors.black),textAlign: TextAlign.left,),
                  )
                ],
              ),

              const Divider(height: 10),



              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const SizedBox(width: 2,),
                    const Text('Customer Reviews', style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
                    const SizedBox(width: 25,),
                    OutlinedButton(
                      onPressed: (){
                        showModalBottomSheet(
                          context: context, builder: (context) {

                            if(userReviewAllow == true){
                              return SizedBox(
                                height: 240,
                                width: deviceWidth,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 15,),
                                    InkWell(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                        pickFromGallery();
                                        //final galleryPicture = ImagePicker().pickImage(source: ImageSource.gallery);

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          width: deviceWidth*0.9,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176), Color.fromARGB(255, 178, 154, 211),],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: const Center(child: Text('Upload from Gallery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        clickFromCam();
                                        //final camPicture = ImagePicker().pickImage(source: ImageSource.camera);
                                      },

                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          width: deviceWidth*0.9,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176), Color.fromARGB(255, 178, 154, 211),],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: const Center(child: Text('Upload using Camera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            else{
                              return const Center(
                                child: Text('Please purchase the cake to review it', style: TextStyle(color: Colors.deepPurple, fontSize: 17, fontWeight: FontWeight.bold),),
                              );
                            }
                        },
                        );

                      },
                      style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                      child:  Text('Give Ratings', style: TextStyle(fontWeight: FontWeight.bold, color : userReviewAllow == false ? Colors.black12 : Colors.deepPurple),),
                    )
                  ],
                ),
              ),


                // Row(
                //
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.all(0.034*deviceWidth),
                //       child: Container(
                //         width: 0.4*deviceWidth,
                //         height: 0.2*deviceHeight,
                //         decoration: BoxDecoration(border: Border.all(width: 0.5)),
                //       ),
                //     ),
                //
                //     Container(height: 0.17*deviceHeight, width: 0.5,color :Colors.grey),
                //
                //     Padding(
                //       padding: EdgeInsets.all(0.034*deviceWidth),
                //       child: Container(
                //         width: 0.46*deviceWidth,
                //         height: 0.2*deviceHeight,
                //         decoration: BoxDecoration(border: Border.all(width: 0.5),
                //         color:  const Color(0x33E1BEE7)
                //         ),
                //       ),
                //     )
                //   ],
                // ),

              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left : 20.0, right: 30),
              //       child: Container(
              //         height: 40,
              //         //width: 50,
              //         decoration: BoxDecoration(color: Colors.lightGreen),
              //         child: Row(
              //           children: [
              //                 // ElevatedButton(onPressed: () {
              //                 //   returnCakeAvgRating();
              //                 // }, child: const Text('rating'))
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // ),





              //******************************************************************************************************
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //       height: 20,
              //       //color: Colors.orangeAccent,
              //       child :Row(
              //         children: [
              //           const SizedBox(width: 19, ),
              //           Container(
              //             decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(7)),
              //             height: 100,
              //             width: 60,
              //             child: Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.only(bottom: 1, left: 6),
              //                   child: Text(avgCakeRating.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
              //                 ),
              //                 const SizedBox(width: 1,),
              //                 const Padding(
              //                   padding: EdgeInsets.only(top : 2.5, right: 4),
              //                   child: Icon(Icons.star_rounded, color:Colors.white,size: 17,),
              //                 ),
              //               ],
              //             ),
              //           ),
              //
              //           // const SizedBox(width: 20,),
              //           // Text(widget.dateOfReview,  style: const TextStyle(color: Colors.black38, fontSize: 12),),
              //
              //         ],
              //       )
              //   ),
              // ),



              //RatingBox(),
              //****************************************************************************************************************

            Row(
              children: [
                const SizedBox(width: 16,),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: ratingGradient,// LinearGradient(colors: [Color(0xFF43A047), Color(0xFFAED581)], begin: Alignment.bottomRight, end: Alignment.topLeft),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [

                        Text(avgCakeRating.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                        //SizedBox(width: 4,),
                        const Padding(
                          padding: EdgeInsets.only(left : 2.0),
                          child: Icon(Icons.star_rounded, color:Colors.white,size: 25,),
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: deviceHeight*0.15,
                  width: deviceWidth,

                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StreamBuilder(
                            stream: _firestore.collection('Cake Reviews').doc(Cakes_List[widget.index1].name).collection(Cakes_List[widget.index1].name).snapshots(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              else if(snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){
                                  List<QueryDocumentSnapshot<Map<String, dynamic>>> reviewsDocs = snapshot.data!.docs;

                                  return Container(
                                    width: deviceWidth,
                                    height: deviceHeight*0.3,
                                    //color: Colors.white,
                                    child: ListView.builder(
                                      itemCount: reviewsDocs.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:(context, index) {
                                        QueryDocumentSnapshot<Map<String, dynamic>> individualReviewDocument = reviewsDocs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                              width: deviceWidth*0.25,
                                              height: deviceHeight*0.15,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  individualReviewDocument['Image URL'],
                                                  height: 100,
                                                  width: 80,
                                                  fit: BoxFit.cover,

                                                ),
                                              )),
                                        );
                                      },
                                    ),
                                  );
                                }
                                else if (snapshot.hasData == false){
                                  showDialog(context: context, builder:  (context) {
                                    return const AlertDialog(content: Text('No data found'),);
                                  },);
                                }

                                else if(snapshot.hasError){
                                  showDialog(context: context, builder:  (context) {
                                    return const AlertDialog(content: Text('There is an error'),);
                                  },);
                                }
                              }
                              return Container();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //**********************************************************************************************************

              //const SizedBox(height: 15,),
              
              
              InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      SizedBox(width: 4,),
                      Text('See All Reviews', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                      Spacer(),
                      Icon(Icons.chevron_right),
                      SizedBox(width: 11,),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ReviewsPage(cakeName: Cakes_List[widget.index1].name,);
                  },
                  ));
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}






























// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: Row(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           height: deviceHeight/6,
//           width: deviceWidth*0.36,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),
//           border: Border.all(color: Colors.black),
//                       ),
//                       ),
//       ),
//       Container(
//         height: deviceHeight/6,
//         width: deviceWidth*0.36,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),
//           border: Border.all(color: Colors.black),
//         ),
//       ),
//
//       Padding(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           height: deviceHeight/6,
//           width: deviceWidth*0.36,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),
//             border: Border.all(color: Colors.black),
//           ),
//         ),
//       ),
//
//   ],),
// ),

















// List<MapEntry<String,double>> listTwo = [
//   MapEntry('Choco Chips', 100),
//   MapEntry('Butterscotch', 80),
//   MapEntry('Vanilla', 60),
//   MapEntry('Frosted Peanuts', 100),
//   MapEntry('Strawberries', 100),
//   MapEntry('Whipped Cream', 120),
//   MapEntry('Chocolate Sauce', 80)
// ];




