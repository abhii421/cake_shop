import 'package:flutter/material.dart';


class RatingStarsBox extends StatefulWidget {
  const RatingStarsBox({super.key});

  @override
  State<RatingStarsBox> createState() => _RatingStarsBoxState();
}


void getAvgRating(){}


class _RatingStarsBoxState extends State<RatingStarsBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16,),
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreenAccent]),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [

                  Text('4.3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                  //SizedBox(width: 4,),
                                  Padding(
                                    padding: const EdgeInsets.only(left : 2.0),
                                    child: Icon(Icons.star_rounded, color:Colors.white,size: 25,),
                                  ),
                  SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
