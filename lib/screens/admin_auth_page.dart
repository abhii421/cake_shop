import 'package:capstone_1/screens/admin_home_screen.dart';
import 'package:capstone_1/screens/homepage.dart';
import 'package:flutter/material.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({super.key});

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}


TextEditingController passwordController = TextEditingController();


class _AdminAuthPageState extends State<AdminAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height : 200),
            const Padding(
              padding: const EdgeInsets.all(13.0),
              child:  Text('Enter the Admin Password           (Not for Users)', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                    hintText: 'Admin Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
            ),
            SizedBox(height : 200),
            ElevatedButton(onPressed: (){
              if(passwordController.text == '12345'){

                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                  return AdminHomePage();
                },));
                adminLoggedIn = 1;
                passwordController.text = '';
              }
              else {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(contentPadding: EdgeInsets.all(20),
                    title: Text('Wrong Password'),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            passwordController.text = '';
                           },
                          child: const Text('Okay'))
                    ],
                  );
                },
               );
              }
            }, child: const Text('Enter the admin Panel')),
            SizedBox(height : 100),
            Text('Enter 12345 as password'),

          ],
        ),
      ),
    );
  }
}
