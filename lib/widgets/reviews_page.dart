import 'package:capstone_1/widgets/review_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final _firestore = FirebaseFirestore.instance;
final cakeReviewsCollectionRef = _firestore.collection('Cake Reviews').get();



class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key, required this.cakeName});

  final String cakeName;

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}



class _ReviewsPageState extends State<ReviewsPage> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ratings and Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
      ),
        body: StreamBuilder(
          stream: _firestore.collection('Cake Reviews').doc(widget.cakeName).collection(widget.cakeName).snapshots(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData == false){
                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No Data was Found')));
                print('**************no data found*************');
              }
              else if(snapshot.hasData){
              print('***************snapshot has data');
              List<QueryDocumentSnapshot<Map<String, dynamic>>> listOfCurrentCakeReviewDocuments = snapshot.data!.docs;

              return ListView.builder(
                itemCount: listOfCurrentCakeReviewDocuments.length,
                itemBuilder: (context, index) {

                  var single_Review_Document_OR_Map_Of_Single_Review = listOfCurrentCakeReviewDocuments[index];

                  if(single_Review_Document_OR_Map_Of_Single_Review.data().isEmpty){
                    print('document hai par empty hai');
                    return Container();
                  }
                  else if(single_Review_Document_OR_Map_Of_Single_Review.data().isNotEmpty){


                    return ReviewContainer(
                      ratingToBePassed: single_Review_Document_OR_Map_Of_Single_Review['Rating'],
                      customerName: single_Review_Document_OR_Map_Of_Single_Review['Customer Name'],
                      dateOfReview: '4th Sep, 2024',
                      likes: 3,
                      reviewImageSource: single_Review_Document_OR_Map_Of_Single_Review['Image URL'],
                      reviewToBePassed: single_Review_Document_OR_Map_Of_Single_Review['Review'],
                    );


                  }
                  else {
                    return Container();
                  }
                },
              );

            }
            }


              return Container();

            },
          )

        );
  }
}
