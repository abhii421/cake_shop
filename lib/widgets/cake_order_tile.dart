import 'package:flutter/material.dart';


class CakeOrderTile extends StatefulWidget {
  const CakeOrderTile({super.key});



  @override
  State<CakeOrderTile> createState() => _CakeOrderTileState();
}

class _CakeOrderTileState extends State<CakeOrderTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          children: [
            Row(children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cake : '),
            ), Spacer(), ],),
            Row(children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Weight : '),
            ), Spacer(), ],),
            Row(children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Phone Number : '),
            ), Spacer(), ],),
            Row(children: [Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Order ID : '),
            ), Spacer(), ],),

          ],
        ),
      ),
      // onTap: () {
      //    showDialog(context: context, builder: (context) {
      //      return Dialog(
      //        child: Column(
      //          children: [
      //
      //          ],
      //        ),
      //      );
      //    },);
      // },
    );
  }
}
