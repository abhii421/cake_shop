import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/data/all_toppings_list.dart';
import 'package:capstone_1/models/cake_model.dart';
import 'package:capstone_1/widgets/toppings_containers.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';







class CakeDetailsScreen extends StatefulWidget {
  const CakeDetailsScreen({super.key, required this.index1});

  final int index1;

  @override
  State<CakeDetailsScreen> createState() => _CakeDetailsScreenState();
}










double cakeWeight = 1.0;
double toppingsCostToBePassed2 = 0;
//double productDetails_Collapsible_ContainerHeight = 20;




String convertToString (List ingredientList){
  String newString = '';
  for (String item in ingredientList){
    newString = newString + item + '\n';
  }
  return newString;
}







double getToppingsCost(){
  print('Toppings cost which is received - $toppingsCostToBePassed');


  toppingsCostToBePassed2 = toppingsCostToBePassed.toDouble();

  return toppingsCostToBePassed.toDouble();

}






double weightDifference(double weight){

  double weightDifferenceFunctionOutput = weight-0.5;
  return weightDifferenceFunctionOutput;
}





double returnFinalPrice(int index, double cakeSize, double toppingsCost){

  double Final_Price = 350;
  double finalWeightDifference = weightDifference(cakeSize);


  toppingsCost = toppingsCostToBePassed;

  print('toppings cost received at final price function - $toppingsCost');




  if(index == 1 || index == 4){
    Final_Price = 350 + (finalWeightDifference*400) + toppingsCost;
  }

  if(index==5 || index==6){
    Final_Price = 400 + (finalWeightDifference*480) + toppingsCost;
  }

  if(index == 0 || index == 2){
    Final_Price = 450 + (finalWeightDifference*550) + toppingsCost;
  }

  if(index == 3){
    Final_Price = 500 + (finalWeightDifference*600) + toppingsCost;
  }

  return Final_Price;
}


class _CakeDetailsScreenState extends State<CakeDetailsScreen> {
  @override
  Widget build(BuildContext context) {




    int returnIndex(index){

      if(index < 6)
      {
        return index+1;
      }
      else{
        return 0;
      }
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
              Image.asset(Cakes_List[returnIndex(widget.index1)].imgPath,fit: BoxFit.contain),
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
                Text(returnFinalPrice(widget.index1,cakeWeight, getToppingsCost()).toString(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
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
                return ToppingsContainer(indexOfToppingsList: index2, indexOfCakeList: widget.index1, weightOfCake: cakeWeight);

                },
              ),
            ),

            const Divider(height: 2,),
            ExpansionTile(
              // shape: ShapeBorder(),
              title: const Text('Product Ingredients', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 190),
                  child: Text(convertToString(Cakes_List[widget.index1].ingredients), style: const TextStyle(color: Colors.black),textAlign: TextAlign.start,),
                )
              ],
            ),
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




