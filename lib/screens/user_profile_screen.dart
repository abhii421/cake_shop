import 'package:capstone_1/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

int? userNum;

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  
  

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}



class _UserProfilePageState extends State<UserProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }


  Future<void> getUserData() async{

    final userUID = FirebaseAuth.instance.currentUser!.uid;

    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Cake Customers').where('User UID', isEqualTo: userUID).get()
        .then((snapshot) => snapshot.docs.first);


    if(userDoc.exists){
      setState(() {
        var data = userDoc.data() as Map<String, dynamic>;
        userkaName = data['Name'] as String;
        userkaAddress = data['Address'] as String;
        userNum = data['Phone Number'];
        print(data);
        print(userNum);
      });


    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const CircleAvatar(
                radius: 70,
                child: Icon(Icons.person, size : 90),),
              const SizedBox(height : 40),

              Card(child: ListTile(leading: const Text('Name'),trailing: Text(userkaName.toString()),)),
              const SizedBox(height : 20),
              Card(child: ListTile(leading: const Text('Phone Number'),trailing: Text(userNum.toString()),)),
              const SizedBox(height : 20),
              Card(child: ListTile(leading: const Text('Address'),trailing: Text(userkaAddress.toString()),)),
              // ElevatedButton(onPressed: (){
              //   getUserData();
              // }, child: Text('get user data')),
            ],
          ),
        ),
    );
  }
}
