import 'package:capstone_1/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
final firebase = FirebaseAuth.instance;


class UsersOrdersPage extends StatefulWidget {
  const UsersOrdersPage({super.key});

  @override
  State<UsersOrdersPage> createState() => _UsersOrdersPageState();
}

class _UsersOrdersPageState extends State<UsersOrdersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  User? user;
  List<QueryDocumentSnapshot> cakeOrders = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    user = _auth.currentUser;
    if (user != null) {
      await fetchCakeOrders();
    }
  }

  Future<void> fetchCakeOrders() async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('Cake Orders')
        .where('Customer UID', isEqualTo: userkaUID)
        .get();

    setState(() {
      cakeOrders = querySnapshot.docs;
    });
  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          IconButton(
              onPressed: (){
                      getUser();
                },
              icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: cakeOrders.length,
          itemBuilder: (context, index) {
            final order = cakeOrders[index].data() as Map<String, dynamic>;
            print(order);
            return Card(
              child: ExpansionTile(
              
                title: Text(order['Cake Name']),
                subtitle: Text('Weight: ${order['Cake Weight (in pounds)']} pounds | Topping: ${order['Topping Name']}'),
                children: [
                  Card(
                    child: ListTile(
                      leading: const Text('Cake Price'),
                      trailing: Text(' ₹ ${order['Cake Price']}'
                    ),
                  ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Text('Order ID'),
                      trailing: Text('${order['Order ID']}'
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Text('Order Accepted (Tap the Icon to Refresh)'),
                      //trailing: Text('${order['Order Accepted']}'
                      trailing: IconButton(
                                  onPressed: (){
                                    setState(() {

                                    });
                                    fetchCakeOrders();
                              },
                                  icon: Icon(order['Order Accepted'] == true ? Icons.check_circle_sharp : Icons.close)
                        ),
                      ),
                    ),

                  Card(
                    child: ListTile(
                      leading: const Text('Order Prepared (Tap the Icon to Refresh)'),
                      //trailing: Text('${order['Order Accepted']}'
                      trailing: IconButton(
                          onPressed: (){
                            setState(() {

                            });
                            fetchCakeOrders();
                          },
                          icon: Icon(order['Order Prepared'] == true ? Icons.check_circle_sharp : Icons.close)
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Text('Order Dispatched (Tap the Icon to Refresh)'),
                      //trailing: Text('${order['Order Accepted']}'
                      trailing: IconButton(
                          onPressed: (){
                            setState(() {

                            });
                            fetchCakeOrders();
                          },
                          icon: Icon(order['Order Dispatched'] == true ? Icons.check_circle_sharp : Icons.close)
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Text('Order Delivered (Tap the Icon to Refresh)'),
                      //trailing: Text('${order['Order Accepted']}'
                      trailing: IconButton(
                          onPressed: (){
                            setState(() {

                            });
                            fetchCakeOrders();
                          },
                          icon: Icon(order['Order Delivered'] == true ? Icons.check_circle_sharp : Icons.close)
                      ),
                    ),
                  ),
                ],
                
              ),
            );

            // return ExpansionTile(title: order['Cake Name']);
            // return ElevatedButton(onPressed: (){print(order);}, child: Text('print'));
          },
        ),
      ),
    );
  }
}
