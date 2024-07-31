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
      final querySnapshot =
      await FirebaseFirestore.instance.collection('Cake Orders').where('Order Delivered', isEqualTo: false).get();

      setState(() {
        documents = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final documentData = documents[index];
            return ListTile(
              title: Text(documentData['title'] ?? ''), // Replace with your field names
              subtitle: Text(documentData['description'] ?? ''),
            );
          },
        ),
      );
    }
  }



