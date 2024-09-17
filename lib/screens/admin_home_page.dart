import 'package:capstone_1/screens/all_orders_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Map<String, dynamic>> documents = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cake Orders')
        .where('Order Delivered', isEqualTo: false)
        .get();

    setState(() {
      documents = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> updateOrderAcceptedField(String orderId, String fieldName) async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Cake Orders').where('Order ID', isEqualTo: orderId).get();



    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      final currentFieldValue = querySnapshot.docs.first.data()[fieldName] ?? false;

      await FirebaseFirestore.instance
          .collection('Cake Orders')
          .doc(docId)
          .update({fieldName: !currentFieldValue});
    } else



    {
      print('gadbad');
      print('*****************************************************************');
    }
  }

  Future<void> updateOrderPreparedField(String orderId, String fieldName) async {
    final querySnapshot = await FirebaseFirestore.instance.collection('Cake Orders').where('Order ID', isEqualTo: orderId).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      final currentFieldValue =
          querySnapshot.docs.first.data()[fieldName] ?? false;

      await FirebaseFirestore.instance
          .collection('Cake Orders')
          .doc(docId)
          .update({fieldName: !currentFieldValue});
    } else {
      print('gadbad');
    }
  }

  Future<void> updateOrderDispatchedField(
      String orderId, String fieldName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cake Orders')
        .where('Order ID', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      final currentFieldValue =
          querySnapshot.docs.first.data()[fieldName] ?? false;

      await FirebaseFirestore.instance
          .collection('Cake Orders')
          .doc(docId)
          .update({fieldName: !currentFieldValue});
    } else {
      print('gadbad');
    }
  }

  Future<void> updateOrderDeliveredField(
      String orderId, String fieldName) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cake Orders')
        .where('Order ID', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      final currentFieldValue =
          querySnapshot.docs.first.data()[fieldName] ?? false;

      await FirebaseFirestore.instance
          .collection('Cake Orders')
          .doc(docId)
          .update({fieldName: !currentFieldValue});
    } else {
      print('gadbad');
    }
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Delivery Panel')),
      body: SingleChildScrollView(
        child: Column(
            children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    fetchData();
                  },
                  child: const Text('Refresh')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return AllOrdersAdminScreen();
                      },
                    ));
                  },
                  child: const Text(('All orders')))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final documentData = documents[index];
                return ExpansionTile(
                  tilePadding: EdgeInsets.all(5),
                  title: Text(documentData['Cake Name'] ?? ''),
                  // Replace with your field names
                  subtitle: Text(documentData['Delivery Address'] ?? ''),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: Card(
                        child: ListTile(
                          leading: const Text('Customer Name'),
                          trailing: Text(documentData['Customer Name'] ?? ''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Text('Cake Price'),
                          trailing: Text(documentData['Cake Price'] ?? ''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Text('Cake Weight (in Pounds)'),
                          trailing:
                              Text(documentData['Cake Weight (in pounds)'] ?? ''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Text('Topping Name'),
                          trailing: Text(documentData['Topping Name'] ?? ''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                            leading: const Text('Customer Phone Number'),
                            trailing:
                                Text(documentData['Customer Phone Number'])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Text('Customer UID'),
                          trailing: Text(documentData['Customer UID'] ?? ''),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Text('Order ID'),
                          trailing: Text(documentData['Order ID'] ?? ''),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text('Accept the Order'),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          updateOrderAcceptedField(
                              documentData['Order ID'], 'Order Accepted');
                          fetchData();
                          print(documentData['Order Accepted'].toString());
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Text(
                                      "Order Accepted - ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      documentData['Order Accepted'].toString(),
                                      style: const TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Okay'))
                                ],
                              );
                            },
                          );
                          //accepted = !accepted;
                        });
                      },
                    ),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text('Prepared the Order?'),
                            //trailing: Text(prepared == true ? 'Prepared' : 'Not Prepared Yet')
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          //prepared = !prepared;

                          updateOrderPreparedField(
                              documentData['Order ID'], 'Order Prepared');
                          fetchData();
                          print(documentData['Order Prepared'].toString());

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Text(
                                      "Order Prepared - ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      (!documentData['Order Prepared'])
                                          .toString(),
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'))
                                ],
                              );
                            },
                          );
                        });
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text('Dispatched the Order?'),
                            //trailing: Text(dispatched == true ? 'Dispatched' : 'Not Dispatched Yet')
                          ),
                        ),
                      ),
                      onTap: () {
                        updateOrderDispatchedField(
                            documentData['Order ID'], 'Order Dispatched');
                        fetchData();
                        //print(documentData['Order Prepared'].toString());

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Text(
                                    "Order Dispatched - ",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    (!documentData['Order Dispatched'])
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Okay'))
                              ],
                            );
                          },
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text('Delivered the Order?'),
                            //trailing: Text(delivered == true ? 'Delivered' : 'Not Delivered Yet')
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          updateOrderDeliveredField(
                              documentData['Order ID'], 'Order Delivered');
                          fetchData();

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Text(
                                      "Order Delivered - ",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      (!documentData['Order Delivered'])
                                          .toString(),
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Okay'))
                                ],
                              );
                            },
                          );
                          //delivered = !delivered;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
