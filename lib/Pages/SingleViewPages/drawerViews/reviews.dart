import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data management/all classes/review.dart';
import '../../../data management/userData/currentUser.dart';

class reviewlist extends StatefulWidget {
  const reviewlist({super.key});

  @override
  State<reviewlist> createState() => _reviewlistState();
}

class _reviewlistState extends State<reviewlist> {
  @override
  late Future<List<Review>> reviewFuture;

  Future<List<Review>> fetchDetails() async{

    final response = await http.post(
      Uri.parse('https://localhost/flutter/rental_car_api/get_single_review.php'),
      body: jsonEncode({'PersonID': currentUser.CurrentUser?.personId}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((car) => Review.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load car details');
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewFuture = fetchDetails();
    print(reviewFuture);
  }
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back)),
          title: Text("My Reviews",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Review>>(
          future: reviewFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final reviews = snapshot.data!;
              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                    ),
                    margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                    height: 250,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.black.withAlpha(10), width: 2),
                          ),
                          margin: EdgeInsets.all(10),
                          width: 200,
                          height: double.infinity,
                          child: Icon(Icons.reviews, size: 40),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Review ID: ${review.reviewId}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Booking ID: ${review.bookingId}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Ratings: ${review.ratings}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Comment: ${review.comment}",
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Review Date: ${review.reviewDate}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Pickup: ${review.pickupDate} | Drop: ${review.dropDate}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Car ID: ${review.carId} | Point ID: ${review.pointId}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "Person ID: ${review.personId} | Driver ID: ${review.driverId ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        )
    );
  }


}


