import 'dart:ui';
import 'package:capstone_1/data/all_cake_list.dart';
import 'package:capstone_1/screens/admin_auth_page.dart';
import 'package:capstone_1/screens/admin_home_page.dart';
import 'package:capstone_1/screens/cake_details_screen.dart';
import 'package:capstone_1/screens/user_profile_screen.dart';
import 'package:capstone_1/screens/users_orders_page.dart';
import 'package:capstone_1/widgets/slider_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:capstone_1/main.dart';

String? userkaName;
String? userkaAddress;
String? userkaPhoneNumber;
var userkaUID = FirebaseAuth.instance.currentUser!.uid;
int adminLoggedIn = 0;

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}



class _homepageState extends State<homepage> {


  @override
  void initState() {
    super.initState();

    getUserData();
  }


  Future<void> getUserData() async{

    final userUID = FirebaseAuth.instance.currentUser!.uid;

    final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('Cake Customers').where('User UID', isEqualTo: userUID).get()
      .then((snapshot) => snapshot.docs.first);


    if(userDoc.exists){
      setState(() {
        var data = userDoc.data() as Map<String, dynamic>;
         userkaName = data['Name'] as String;
         userkaAddress = data['Address'] as String;
         userkaPhoneNumber = data['Phone Number'];

      });
      }
  }

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
        title: Row(children: [ Text('Hello'), SizedBox(width:5), Text(userkaName ?? ''),],),
        //actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart))],
      ),


      drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                Image.asset('assets/images/chocolate-cake.png',
                ),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return UserProfilePage();
                    },));
                },
                child: const Text('Profile'),),

              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return UsersOrdersPage();
                },));
              }, child: const Text('My Orders'),),
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
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                if(adminLoggedIn == 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AdminAuthPage();
                      },));
                }

                else if(adminLoggedIn == 1){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AdminHomePage();
                      },));
                }
              }, child: Text('Admin Panel')),
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.grey.shade400.withOpacity(0.4),
                      //       borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))
                      //   ),
                      //   width: 50,
                      //   height: 270,
                      //   child: Column(
                      //     children: [
                            // InkWell(
                            //   child: Text('A'),
                            //   onTap: () {
                            //
                            //   },
                            // ),
                            // const SizedBox(height : 70),
                            // InkWell(
                            //   child: Text('A'),
                            //   onTap: () {
                            //
                            //   },
                            // ),
                            // const SizedBox(height: 70,),
                            // InkWell(
                            //   child: Text('A'),
                            //   onTap: () {
                            //
                            //   },
                            // ),

                      //     ],
                      //   ),
                      // ),

                      //const SizedBox(width: 3,),
                    ],
                  ),
                ],
              ),
               ),





                    Positioned(
                      top: 125,
                      left: 10,
                      child: Container(
                        height: 270,
                        width: deviceWidth- 20,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Cakes_List.length,
                            itemBuilder: (context, index) => SliderContainers(
                              assetPath: Cakes_List[index].imgPath, cakeName: Cakes_List[index].name,index: index,)
                            ),
                      ),

                    ),


                Positioned(
                    top: 420,
                    left: 25,
                    child:Container(
                      //width: 100,
                      //height: 100,
                      //color: Colors.red,
                      child: const Text('Explore from Categories', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),

                    )
                ),

                Positioned(
                    top: 450,
                    //left: 20,
                    child: Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(deviceWidth*0.05),
                            child: Container(
                              height: deviceHeight*0.23,
                              width : deviceWidth*0.432,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.purpleAccent.shade100.withOpacity(0.4)
                                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(right: deviceWidth*0.02,left: deviceWidth*0.02,top: deviceWidth*0.02),
                                    child: Image.asset(Cakes_List[3].imgPath,),
                                  ),
                                  //SizedBox(height : 10),
                                  const Text('New this week', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                                ],

                              ),
                                                ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return CakeDetailsScreen(index1: 3);
                            },));
                          },
                        ),






                        InkWell(
                          child: Container(
                            height: deviceHeight*0.23,
                            width : deviceWidth*0.432,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.lightGreenAccent.withOpacity(0.4)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(right: deviceWidth*0.02,left: deviceWidth*0.02,top: deviceWidth*0.02),
                                    child: Image.asset(Cakes_List[2].imgPath,),
                                  ),
                                  //SizedBox(height : 10),
                                  const Text('Best Seller', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                                ],

                                ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return CakeDetailsScreen(index1: 2);
                            },));
                          },
                        )
                  ],
                ))

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
