import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_1/auth_pages/not_verified_screen.dart';
import 'package:capstone_1/screens/loading.dart';
import 'package:capstone_1/auth_pages/login_screen.dart';
import 'package:capstone_1/screens/homepage.dart';

import 'package:capstone_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


//remove until
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();
  @override

  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}








class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

        home : StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder : (ctx, snapshot){

              if (snapshot.connectionState == ConnectionState.waiting){
                print('Waiting at the moment');
                return Center(
                    child: CircularProgressIndicator()
                );
                //const splashscreen();
              }

              if(snapshot.hasData){
                print('loggedin hai');
                return homepage();
              }

              else
              {
                return const loginscreen();
              }
            }
        )
    );
  }
}















































// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
