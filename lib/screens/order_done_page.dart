import 'package:flutter/material.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(

            children: [

              SizedBox(height: 199,),
              Text(
                'Order Confirmed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Container(
                height: 40,
                width: 40,
                child: Icon(Icons.check_circle_rounded),)
            ],
          ),
        ],
      ),
    );
  }
}
