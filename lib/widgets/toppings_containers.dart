import 'package:capstone_1/data/all_toppings_list.dart';
import 'package:capstone_1/screens/cake_details_screen.dart';
import 'package:flutter/material.dart';

double toppingsCostToBePassed = 0;

class ToppingsContainer extends StatefulWidget {
  const ToppingsContainer({super.key, required this.indexOfToppingsList, required this.indexOfCakeList, required this.weightOfCake});
  final int indexOfToppingsList;
  final int indexOfCakeList;
  final double weightOfCake;

  @override
  State<ToppingsContainer> createState() => _ToppingsContainerState();
}

class _ToppingsContainerState extends State<ToppingsContainer> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;




    double findToppingsCost(int index3){
      print('This is the index of the toppings row - $index3');
      print('This is the price of the topping at that index ');
      print(toppingsList[index3].price.toString());

      setState(() {
        toppingsCostToBePassed =  toppingsList[index3].price.toDouble();
      });


      print('Updated toppings cost to be passed - $toppingsCostToBePassed');
      //print(toppingsCostToBePassed);
      return toppingsCostToBePassed;
    }



    return Padding(
        padding: const EdgeInsets.all(10),
            child: InkWell(
              child: Container(
                  height: deviceHeight/4.7,
                  width: deviceWidth*0.36,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: Colors.black,width: 2),
                  ),
                  child: Column(
                    children: [
                        SizedBox(
                          width: deviceWidth*0.38,
                          height: deviceHeight/7,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomRight: Radius.elliptical(25, 25),bottomLeft: Radius.elliptical(25, 25) ),
                            child: Image.network(toppingsList[widget.indexOfToppingsList].imageNetworkAddress,
                              fit: BoxFit.fill
                              ),
                          ),
                        ),
                      Text(toppingsList[widget.indexOfToppingsList].toppingName, style: const TextStyle(fontWeight: FontWeight.w600),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('₹'),
                          const SizedBox(width: 4),
                          Text(toppingsList[widget.indexOfToppingsList].price.toString(), style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                        ],
                      )
                    ],
                  ),
                      ),
              onTap: (){
                //findToppingsCost(widget.indexOfToppingsList);
                //getToppingsCost();

                returnFinalPrice(widget.indexOfCakeList, cakeWeight, findToppingsCost(widget.indexOfToppingsList));

              },
            ),
    );
  }
}
