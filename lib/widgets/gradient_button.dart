import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.buttonText, required this.widthDevice, required this.lengthDevice});


  final String buttonText;
  final double widthDevice;
  final double lengthDevice;
  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;


    return Container(
      width: deviceWidth*widthDevice,//0.6
      height: deviceHeight*lengthDevice,//0.06
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176),

            /*Color.fromARGB(255, 178, 154, 211),*/ Colors.purpleAccent.shade100.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          //color: Colors.purpleAccent.shade100.withOpacity(0.2),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Center(
          child: Text(buttonText,
            style: const TextStyle(
                color: Colors.white, fontSize: 23,
                fontWeight: FontWeight.w200),)),
    );
  }
}
