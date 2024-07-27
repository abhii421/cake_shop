import 'dart:ui';
import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/screens/cake_details_screen.dart';
import 'package:capstone_1/widgets/slider_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone_1/main.dart';


class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}



class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    // void cakeSelected(int index){
    //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CakeDetailsScreen(cakeModel: Cakes_List[index],)
    //     )
    //   );
    // }

    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade100.withOpacity(0.2),
        title: const Text('Hello User'),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart))],
      ),


      drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
                Image.asset('assets/images/chocolate-cake.png',
                ),
              ElevatedButton(onPressed: (){}, child: Text('Profile'),),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){}, child: Text('My Orders'),),
              const SizedBox(height: 30,),
              ElevatedButton(
                  onPressed:() async {
                FirebaseAuth.instance.signOut();
                //await FirebaseServices().signOut();
                Navigator.pop(context, MaterialPageRoute(builder: (context)=> homepage()));
                Navigator.push(context, MaterialPageRoute(
                    builder : (context)=> MyHomePage(title: 'title')
                )
               );
              },
                  child: const Text('Sign Out'),
              ),
              const SizedBox(height: 30,)
            ],
          ),
      ),






      body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
              gradient: LinearGradient(
              colors: [Colors.purpleAccent.shade100.withOpacity(0.1), Colors.white/*Colors.lightBlueAccent.shade100.withOpacity(0.01)*/],
              begin:Alignment.topLeft,
              end: Alignment.bottomRight,
                )
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 0.083*deviceWidth, right: 0.3*deviceWidth),
                    child: const Text('What would you like to eat?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  ),

                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400.withOpacity(0.4),
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                        ),
                        width: 50,
                        height: 270,
                        child: Column(
                          children: [
                            InkWell(
                              child: Text('A'),
                              onTap: () {

                              },
                            ),
                            const SizedBox(height : 70),
                            InkWell(
                              child: Text('A'),
                              onTap: () {

                              },
                            ),
                            const SizedBox(height: 70,),
                            InkWell(
                              child: Text('A'),
                              onTap: () {

                              },
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(width: 3,),
                    ],
                  ),
                ],
              ),
               ),





                    Positioned(
                      top: 125,
                      left: 60,
                      child: Container(
                        height: 270,
                        width: deviceWidth,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Cakes_List.length,
                            itemBuilder: (context, index) => SliderContainers(
                              assetPath: Cakes_List[index].imgPath, cakeName: Cakes_List[index].name,index: index,)
                            ),
                      ),

                    ),

                //





]
    )
    );
  }
}


// ListView.builder(
// scrollDirection: Axis.horizontal,
// itemCount: 5,
// itemBuilder: (context, index) => SliderContainers(assetPath: Cakes_List[index].imgPath)
//
// ),