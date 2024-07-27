import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_1/auth_pages/create_account_page.dart';
import 'package:capstone_1/auth_pages/forgot_password.dart';
import 'package:capstone_1/screens/homepage.dart';
import 'package:capstone_1/auth_pages/not_verified_screen.dart';


//user.mail verified = false

final _firebase = FirebaseAuth.instance;

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

final TextEditingController namecontroller = TextEditingController();
final TextEditingController emailcontroller = TextEditingController();
final TextEditingController passwordcontroller = TextEditingController();


class _loginscreenState extends State<loginscreen> {

  final formkakey = GlobalKey<FormState>();

  var userKaName = '';
  var userKaEmail = '';
  var userKaPassword = '';
  bool passToggle = false;
  bool emailValid = false;


  void emailloginfunction() async {
    final isValid = formkakey.currentState!.validate();

    if(isValid == true){
      formkakey.currentState!.save();

    }
    else {
      print('koi valid nahi hai');
    }


    try{

      await _firebase.signInWithEmailAndPassword(
          email: userKaEmail, password: userKaPassword);
      // print('**********login details start here***********');
      // print(logindetails);
      // print('**********login details end here***********');

      if(await _firebase.currentUser!.emailVerified == true){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => homepage()
        )
        );
      }

      else if(await _firebase.currentUser!.emailVerified == false){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const notverifiedscreen()));

      }


    } on FirebaseAuthException catch (error){
      if(error.code == 'email-already-in-use'){
        //display smthng
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Error in your data'),
        ),
      );
    }


    // else {
    //   print('user credentials save ni ho rhe');
    // }
    //MyHomePage(title: 'hi');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children : [
              Container(
                  width: double.infinity,
                  height : double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        //image: AssetImage('assets/images/gradient.png'),
                          image: AssetImage('assets/images/obj1.jpg'),
                          fit : BoxFit.fitHeight
                      )
                  )
              ),


              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter : ImageFilter.blur(
                      sigmaX:2,
                      sigmaY : 2
                  ),
                  child: Container(
                    width: 3000,
                    height : 3500,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pink.shade100.withOpacity(0.1),
                      border: Border.all(color: Colors.black12.withOpacity(0.1),
                          width: 1.7),
                    ),
                  ),
                ),
              ),


//******************************************NOW THIRD LAYER OF THE STACK IS ITSELF A COLUMN*******************

              Column(
                children: [
                  //Column first part
                  const SizedBox(height : 130),

                  //column second part
                  Text("Hello Again!\nLet's Sign In", style:
                  TextStyle(color : Colors.black38.withOpacity(0.6),fontSize: 20, fontFamily : 'Schyler', fontWeight: FontWeight.w300),
                  ),

                  //Column third part


                  const SizedBox(height : 80),

                  //COlumn fourth part********************FORM KE ANDAR COLUMN,COLUMN KE ANDAR TEXT FIELDS***************************************

                  Form(
                      key: formkakey,
                      child: Column(
                        children: [


                          //************FIRST Text field is here***********************************************


                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  border: Border.all(color: Colors.pink.withOpacity(0.1)),
                                  borderRadius: BorderRadius.circular(11),
                                  boxShadow: [BoxShadow(
                                      blurRadius: 1.9,
                                      blurStyle: BlurStyle.outer,
                                      color: Colors.white.withOpacity(0.98)
                                  )]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left : 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
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
                                    //or
                                    //return null;
                                  },

                                  onSaved:(email) {
                                    userKaEmail = email!;
                                  },

                                  controller: emailcontroller,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      border: InputBorder.none,
                                      hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Schyler', fontSize: 14)
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
//               *********************SECOND TEXT field*******************************
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(9),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.9,
                                        blurStyle: BlurStyle.outer,
                                        color: Colors.white.withOpacity(0.99)
                                    )]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left : 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  //obscureText: true,
                                  controller: passwordcontroller,
                                  //!value.contains(RegExp(r"1,2,3,4,5,6,7,8,9")

                                  validator: (value) {
                                    if (value == null || value.isEmpty || value.trim().length<8)
                                    {
                                      // print('Enter a strong password');
                                      print('password strong ni h');
                                      return 'Enter a strong password';

                                    }
                                    else {
                                      print('good password');
                                    }
                                    return null;
                                  },
                                  onSaved: (password){
                                    userKaPassword = password!;
                                  },
                                  decoration: const InputDecoration(

                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: 'Password',hintStyle: TextStyle(fontFamily: 'schyler', fontSize: 14),
                                    // suffix: InkWell(
                                    //   onTap: (){
                                    //     setState(() {
                                    //       passToggle = !passToggle;
                                    //     });
                                    //   },
                                    //  // child : Container(color: Colors.purpleAccent,)
                                    // ),

                                  ),
                                ),
                              ),
                            ),
                          ),



                        ],

                      )
                  ),


                  //*********************FORM ENDS THE BUTTONS START NOW************************************




                  const SizedBox(height: 19),




                  //SizedBox(height: 29),

                  // TEXT FIELDS END AND BUTTONS SHURU HOTE HAI
                  ElevatedButton(style: ElevatedButton.styleFrom( backgroundColor : Colors.white.withOpacity(0.99), shape: const StadiumBorder() ),
                    onPressed: (){

                      emailloginfunction();
                      print('sign in pressed');

                      // passwordcontroller.clear();
                      // emailcontroller.clear();
                    },
                    child: const Text('   Sign In   ', style: TextStyle(fontFamily: 'Schyler',
                        fontSize: 19),
                    ),
                  ),




                  const SizedBox(height: 20),





                  ElevatedButton(style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const createaccountpage()));

                      },
                      child: const Text('Signup')
                  ),


                  SizedBox(height: 20),

                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpasswordscreen()
                    )
                    );
                  },

                      child: Text('Forgot Password?')
                  )


                ],



              ),





              Padding(
                  padding: const EdgeInsets.only(top : 670, left: 110),
                  child : ElevatedButton(style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      onPressed: () async{
                        print('Google Sign in presssed');
                        //await FirebaseServices().signInWithGoogle();

                      },
                      child: const Text('Google Sign In')
                  )
              ),






            ]
        )
    );
  }
}














// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white.withOpacity(0.5),
// border: Border.all(color: Colors.pink.withOpacity(0.1)),
// borderRadius: BorderRadius.circular(9),
// boxShadow: [BoxShadow(
// blurRadius: 1.9,
// blurStyle: BlurStyle.outer,
// color: Colors.white.withOpacity(0.99)
// )]
// ),
// child: Padding(
// padding: const EdgeInsets.only(left : 15),
// child: TextFormField(
// controller: namecontroller,
// decoration: InputDecoration(
// border: InputBorder.none,
// hintText: 'Name',hintStyle: TextStyle(fontFamily: 'schyler', fontSize: 14),
// ),
// validator: (value) {
// if(value==null|| value.isEmpty )
// { print('name invalid hai');
// return 'The name is not entered or invalid';}
//
// else
// print('good name');
// return 'good name';
// },
// onSaved: (name) {
// userKaName = name!;
// },
// ),
// ),
// ),
// ),
//
// SizedBox(height: 12),
//|| value.contains(RegExp(r"!@#%$^&'*(),.?:{}|<>]")
