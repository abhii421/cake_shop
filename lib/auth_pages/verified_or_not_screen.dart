import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_1/screens/homepage.dart';

final _firebase = FirebaseAuth.instance;

class VerfiedOrNot extends StatefulWidget {
  const VerfiedOrNot({super.key});

  @override
  State<VerfiedOrNot> createState() => _VerfiedOrNotState();
}



class _VerfiedOrNotState extends State<VerfiedOrNot> {

  bool isEmailVerified = false;



  @override
  void initState(){
    super.initState();
    checkEmailVerification();
  }

  void checkEmailVerification() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user1 = auth.currentUser;



    await user1!.reload();
    if(user1.emailVerified){
      setState(() {
        isEmailVerified = true;
      });
    }




    if(isEmailVerified == true){

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => homepage()

      )

      );
    }


  }//function yha khtm ho rha hai


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          children: [

            SizedBox(height: 300),
            Text('If verified, Click on the Button Below'),
            SizedBox(height: 70),
            ElevatedButton(onPressed:()
            {
              checkEmailVerification();
              print('user says yes');
            },
                child: Text('Yes, I have verified'))
          ],
        ),
      ),
    );
  }
}