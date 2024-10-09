import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
final _ordersCollectionReference = _firestore.collection('Cake Orders');

class AllOrdersAdminScreen extends StatefulWidget {
  @override
  _AllOrdersAdminScreenState createState() => _AllOrdersAdminScreenState();
}

class _AllOrdersAdminScreenState extends State<AllOrdersAdminScreen> {

  @override
  void initState() {
    super.initState();
    //fetch_CakeOrders();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cake Orders'),
        ),
        body: Column(
            children: [
          // const SizedBox(
          //   height: 10,
          // ),
          // ElevatedButton(
          //     onPressed: () {
          //       fetch_CakeOrders();
          //     },
          //     child: const Text('Refresh')),

          Expanded(
            child: StreamBuilder(
              stream: _ordersCollectionReference.snapshots(),
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
                      List<QueryDocumentSnapshot<Map<String,dynamic>>> listOfAllOrders = snapshot.data!.docs;
                      return ListView.builder(

                          itemCount: listOfAllOrders.length,
                          itemBuilder: (context, index) {
                            final singleOrderDoc = listOfAllOrders[index];
                            return ExpansionTile(

                              tilePadding: const EdgeInsets.all(5),
                              title: Text(singleOrderDoc['Cake Name'] ?? ''),
                              subtitle: Text(singleOrderDoc['Delivery Address'] ?? ''),
                              children: [


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Text('Customer Name'),
                                      trailing:
                                      Text(singleOrderDoc['Customer Name'] ?? ''),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Text('Cake Price'),
                                      trailing: Text(singleOrderDoc['Cake Price'] ?? ''),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Text('Cake Weight (in Pounds)'),
                                      trailing: Text(
                                          singleOrderDoc['Cake Weight (in pounds)'] ?? ''),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: Text('Topping Name'),
                                      trailing: Text(singleOrderDoc['Topping Name'] ?? ''),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                        leading: const Text('Customer Phone Number'),
                                        trailing:
                                        Text(singleOrderDoc['Customer Phone Number'].toString())),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Text('Customer UID'),
                                      trailing: Text(singleOrderDoc['Customer UID'] ?? ''),
                                    ),
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Text('Order ID'),
                                      trailing: Text(singleOrderDoc['Order ID'] ?? ''),
                                    ),
                                  ),
                                ),


                              ],
                            );
                          }
                        );
                    }
                }

                return Container();
              },

            ),
          )
        ]));
  }
}
