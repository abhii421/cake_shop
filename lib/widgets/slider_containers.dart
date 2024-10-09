import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/screens/cake_details_screen.dart';
import 'package:flutter/material.dart';

class SliderContainers extends StatelessWidget {
  const SliderContainers({super.key, required this.assetPath, required this.cakeName, required this.index});

  final String assetPath;
  final String cakeName;
  final int index;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        
        child: InkWell(
          child: Container(decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176), Color.fromARGB(255, 178, 154, 211),],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                             ),
            borderRadius: BorderRadius.circular(20)
          ),
            width: deviceWidth*0.48,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset(assetPath, width: 150, height: 150, fit: BoxFit.scaleDown,alignment: Alignment.topRight),
                ),
                const SizedBox(height: 18,),
                Padding(
                  padding: const EdgeInsets.only(left: 17),
                  child: Text(cakeName, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),),
                )
            ],
          ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CakeDetailsScreen(index1: index);
            },));
          },
        ),
      );







    // return InkWell(
    //   child: SizedBox(
    //     height: 270,
    //       child: Container(
    //         height: 270,
    //
    //         decoration: const BoxDecoration(
    //               gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176), Color.fromARGB(255, 178, 154, 211),],
    //                   begin: Alignment.topLeft,
    //                   end: Alignment.bottomRight
    //                       ),
    //               borderRadius: BorderRadius.all(Radius.circular(20))
    //             ),
    //
    //                   child: Column(
    //                     children: [
    //                       Image.asset(assetPath,
    //                         fit: BoxFit.scaleDown,
    //                         alignment: Alignment.topRight,
    //                         height: 100,
    //                         width: 100,
    //                        )
    //                   ],
    //                 )
    //               ),
    //             ),
    //           );
  }
}









//return Container(
//   height: 270,
//   child: InkWell(
//       child: Container(
//           height: 270,
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [Color.fromARGB(150, 234, 132, 176), Color.fromARGB(255, 178, 154, 211),],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(20))
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 200,
//                 width: 200,
//                 child: Image.asset(assetPath,
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.topRight,
//                 ),
//               )
//             ],
//           )
//       ),
//       onTap: () {
//         //cakeSelected();
//       }
//   ),
// );
