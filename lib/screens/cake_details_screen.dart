import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/data/all_toppings_list.dart';
import 'package:capstone_1/screens/order_confirmation_page.dart';
//import 'package:capstone_1/models/cake_model.dart';
//import 'package:capstone_1/widgets/toppings_containers.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





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
  print(Final_Price);
  return Final_Price;
}







class _CakeDetailsScreenState extends State<CakeDetailsScreen> {
  @override
  Widget build(BuildContext context) {


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

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            CarouselSlider(items: [
              Image.asset(Cakes_List[widget.index1].imgPath,fit: BoxFit.contain, width : deviceWidth,),
              Container(color: Colors.lime, child : const Center(child: Text('Another image added to test sliding carousel'))),
              Image.asset(Cakes_List[returnIndexOfNextCake(widget.index1)].imgPath,fit: BoxFit.contain),
            ],
                options: CarouselOptions(
                    animateToClosest: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 550),
                    autoPlayCurve: Curves.elasticOut,
                    autoPlayInterval: const Duration(seconds: 6),
                    viewportFraction: 1.0,
                )
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
                        border: Border.all(color: Colors.black,width: vary == index2 ? 3 : 1 ),
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

            SizedBox(height: 15,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){},
                  child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 18),),
                  style: TextButton.styleFrom(backgroundColor: Colors.black,elevation: 10,
                      padding: EdgeInsets.symmetric(horizontal: deviceWidth*0.115, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1),
                      side: const BorderSide(style: BorderStyle.none))),),

                TextButton(onPressed: (){

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
                  child: const Text('Buy Now', style: const TextStyle(color: Colors.white, fontSize: 18),),
                  style: TextButton.styleFrom(backgroundColor: Colors.black,elevation: 10,

                      padding:  EdgeInsets.symmetric(horizontal: deviceWidth*0.150, vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1),
                          side: const BorderSide(style: BorderStyle.none))),),
              ],
            ),

            const Divider(height: 2,),

            ExpansionTile(
              // shape: ShapeBorder(),
              title: const Text('Product Ingredients', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text(convertToString(Cakes_List[widget.index1].ingredients), style: const TextStyle(color: Colors.black),textAlign: TextAlign.left,),
                )
              ],
            ),

            const Divider(height: 10),


            const SizedBox(height: 20,),


            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const SizedBox(width: 2,),
                  Text('Customer Reviews', style: TextStyle(fontSize: 20),textAlign: TextAlign.left),
                  SizedBox(width: 25,),
                  OutlinedButton(onPressed: (){

                  },
                      child: Text('Give Ratings', style: TextStyle(fontWeight: FontWeight.bold),),
                     style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                  )
                ],
              ),
            ),


              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(0.034*deviceWidth),
                    child: Container(
                      width: 0.4*deviceWidth,
                      height: 0.2*deviceHeight,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    ),
                  ),

                  Container(height: 0.17*deviceHeight, width: 0.5,color :Colors.grey),

                  Padding(
                    padding: EdgeInsets.all(0.034*deviceWidth),
                    child: Container(
                      width: 0.46*deviceWidth,
                      height: 0.2*deviceHeight,
                      decoration: BoxDecoration(border: Border.all(width: 0.5)),
                    ),
                  )
                ],
              ),

              //padding: EdgeInsets.all(20),

          ],
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




