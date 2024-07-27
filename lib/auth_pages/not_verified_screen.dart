import 'package:flutter/material.dart';
import 'package:capstone_1/auth_pages/login_screen.dart';

class notverifiedscreen extends StatefulWidget {
  const notverifiedscreen({super.key});

  @override
  State<notverifiedscreen> createState() => _notverifiedscreenState();
}

class _notverifiedscreenState extends State<notverifiedscreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: (){
                Navigator.of(context).pop();
              }
          ),),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                  height: 200
              ),
              const Center(
                  child : Text('    Email not verified\n Verify then try logging in')
              ),
              const SizedBox(
                  height: 200
              ),
              ElevatedButton(onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => loginscreen()
                )
                );
              },
                  child: const Text('I have verified'))
            ],
          ),
        )
    );
  }
}
