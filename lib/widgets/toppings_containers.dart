// import 'package:capstone_1/data/all_toppings_list.dart';
// import 'package:capstone_1/screens/cake_details_screen.dart';
// import 'package:flutter/material.dart';
//
// double toppingsCostToBePassed = 0;
//
// class ToppingsContainer extends StatefulWidget {
//   const ToppingsContainer({super.key, required this.indexOfToppingsList, required this.indexOfCakeList, required this.weightOfCake, required this.onToppingSelected});
//   final int indexOfToppingsList;
//   final int indexOfCakeList;
//   final double weightOfCake;
//   final Function(double) onToppingSelected;
//
//   @override
//   State<ToppingsContainer> createState() => _ToppingsContainerState();
// }
//
// class _ToppingsContainerState extends State<ToppingsContainer> {
//   @override
//   Widget build(BuildContext context) {
//     var deviceWidth = MediaQuery.of(context).size.width;
//     var deviceHeight = MediaQuery.of(context).size.height;
//
//
//
//
//     double findToppingsCost(int index3){
//       print('This is the index of the toppings row - $index3');
//       print('This is the price of the topping at that index ');
//       print(toppingsList[index3].price.toString());
//
//       setState(() {
//         toppingsCostToBePassed =  toppingsList[index3].price.toDouble();
//       });
//
//
//       print('Updated toppings cost to be passed - $toppingsCostToBePassed');
//       //print(toppingsCostToBePassed);
//       return toppingsCostToBePassed;
//     }
//
//
//
//
//   }
// }
