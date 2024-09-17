import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllOrdersAdminScreen extends StatefulWidget {
  @override
  _AllOrdersAdminScreenState createState() => _AllOrdersAdminScreenState();
}

class _AllOrdersAdminScreenState extends State<AllOrdersAdminScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> cakeOrders = [];

  @override
  void initState() {
    super.initState();
    fetch_CakeOrders();
  }

  Future<void> fetch_CakeOrders() async {

    try{
      final QuerySnapshot querySnapshot = await _firestore.collection('Cake Orders').get();

      setState(() {
        cakeOrders = querySnapshot.docs;
      });
    } catch (error){
      showDialog(context: context, builder: (context) {

        return AlertDialog(
          actions: [],
          content: Text('$error'),
          contentPadding: const EdgeInsets.all(20),
          title: const Text('error'),
        );
      },
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cake Orders'),
        ),
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                fetch_CakeOrders();
              },
              child: const Text('Refresh')),

          Expanded(
            child: ListView.builder(
                itemCount: cakeOrders.length,
                itemBuilder: (context, index) {
                  final documentData1 = cakeOrders[index];
                  return ExpansionTile(

                    tilePadding: const EdgeInsets.all(5),
                    title: Text(documentData1['Cake Name'] ?? ''),
                    subtitle: Text(documentData1['Delivery Address'] ?? ''),
                    children: [


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Text('Customer Name'),
                            trailing:
                                Text(documentData1['Customer Name'] ?? ''),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Text('Cake Price'),
                            trailing: Text(documentData1['Cake Price'] ?? ''),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Text('Cake Weight (in Pounds)'),
                            trailing: Text(
                                documentData1['Cake Weight (in pounds)'] ?? ''),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text('Topping Name'),
                            trailing: Text(documentData1['Topping Name'] ?? ''),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                              leading: const Text('Customer Phone Number'),
                              trailing:
                                  Text(documentData1['Customer Phone Number'])),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Text('Customer UID'),
                            trailing: Text(documentData1['Customer UID'] ?? ''),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: const Text('Order ID'),
                            trailing: Text(documentData1['Order ID'] ?? ''),
                          ),
                        ),
                      ),


                    ],
                  );
                }),
          )
        ]));
  }
}
