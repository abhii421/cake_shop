import 'package:flutter/material.dart';
import 'package:capstone_1/main.dart';


class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 45),
          const Text('Welcome!)', style: TextStyle(fontFamily: 'Schyler',fontSize: 20,fontWeight: FontWeight.w500),),
          const SizedBox(height: 45),
          const Center(
            child: SizedBox(
              width : 300,
              height : 300,
              // decoration : BoxDecoration(
              //     image : DecorationImage(
              //         image: AssetImage('assets/images/readrhino.png'),

              child: Text('Logged In'),
            ),
          ),

          const SizedBox(height: 50),

          ElevatedButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(
                builder : (context)=> const MyHomePage(title: 'title')
            )
            );
          },
              child: const Text('Sign Out')
          )
        ],
      ),
    );
  }
}

