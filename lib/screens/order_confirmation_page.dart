import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/data/all_toppings_list.dart';
import 'package:capstone_1/screens/homepage.dart';
import 'package:capstone_1/screens/order_done_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:capstone_1/screens/user_profile_screen.dart';


class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({super.key, required this.totalPrice, required this.cakeToppingIndex, required this.cakeSize,required this.cakeNameIndex });

  final double totalPrice;
  final int cakeNameIndex;
  final int cakeToppingIndex;
  final double cakeSize;

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}


final _firestore = FirebaseFirestore.instance;
final _firebase = FirebaseAuth.instance;


Future<void> sendOrdersToFirebase() async{
  
}

String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
          (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: deviceWidth*0.03, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset(height: deviceHeight/4,
                      Cakes_List[widget.cakeNameIndex].imgPath,
                    width: deviceWidth*0.45,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(width: 15,),
                    Image.network(toppingsList[widget.cakeToppingIndex].imageNetworkAddress,
                      height: deviceHeight/4,
                      width: deviceWidth*0.45,
                      fit: BoxFit.scaleDown,
                    ),
                ],),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Cake Flavour', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  const Text('Topping', style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                ],
              ),
              SizedBox(height : 25),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(child: ListTile(leading: Text('Total Price'), trailing: Text(widget.totalPrice.toString())),),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(child: ListTile(leading: Text('Cake Flavour'),trailing: Text(Cakes_List[widget.cakeNameIndex].name))),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(child: ListTile(leading: Text('Cake Topping'),trailing: Text(toppingsList[widget.cakeToppingIndex].toppingName))),
              ),


              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(child: ListTile(leading: Text('Weight (in pounds)'),trailing: Text(widget.cakeSize.toString()))),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: Card(

                    child: ListTile(leading: Text('Phone Number'),trailing: Text(userkaPhoneNumber.toString()))),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    child: ExpansionTile(
                        title: Text(
                          'Address', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                      children: [
                        Text(userkaAddress.toString())
                      ],
                    )),
              ),

              const SizedBox(height : 25),
              ElevatedButton(onPressed: () async {

                try{

                  await _firestore.collection('Cake Orders').add(
                      {
                    'Order ID' : generateRandomString(10),
                    'Cake Name' : Cakes_List[widget.cakeNameIndex].name.toString(),
                    'Topping Name' : toppingsList[widget.cakeToppingIndex].toppingName.toString(),
                    'Cake Price' : widget.totalPrice.toString(),
                    'Cake Weight (in pounds)' : widget.cakeSize.toString(),
                    'Customer UID' : userkaUID,
                    'Customer Phone Number' : userNum,
                    'Delivery Address' : userkaAddress,
                    'Customer Name' : userkaName,
                    'Order Accepted' : false,
                    'Order Prepared' : false,
                    'Order Dispatched' : false,
                    'Order Delivered' : false

                  });
                 
                }

                catch(err){

                  print(err.toString());
                }
                
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                  return OrderConfirmedPage();
                  },
                )
                );


              },
                  child: const Text('Confirm Order'))

            ],
          ),
        ),
      ),
    );
  }
}





















// const SizedBox(height: 30,),
// Row(
//   children: [
//     Text('Total Price    '),
//     //SizedBox(width: 4,),
//     Text(widget.totalPrice.toString()),
//   ],
// ),
// Row(
//   children: [
//     Text('Weight   '),
//     Text(widget.cakeSize.toString()),
//     Text('  Pounds'),
//   ],
// ),
// // Container(
// //   child: Image(image: AssetImage(imagePaths[widget.cakeNameIndex]))
// //   ,),
// Text(toppingsList[widget.cakeToppingIndex].toppingName),
// Container(
//   width: 60,
//   height: 60,
//   child: Image.network(toppingsList[widget.cakeToppingIndex].imageNetworkAddress),
// ),
// //Text(widget.cakeToppingIndex.toString()),
// Text(widget.cakeNameIndex.toString()),
// Image.asset(Cakes_List[widget.cakeNameIndex].imgPath),
