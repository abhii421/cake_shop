import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_1/auth_pages/verified_or_not_screen.dart';


final _firebase = FirebaseAuth.instance;


class createaccountpage extends StatefulWidget {
  const createaccountpage({super.key});

  @override
  State<createaccountpage> createState() => _createaccountpageState();

}

final TextEditingController anamecontroller = TextEditingController();
final TextEditingController aemailcontroller = TextEditingController();
final TextEditingController apasswordcontroller = TextEditingController();


class _createaccountpageState extends State<createaccountpage> {
  final _formkakey = GlobalKey<FormState>();
  bool NameOkay = false;
  bool EmailOkay = false;
  bool PassOkay = false;
  var userKaEmail = '';
  var userKaPassword = '';
  var userKaName = '';

//ISS WALE FUNCTION KO SIGN UP BUTTON CALL KARTA HAI
  void _signupwithemail() async {
    //print('yha');
    _formkakey.currentState!.validate();
    _formkakey.currentState!.save();

    try {
      await _firebase.createUserWithEmailAndPassword(email: userKaEmail, password: userKaPassword);
      //UserCredential userCredential = await _firebase.createUserWithEmailAndPassword(email: userKaEmail, password: userKaPassword);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (error){
      // if(error.code == 'email-already-in-use'){
      //   //display smthng
      // }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: Text(error.message!),
        ),
      );
    }
  }

  //THIS BELOW ONE IS CALLED BY THE ABOVE FUNCTION ITSELF

  Future<void> sendEmailVerification(BuildContext context) async {
    //print('yha tk aa rha h');
    try{
      _firebase.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Check your email!'))
      );
    } on FirebaseAuthException catch (error){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message!)
          )
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: BackButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
          title: Text('Sign Up'),
          centerTitle: true,
          backgroundColor: Colors.purpleAccent.shade100.withOpacity(0.1),
        ),
        body:
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top : 30, left: 20),
              //child: Text('Create New Account'),
            ),


            const SizedBox(height: 50),



            Form(
                key : _formkakey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(

                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child : Padding(
                            padding: const EdgeInsets.only(left : 8.0),
                            child: TextFormField(
                              validator: (value){
                                if(value==null || value.isEmpty
                                )
                                {
                                  print('name is invalid');
                                  return 'invalid name';
                                }
                                else{
                                  print('name is valid');
                                  setState(() {
                                    NameOkay = true;
                                  }
                                  );//return 'valid name';
                                }
                              },

                              controller: anamecontroller,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText : 'Name'
                              ),
                              // onSaved: (newValue) {
                              //   userKaName= newValue!;
                              // },
                              onSaved: (newValue) {
                              },
                            ),
                          )
                      ),
                    ),



                    const SizedBox(height: 13),


                    //****************** -- email --DUSRA TEXT FIELD*************************

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(

                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child : Padding(
                            padding: const EdgeInsets.only(left : 8.0),
                            child: TextFormField(
                              validator: (value){
                                if(value==null || value.isEmpty || !value.contains('@') || !value.contains('.com'))

                                {
                                  print('email is invalid');
                                  return 'invalid email';
                                }

                                else

                                {
                                  print('email is valid');
                                  setState(() {
                                    EmailOkay = true;
                                  });
                                }

                              },
                              controller: aemailcontroller,
                              onSaved: (newValue2) {
                                userKaEmail = newValue2!.trim();
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText : 'Email'
                              ),




                            ),
                          )
                      ),
                    ),


                    //******************* password -- TEESRA TEXT FIELD*************************************
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(

                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child : Padding(
                            padding: const EdgeInsets.only(left : 10),
                            child: TextFormField(
                              validator: (value) {
                                //(!value.contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]')))
                                if (value == null || value.isEmpty || value.length < 6)
                                {
                                  print('it is not a strong password');
                                  return 'Make a strong password';
                                }

                                else {
                                  print('this is a strong password');
                                  setState(() {
                                    PassOkay = true;
                                  });
                                  //return 'good password';
                                }
                              },
                              controller: apasswordcontroller,
                              onSaved: (newValue) {
                                userKaPassword = newValue!;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText : 'Password'
                              ),
                              obscureText: true,

                            ),
                          )
                      ),
                    ),


                  ],
                )
            ),

            //*********************FORM ENDS BUT MAIN COLUMN STILL CONTINUING AND BUTTONS WILL START BELOW**********************************

            const SizedBox(
              height: 35,
            ),

            ElevatedButton(
                onPressed:() {
                  _signupwithemail();
                  print('sign up pressed');
                  //VerfiedOrNot();

                  if(EmailOkay == true && PassOkay == true && NameOkay == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VerfiedOrNot()
                        )
                    );
                  }
                  else if(EmailOkay == false){
                    print('Email not gud');
                  }
                  else if(PassOkay == false)
                  {
                    print('Password not gud');
                  }

                  else if(NameOkay == false)
                  {
                    print('Name not good');
                  }

                  else {
                    print('Something else is the problem');
                  }
                },
                //Navigator.push(context, MaterialPageRoute(builder : (context) => homepage()));

                child: const Text('Create Account')

            )
          ],
        )
    );
  }
}






// if(!isValid){
//   print ('form not valid');
//   return;
// }


// print(userKaEmail);
// print(userKaPassword);




