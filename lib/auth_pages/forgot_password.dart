import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


final _firebase = FirebaseAuth.instance;


class forgotpasswordscreen extends StatefulWidget {
  const forgotpasswordscreen({super.key});

  @override
  State<forgotpasswordscreen> createState() => _forgotpasswordscreenState();
}


final TextEditingController emailcontroller = TextEditingController();

class _forgotpasswordscreenState extends State<forgotpasswordscreen> {

  final formkey = GlobalKey<FormState>();

  var usersEmail = '';


  resetpasswordfunction() async {
    formkey.currentState!.validate();
    formkey.currentState!.save();

    try{
      await _firebase.sendPasswordResetEmail(email: usersEmail);
    }  on FirebaseAuthException catch (error)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [
          //main column starts here
          Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(color: Colors.pink.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [BoxShadow(
                            blurRadius: 1.9,
                            blurStyle: BlurStyle.outer,
                            color: Colors.white.withOpacity(0.98)
                        )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left : 15),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || !value.contains('@') || value.isEmpty || !value.contains('.com'))
                          {
                            print('email invalid hai');
                            return 'Enter a valid email address';
                          }
                          else {
                            print( 'good email');
                          }
                          //return 'good email';


                        },
                        onSaved:(email) {
                          usersEmail = email!;
                        },

                        controller: emailcontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Schyler', fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 150),

          ElevatedButton(onPressed: (){
            resetpasswordfunction();
          },
              child: Text('Reset Password')
          )

        ],
      ),
    );
  }
}
