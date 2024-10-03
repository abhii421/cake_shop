import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

bool imgPresent = false;
bool reviewPresent = false;
//bool ratingSevere = false;
bool reviewLiked = false;
Color ratingColor = Colors.green;
String? passedReview;

class ReviewContainer extends StatefulWidget {
   const ReviewContainer({super.key,
     this.reviewImageSource,this.reviewToBePassed,
     required this.ratingToBePassed, required this.customerName, required this.dateOfReview, required this.likes} );


  final String? reviewImageSource;
  final int ratingToBePassed;
  final String? reviewToBePassed;
  final String customerName;
  final String dateOfReview;
  final int likes;

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}



class _ReviewContainerState extends State<ReviewContainer> {

  void checkImagePresence(){
    if(widget.reviewImageSource.toString().length > 4){
      imgPresent = true;
      print('image is present');
    }
    else{
      imgPresent = false;
    }
  }

  void checkReviewPresence(){

    if(widget.reviewToBePassed!=null) {
      if (widget.reviewToBePassed!.length > 3){
        setState(() {
          reviewPresent = true;
        });
      }
      else if(widget.reviewToBePassed!.length <=3){
        setState(() {
          reviewPresent == false;
        });
      }
      print(widget.reviewToBePassed);
      print('Review is present');

    } else if(widget.reviewToBePassed == null){
      setState(() {
        reviewPresent == false;
      });

      print('Review not present');
    }

  }

  void applyRatingColor (){
    if(widget.ratingToBePassed < 3){

      ratingColor = Colors.red;
      print(widget.ratingToBePassed);

    }
    else if(widget.ratingToBePassed == 3){
      ratingColor = Colors.lightGreen.shade300;
      print(widget.ratingToBePassed);
    }
    else if(widget.ratingToBePassed > 3){
      ratingColor = Colors.green;
      print(widget.ratingToBePassed);
    }
  }


  @override
  void initState() {

    super.initState();
    checkReviewPresence();
    checkImagePresence();
    applyRatingColor();

  }


  @override
  Widget build(BuildContext context) {

    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;


    return Container(
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 20,),

          SizedBox(
              height: 20,
              //color: Colors.orangeAccent,
              child :Row(
                children: [
                  const SizedBox(width: 19, ),
                  Container(
                    decoration: BoxDecoration(color: ratingColor,borderRadius: BorderRadius.circular(7)),
                    //height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1, left: 6),
                          child: Text(widget.ratingToBePassed.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
                        ),
                        const SizedBox(width: 1,),
                        const Padding(
                          padding: EdgeInsets.only(top : 2.5, right: 4),
                          child: Icon(Icons.star_rounded, color:Colors.white,size: 17,),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20,),
                  Text(widget.dateOfReview,  style: const TextStyle(color: Colors.black38, fontSize: 12,),),

                ],
              )
          ),

          //const SizedBox(height: 10,),
          imgPresent == true?
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Container(
                  height: deviceHeight*0.18,
                  //width: deviceWidth,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                  child: Image.network(widget.reviewImageSource!, fit: BoxFit.scaleDown,),

                )
              ],
            ),
          ): Container(),

          reviewPresent == true?
          Padding(
            padding: const EdgeInsets.only(top : 15.0, left: 18, right: 18, bottom : 1),
            child: ReadMoreText(widget.reviewToBePassed.toString(),colorClickableText: Colors.blueAccent,
              //delimiter: '...   ',
              trimCollapsedText: '  Show more',
              trimExpandedText: '  Show less',

              moreStyle: const TextStyle(color: Colors.blue, fontSize: 14.8, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
              lessStyle: const TextStyle(color: Colors.blue, fontSize: 14.8, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),

            ),
          )
              : Container(),

          //const SizedBox(height: 11,),

          Container(
            //color: Colors.yellow,
            child: Row(
              children: [

              const SizedBox(width: 18,),
                Text(widget.customerName, style: const TextStyle(color: Colors.black26, fontSize: 12),),
              const SizedBox(height: 10,),
              IconButton(
                icon: reviewLiked == false ?  const Icon(Icons.thumb_up_off_alt): const Icon(Icons.thumb_up_alt),

                onPressed: () {
                  setState(() {
                    reviewLiked = !reviewLiked;

                  });
                },
              ),
              ],
            ),
          ),
          //const SizedBox(height: 5),
          const Divider(height: 3, color: Colors.black12,),

        ],
      ),
    );

  }
}
