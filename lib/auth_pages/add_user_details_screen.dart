import 'package:capstone_1/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddUserDetailsScreen extends StatefulWidget {
  const AddUserDetailsScreen({super.key});

  @override
  State<AddUserDetailsScreen> createState() => _AddUserDetailsScreenState();
}

String userName = '';
String userAddress = '';
String userNum = '';

TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

bool nameOkay = false;
bool addressOkay = false;
bool numberOkay = false;

final firestore = FirebaseFirestore.instance;
final firebase = FirebaseAuth.instance;


class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {

  final _userDetailsFormKey = GlobalKey<FormState>();


  void addUserInfoToFirestore() async {
    if(_userDetailsFormKey.currentState!.validate() == true){

      print(nameOkay);
      print(addressOkay);
      print(numberOkay);
      print(userName);
      print(userNum);
      //
      //
      // print('keh rha hai sara sahi hai ');



      _userDetailsFormKey.currentState!.save();
      String userUID = firebase.currentUser!.uid;

      await firestore.collection('Cake Customers').add({
        'Name' : userName,
        'Address' : userAddress,
        'Phone Number' : userNum,
        'User UID' : userUID
      });

      //await FirebaseAuth.instance.currentUser!.
      if(nameOkay == true && addressOkay == true && numberOkay == true){
        Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) {
          return homepage();
        },));
      }

    }

    else {
      // print(nameOkay);
      // print(addressOkay);
      // print(numberOkay);
      
      print('kuch boolean/s galat hai');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _userDetailsFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height : 20),
                      TextFormField(
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Name'),
                        validator: (value) {
                          if(value == null || value.length<2 || value.isEmpty)
                            {
                              nameOkay = false;
                              return 'Invalid Name';
                            }
                          else {
                            setState(() {
                              nameOkay = true;
                            });
                          }
                        },
                        controller: nameController,
                        onSaved: (newValue1) {
                          //print(newValue1);
                          userName = newValue1!;
                        },
                      ),
          
          
          
                      const SizedBox(height : 30),
          
          
          
                      TextFormField(
          
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Address'),
                        validator: (value) {
                          if(value==null || value.isEmpty || value.length<10){
                            addressOkay = false;
                            return 'Please give more information';
                          }
                          else{
                            setState(() {
                              addressOkay = true;
                            });
                          }
                        },
                        controller: addressController,
                        onSaved: (newValue2) {
                          //print(newValue2);
                          userAddress = newValue2!.trim();
                          //print(userAddress);
                        },
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height : 30),
                      TextFormField(
          
                        decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Phone Number'),
                        validator: (value){
                          if(value == null || value.isEmpty || value.length<10 || value.length>10)
                            {
                              numberOkay = false;
                              return 'Invalid Phone Number';
                            }
                          else {
                            setState(() {
                              numberOkay = true;
                            });
                          }
                        },
                        controller: phoneNumberController,
                        onSaved: (newValue3) {
                          userNum = newValue3!;
                          //print(newValue3);
                          //print(userNum);
                        },
                        keyboardType: TextInputType.phone,
                      ),
          
                    ],
                  ),
          
          
              ),
          
          
          
              const SizedBox(height : 20),
          
          

              ElevatedButton(
                  onPressed: (){
                      addUserInfoToFirestore();
                  },
                  child: Text('Add Info'))
            ],
          ),
        ),
      ),
    );
  }
}

















// ElevatedButton(onPressed: (){
// print(nameOkay);
// print(addressOkay);
// print(numberOkay);
// },
// child: Text('Print bools')),
