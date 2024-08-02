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
    final QuerySnapshot querySnapshot = await _firestore.collection('Cake Orders').get();

    setState(() {
      cakeOrders = querySnapshot.docs;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cake Orders'),
      ),
      body: Column(
        children: [
    SizedBox(height: 10,),
    ElevatedButton(
    onPressed: (){
    fetch_CakeOrders();
    }
    , child: Text('Refresh')
    ),
    Expanded(
    child: ListView.builder(
    itemCount: cakeOrders.length,
    itemBuilder: (context, index) {
      final documentData1 = cakeOrders[index];
      return ExpansionTile(
        tilePadding: EdgeInsets.all(5),
        title: Text(documentData1['Cake Name'] ?? ''),
        // Replace with your field names
        subtitle: Text(documentData1['Delivery Address'] ?? ''),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('Customer Name'),
                trailing: Text(documentData1['Customer Name'] ?? ''),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('Cake Price'),
                trailing: Text(documentData1['Cake Price'] ?? ''),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('Cake Weight (in Pounds)'),
                trailing: Text(documentData1['Cake Weight (in pounds)'] ?? ''),
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
                  leading: Text('Customer Phone Number'),
                  trailing: Text(documentData1['Customer Phone Number'])
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('Customer UID'),
                trailing: Text(documentData1['Customer UID'] ?? ''),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('Order ID'),
                trailing: Text(documentData1['Order ID'] ?? ''),
              ),
            ),
          ),
        ],

      );
    }
      ),

      )
      ]
      )

    );
}
  }
