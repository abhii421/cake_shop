import 'package:capstone_1/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
final _allOrdersCollectionReference = _firestore.collection('Cake Orders');
final _myOrdersCollectionReference = _allOrdersCollectionReference.where('Customer UID', isEqualTo: userkaUID);
final FirebaseAuth _auth = FirebaseAuth.instance;

class UsersOrdersPage extends StatefulWidget {
  const UsersOrdersPage({super.key});

  @override
  State<UsersOrdersPage> createState() => _UsersOrdersPageState();
}

class _UsersOrdersPageState extends State<UsersOrdersPage> {



  @override
  void initState() {
    super.initState();
    //getUser();
  }

  // Future<void> getUser() async {
  //   user = _auth.currentUser;
  //   if (user != null) {
  //     await fetchCakeOrders();
  //   }
  // }

  // Future<void> fetchCakeOrders() async {
  //   final QuerySnapshot querySnapshot = await _firestore
  //       .collection('Cake Orders')
  //       .where('Customer UID', isEqualTo: userkaUID)
  //       .get();
  //
  //   setState(() {
  //     cakeOrders = querySnapshot.docs;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),


      body: Expanded(

        child: StreamBuilder(
          stream: _myOrdersCollectionReference.snapshots(),

          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasError){

                showDialog(context: context, builder: (context) {
                  return AlertDialog(title: Text('Error'),elevation: 15,content: Text('There is an error fetching your Orders'),);
                },);
              }

              if(snapshot.hasData){
                List <QueryDocumentSnapshot<Map<String, dynamic>>> listOfUserOrders = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: listOfUserOrders.length,
                  itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Map<String, dynamic>> singleUserOrder = listOfUserOrders[index];
                  return Card(
                    child: ExpansionTile(
                        title: Text(singleUserOrder['Cake Name']),
                        subtitle: Text('Weight: ${singleUserOrder['Cake Weight (in pounds)']} pounds | Topping: ${singleUserOrder['Topping Name']}'),
                        children: [
                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Cake Price'),
                                        trailing: Text(' ₹ ${singleUserOrder['Cake Price']}'
                                      ),
                                    ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Order ID'),
                                        trailing: Text('${singleUserOrder['Order ID']}'
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Order Accepted'),
                                        trailing: Text('${singleUserOrder['Order Accepted'].toString()}'),
                                      ),
                                    ),

                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Order Prepared'),
                                        trailing: Text('${singleUserOrder['Order Prepared']}'),
                                      ),
                                    ),

                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Order Dispatched'),
                                        trailing: Text('${singleUserOrder['Order Dispatched']}'),
                                      ),
                                    ),

                                    Card(
                                      elevation: 10,
                                      child: ListTile(
                                        leading: const Text('Order Delivered'),
                                        trailing: Text('${singleUserOrder['Order Delivered']}'
                                      ),
                                    ),
                                    )
                        ],
                    ),
                  );
                },
                );
              }

              if(snapshot.error == true){
                print('Error');
                showDialog(context: context, builder: (context) {
                  return AlertDialog(title: Text('Error'),elevation: 15,content: Text('There is an error fetching your Orders'),);
                },);
              }
            }


            return Container();

        },),
        // child: ListView.builder(
        //   itemCount: cakeOrders.length,
        //   itemBuilder: (context, index) {
        //     final order = cakeOrders[index].data() as Map<String, dynamic>;
        //     print(order);
        //     return Card(
        //       child: ExpansionTile(
        //
        //         title: Text(order['Cake Name']),
        //         subtitle: Text('Weight: ${order['Cake Weight (in pounds)']} pounds | Topping: ${order['Topping Name']}'),
        //         children: [
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Cake Price'),
        //               trailing: Text(' ₹ ${order['Cake Price']}'
        //             ),
        //           ),
        //           ),
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Order ID'),
        //               trailing: Text('${order['Order ID']}'
        //               ),
        //             ),
        //           ),
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Order Accepted (Tap the Icon to Refresh)'),
        //               //trailing: Text('${order['Order Accepted']}'
        //               trailing: IconButton(
        //                           onPressed: (){
        //                             setState(() {
        //
        //                             });
        //                             fetchCakeOrders();
        //                       },
        //                           icon: Icon(order['Order Accepted'] == true ? Icons.check_circle_sharp : Icons.close)
        //                 ),
        //               ),
        //             ),
        //
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Order Prepared (Tap the Icon to Refresh)'),
        //               //trailing: Text('${order['Order Accepted']}'
        //               trailing: IconButton(
        //                   onPressed: (){
        //                     setState(() {
        //
        //                     });
        //                     fetchCakeOrders();
        //                   },
        //                   icon: Icon(order['Order Prepared'] == true ? Icons.check_circle_sharp : Icons.close)
        //               ),
        //             ),
        //           ),
        //
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Order Dispatched (Tap the Icon to Refresh)'),
        //               //trailing: Text('${order['Order Accepted']}'
        //               trailing: IconButton(
        //                   onPressed: (){
        //                     setState(() {
        //
        //                     });
        //                     fetchCakeOrders();
        //                   },
        //                   icon: Icon(order['Order Dispatched'] == true ? Icons.check_circle_sharp : Icons.close)
        //               ),
        //             ),
        //           ),
        //
        //           Card(
        //             child: ListTile(
        //               leading: const Text('Order Delivered (Tap the Icon to Refresh)'),
        //               //trailing: Text('${order['Order Accepted']}'
        //               trailing: IconButton(
        //                   onPressed: (){
        //                     setState(() {
        //
        //                     });
        //                     fetchCakeOrders();
        //                   },
        //                   icon: Icon(order['Order Delivered'] == true ? Icons.check_circle_sharp : Icons.close)
        //               ),
        //             ),
        //           ),
        //         ],
        //
        //       ),
        //     );
        //
        //     // return ExpansionTile(title: order['Cake Name']);
        //     // return ElevatedButton(onPressed: (){print(order);}, child: Text('print'));
        //   },
        // ),
      ),
    );
  }
}
