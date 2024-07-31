import 'package:capstone_1/screens/homepage.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  
  

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
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
              Card(child: ListTile(trailing: Text(userkaPhoneNumber.toString()),leading: const Text('Phone Number'),)),
              const SizedBox(height : 20),
              Card(child: ListTile(leading: const Text('Address'),trailing: Text(userkaAddress.toString()),))
            ],
          ),
        ),
    );
  }
}
