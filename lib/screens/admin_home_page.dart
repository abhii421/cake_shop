import 'package:capstone_1/widgets/cake_order_tile.dart';
import 'package:capstone_1/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_1/screens/all_orders_admin_screen.dart';


final _firestore = FirebaseFirestore.instance;
final _ordersCollectionReference = _firestore.collection('Cake Orders');
final _activeOrdersCollectionReference = _ordersCollectionReference.where('Order Delivered', isEqualTo: false);

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(elevation: 10,title: const Text('Current Orders'),),
      body:


      Column(
        children: [
          Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
                 onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                     return AllOrdersAdminScreen();
                   },));
                 },
                 child: const GradientButton(buttonText: 'All Orders History', lengthDevice: 0.08,widthDevice: 0.8,)),
           ),
          Expanded(
            child: StreamBuilder(stream: _activeOrdersCollectionReference.snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  else if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData == false){
                      print('No data in orders collection');
                    }
                      if(snapshot.hasData){
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> _listOfActiveOrders = snapshot.data!.docs;

                        return ListView.builder(

                          itemCount: _listOfActiveOrders.length,
                          itemBuilder: (context, index) {
                              /*QueryDocumentSnapshot<Map<String, dynamic>>*/ var docOfSingleActiveOrder = _listOfActiveOrders[index];
                              String cakeName = docOfSingleActiveOrder['Cake Name'].toString() ?? '';
                              String cakesTopping =  docOfSingleActiveOrder['Topping Name'].toString() ?? '';
                              String cakesPrice = docOfSingleActiveOrder['Cake Price'].toString() ?? '';
                              String cakesWeight = docOfSingleActiveOrder['Cake Weight (in pounds)'].toString();

                            return Card(
                              child: ExpansionTile(

                                title: Text(cakeName),
                                tilePadding: const EdgeInsets.all(5),
                                subtitle: Text("$cakesTopping       ||        ₹$cakesPrice"),
                                leading: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('$cakesWeight lb', style: TextStyle(fontSize: 14),),
                                ),
                                shape: Border.all(color: Colors.white, width: 0.1),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,
                                        leading: const Text('Customer Name'), trailing: Text(docOfSingleActiveOrder['Customer Name'].toString()),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,
                                        leading: const Text('Customer Phone Number'), trailing: Text(docOfSingleActiveOrder['Customer Phone Number'].toString() ?? 'Unavailable'),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,
                                        leading: const Text('Order ID'), trailing: Text(docOfSingleActiveOrder['Order ID'].toString()),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,
                                        leading: const Text('Delivery Address'), trailing: Text(docOfSingleActiveOrder['Delivery Address'].toString()),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,

                                        leading: const Text('Order Accepted'), trailing: Checkbox(value: docOfSingleActiveOrder['Order Accepted'] ?? false,
                                          onChanged: (value)  {
                                            //docOfSingleActiveOrder.['Order Accepted' = !value];
                                            //docOfSingleActiveOrder['Order Accepted'] = value;
                                            //_activeOrdersCollectionReference.doc(docOfSingleActiveOrder.id).update({'Order Accepted' : !value!});

                                            value = docOfSingleActiveOrder['Order Accepted'];
                                            var docID = docOfSingleActiveOrder.id;
                                            //setState(() {
                                              _ordersCollectionReference.doc(docID).update({'Order Accepted' : !value!});
                                            //});

                                            print(value);
                                            print('tapped*********************************');
                                          },)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,

                                          leading: const Text('Order Prepared'), trailing: Checkbox(value: docOfSingleActiveOrder['Order Prepared'] ?? false,
                                        onChanged: (value)  {
                                          //docOfSingleActiveOrder.['Order Accepted' = !value];
                                          //docOfSingleActiveOrder['Order Accepted'] = value;
                                          //_activeOrdersCollectionReference.doc(docOfSingleActiveOrder.id).update({'Order Accepted' : !value!});

                                          value = docOfSingleActiveOrder['Order Prepared'];
                                          var docID = docOfSingleActiveOrder.id;
                                          //setState(() {
                                            _ordersCollectionReference.doc(docID).update({'Order Prepared' : !value!});
                                          //});

                                          print(value);
                                          print('tapped*********************************');
                                        },)),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,
                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,

                                          leading: const Text('Order Dispatched'), trailing: Checkbox(value: docOfSingleActiveOrder['Order Dispatched'] ?? false,
                                        onChanged: (value)  {
                                          //docOfSingleActiveOrder.['Order Accepted' = !value];
                                          //docOfSingleActiveOrder['Order Accepted'] = value;
                                          //_activeOrdersCollectionReference.doc(docOfSingleActiveOrder.id).update({'Order Accepted' : !value!});

                                          value = docOfSingleActiveOrder['Order Dispatched'];
                                          var docID = docOfSingleActiveOrder.id;
                                          //setState(() {
                                            _ordersCollectionReference.doc(docID).update({'Order Dispatched' : !value!});
                                          //});

                                          print(value);
                                          print('tapped*********************************');
                                        },)),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                                    child: Card(
                                      elevation: 7,

                                      //color: Colors.purpleAccent.withOpacity(0.1),
                                      child: ListTile(
                                        //focusColor: Colors.green,

                                          leading: const Text('Order Delivered'), trailing: Checkbox(value: docOfSingleActiveOrder['Order Delivered'] ?? false,
                                        onChanged: (value)  {
                                          //docOfSingleActiveOrder.['Order Accepted' = !value];
                                          //docOfSingleActiveOrder['Order Accepted'] = value;
                                          //_activeOrdersCollectionReference.doc(docOfSingleActiveOrder.id).update({'Order Accepted' : !value!});

                                          value = docOfSingleActiveOrder['Order Delivered'];
                                          var docID = docOfSingleActiveOrder.id;
                                          //setState(() {
                                            _ordersCollectionReference.doc(docID).update({'Order Delivered' : !value!});
                                          //});

                                          print(value);
                                          print('tapped*********************************');
                                        },)),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      }
                  }

                  return Container();

                },),
          ),
        ],
      ),

    );
  }
}




// import 'package:capstone_1/screens/all_orders_admin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});
//
//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }
//
// class _AdminHomePageState extends State<AdminHomePage> {
//   List<Map<String, dynamic>> documents = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('Cake Orders')
//         .where('Order Delivered', isEqualTo: false)
//         .get();
//
//     setState(() {
//       documents = querySnapshot.docs.map((doc) => doc.data()).toList();
//     });
//   }
//
//   Future<void> updateOrderAcceptedField(String orderId, String fieldName) async {
//     final querySnapshot = await FirebaseFirestore.instance.collection('Cake Orders').where('Order ID', isEqualTo: orderId).get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs.first.id;
//       final currentFieldValue = querySnapshot.docs.first.data()[fieldName] /*?? false*/;
//
//       await FirebaseFirestore.instance.collection('Cake Orders').doc(docId).update({fieldName: !currentFieldValue});
//       final currentFieldValue1 = querySnapshot.docs.first.data()[fieldName];
//       print('*****************************************************************');
//       print('Order Accepted');
//       print(currentFieldValue1);
//     }
//     else {
//       print('gadbad');
//       print('*****************************************************************');
//     }
//   }
//
//   Future<void> updateOrderPreparedField(String orderId, String fieldName) async {
//     final querySnapshot = await FirebaseFirestore.instance.collection('Cake Orders').where('Order ID', isEqualTo: orderId).get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs.first.id;
//       final currentFieldValue = querySnapshot.docs.first.data()[fieldName] /*?? false*/;
//
//       await FirebaseFirestore.instance.collection('Cake Orders').doc(docId).update({fieldName: !currentFieldValue});
//       final currentFieldValue1 = querySnapshot.docs.first.data()[fieldName];
//       print('#######################################################################');
//       print('Order Prepared');
//       print(currentFieldValue1);
//
//     } else {
//       print('gadbad');
//     }
//   }
//
//   Future<void> updateOrderDispatchedField(String orderId, String fieldName) async {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('Cake Orders')
//         .where('Order ID', isEqualTo: orderId)
//         .get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs.first.id;
//       final currentFieldValue = querySnapshot.docs.first.data()[fieldName] ?? false;
//
//       await FirebaseFirestore.instance
//           .collection('Cake Orders')
//           .doc(docId)
//           .update({fieldName: !currentFieldValue});
//     } else {
//       print('gadbad');
//     }
//   }
//
//   Future<void> updateOrderDeliveredField(String orderId, String fieldName) async {
//     final querySnapshot = await FirebaseFirestore.instance.collection('Cake Orders').where('Order ID', isEqualTo: orderId).get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final docId = querySnapshot.docs.first.id;
//       final currentFieldValue = querySnapshot.docs.first.data()[fieldName] ?? false;
//
//       await FirebaseFirestore.instance.collection('Cake Orders').doc(docId).update({fieldName: !currentFieldValue});
//     } else {
//       print('gadbad');
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Delivery Panel')),
//       body: Column(
//           children: [
//         const SizedBox(height: 10,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   fetchData();
//                 },
//                 child: const Text('Refresh')),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) {
//                       return AllOrdersAdminScreen();
//                     },
//                   ));
//                 },
//                 child: const Text(('All orders')))
//           ],
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               final documentData = documents[index];
//               return ExpansionTile(
//                 tilePadding: EdgeInsets.all(5),
//                 title: Text(documentData['Cake Name'] ?? ''),
//                 // Replace with your field names
//                 subtitle: Text(documentData['Delivery Address'] ?? ''),
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Customer Name'),
//                         trailing: Text(documentData['Customer Name'] ?? ''),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Cake Price'),
//                         trailing: Text(documentData['Cake Price'] ?? ''),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Cake Weight (in Pounds)'),
//                         trailing:
//                             Text(documentData['Cake Weight (in pounds)'] ?? ''),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Topping Name'),
//                         trailing: Text(documentData['Topping Name'] ?? ''),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                           leading: const Text('Customer Phone Number'),
//                           trailing:
//                               Text(documentData['Customer Phone Number'])),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Customer UID'),
//                         trailing: Text(documentData['Customer UID'] ?? ''),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: const Text('Order ID'),
//                         trailing: Text(documentData['Order ID'] ?? ''),
//                       ),
//                     ),
//                   ),
//
//
//
//
//
//
//
//
//
//
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: ListTile(
//                           leading: Text('Accept the Order?'),
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         fetchData();
//                         updateOrderAcceptedField(
//                             documentData['Order ID'], 'Order Accepted');
//
//                         print(documentData['Order Accepted'].toString());
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Row(
//                                 children: [
//                                   Text(
//                                     "Order Accepted - ",
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                   Text(
//                                     documentData['Order Accepted'].toString(),
//                                     style: const TextStyle(fontSize: 15),
//                                   )
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text('Okay'))
//                               ],
//                             );
//                           },
//                         );
//                         //accepted = !accepted;
//                       });
//                     },
//                   ),
//                   InkWell(
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Card(
//                         child: ListTile(
//                           leading: Text('Prepared the Order?'),
//                           //trailing: Text(prepared == true ? 'Prepared' : 'Not Prepared Yet')
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         //prepared = !prepared;
//                         fetchData();
//                         updateOrderPreparedField(
//                             documentData['Order ID'], 'Order Prepared');
//
//                         print(documentData['Order Prepared'].toString());
//
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Row(
//                                 children: [
//                                   Text(
//                                     "Order Prepared - ",
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                   Text(
//                                     (!documentData['Order Prepared'])
//                                         .toString(),
//                                     style: TextStyle(fontSize: 15),
//                                   )
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('Okay'))
//                               ],
//                             );
//                           },
//                         );
//                       });
//                     },
//                   ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: ListTile(
//                           leading: Text('Dispatched the Order?'),
//                           //trailing: Text(dispatched == true ? 'Dispatched' : 'Not Dispatched Yet')
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       fetchData();
//                       updateOrderDispatchedField(
//                           documentData['Order ID'], 'Order Dispatched');
//
//                       //print(documentData['Order Prepared'].toString());
//
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Row(
//                               children: [
//                                 const Text(
//                                   "Order Dispatched - ",
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                                 Text(
//                                   (!documentData['Order Dispatched'])
//                                       .toString(),
//                                   style: TextStyle(fontSize: 15),
//                                 )
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('Okay'))
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   InkWell(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: ListTile(
//                           leading: Text('Delivered the Order?'),
//                           //trailing: Text(delivered == true ? 'Delivered' : 'Not Delivered Yet')
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         fetchData();
//                         updateOrderDeliveredField(
//                             documentData['Order ID'], 'Order Delivered');
//
//
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Row(
//                                 children: [
//                                   Text(
//                                     "Order Delivered - ",
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                   Text(
//                                     (!documentData['Order Delivered'])
//                                         .toString(),
//                                     style: TextStyle(fontSize: 15),
//                                   )
//                                 ],
//                               ),
//                               actions: [
//                                 TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text('Okay'))
//                               ],
//                             );
//                           },
//                         );
//                         //delivered = !delivered;
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ]),
//     );
//   }
// }
