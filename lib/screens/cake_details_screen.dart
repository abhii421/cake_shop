import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/models/cake_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class CakeDetailsScreen extends StatefulWidget {
  const CakeDetailsScreen({super.key, required this.index1});

  final int index1;

  @override
  State<CakeDetailsScreen> createState() => _CakeDetailsScreenState();
}


String cakeWeight = '1.5 Pounds';
double productDetails_Collapsible_ContainerHeight = 20;

String convertToString (List ingredientList){
  String newString = '';
  for (String item in ingredientList){
    newString = newString + item + '\n';
  }
  return newString;
}


Map priceMap = {
  '0.5 Pounds' : 200,

};

int returnFinalPrice(){
  int Final_Price = 0;
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


            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                alignment: Alignment.topLeft,
                  child: Text(Cakes_List[widget.index1].name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, ),textAlign: TextAlign.start)
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 10),
              child: Text(Cakes_List[widget.index1].description, style: const TextStyle(fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(onPressed: (){
                      setState(() {
                        cakeWeight = '0.5 Pounds';
                      });
                    }, child: Text('0.5 Pounds',  style: TextStyle(fontWeight: cakeWeight == '0.5 Pounds' ? FontWeight.bold : FontWeight.w100),)),

                    const SizedBox(width: 15,),

                    OutlinedButton(onPressed: (){
                      setState(() {
                        cakeWeight = '1 Pounds';
                      });

                      }, child: Text('1 Pounds', style: TextStyle(fontWeight: cakeWeight == '1 Pounds' ? FontWeight.bold : FontWeight.w100),)),

                    const SizedBox(width: 20,),

                    OutlinedButton(onPressed: (){
                      setState(() {
                        cakeWeight = '1.5 Pounds';
                        });
                      }, child: Text('1.5 Pounds', style: TextStyle(fontWeight: cakeWeight == '1.5 Pounds' ? FontWeight.bold : FontWeight.w100),)),

                    const SizedBox(width: 20,),

                    OutlinedButton(onPressed: (){
                      setState(() {
                        cakeWeight = '2.0 Pounds';
                      });

                    }, child: Text('2.0 Pounds', style: TextStyle(fontWeight: cakeWeight == '2.0 Pounds' ? FontWeight.bold : FontWeight.w100),)),

                    const SizedBox(width: 20,),
                  ],
                ),
              ),
            ),

            // Text(Cakes_List[widget.index1].ingredients.toString(), style: TextStyle(color: Colors.black),),

            // ElevatedButton(onPressed: (){
            //   print(Cakes_List[widget.index1].description);
            //   }, child: Text('print description'))


            // GestureDetector(
            //   child: Container(
            //     height: productDetails_Collapsible_ContainerHeight,
            //     width: 800,
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: const Text('Product Details', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),),
            //     ),
            //
            //   ),
            //   onTap: (){
            //     setState(() {
            //       productDetails_Collapsible_ContainerHeight = 70;
            //     });
            //     print('Button was clicked');
            //   },
            // ),
            // Row(
            //   children: [
            //     Text(convertToString(Cakes_List[widget.index1].ingredients), style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
            //   ],
            // )

            //Divider(thickness: 3, color: Colors.grey.shade200,),






            ExpansionTile(
              // shape: ShapeBorder(
              //
              // ),
              title: Text('Product Ingredients', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 190),
                  child: Text(convertToString(Cakes_List[widget.index1].ingredients), style: TextStyle(color: Colors.black),textAlign: TextAlign.start,),
                )
              ],
            ),

            Container(
              child: Text(returnFinalPrice().toString()),
            )

          ],
        ),

      )
    );
  }
}


