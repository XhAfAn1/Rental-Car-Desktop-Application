import 'package:car_rental_app/Pages/SingleViewPages/add_car.dart';
import 'package:car_rental_app/data%20management/all%20classes/booking.dart';
import 'package:car_rental_app/data%20management/api/loginfunc.dart';
import 'package:flutter/material.dart';

import '../../data management/all classes/car_model.dart';
import '../../data management/all classes/hirepoint.dart';
import '../../data management/all classes/maintainance.dart';
import '../../data management/all classes/payment.dart';
import '../../data management/all classes/person.dart';
import '../../data management/all classes/report.dart';
import '../../data management/all classes/review.dart';
import '../../data management/api/fetch_api.dart';
import '../../data management/api/sharedPref.dart';
import '../Login.dart';
import '../SingleViewPages/single_car_view.dart';
import '../SingleViewPages/userPage.dart';

class admin_home extends StatefulWidget {
  const admin_home({super.key});

  @override
  State<admin_home> createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  late Future<List<CarDetails>> carDetailsFuture;
  late Future<List<Person>> personDetailsFuture;
  late Future<List<Person>> customerDetailsFuture;
  late Future<List<Payment>> paymentDetailsFuture;
  late Future<List<Report>> reportDetailsFuture;
  late Future<List<Maintenance>> maintainanceFuture;
  late Future<List<HirePoint>> reportHirepointFuture;
  late Future<List<Review>> reviewFuture;
  late Future<List<Booking>> allCarBookingDetails;
  late Future<List<Person>> bookingbyuser;
  late Future<List<CarDetails>> popularcar;

  @override
  void initState() {
    super.initState();
    carDetailsFuture = CarDetailsService().fetchCarDetails();
    personDetailsFuture = CarDetailsService().fetchPersonDetails();
    customerDetailsFuture = CarDetailsService().fetchCustomerDetails();
    paymentDetailsFuture = CarDetailsService().fetchPaymentDetails();
    reportDetailsFuture = CarDetailsService().fetchReportDetails();
    reportHirepointFuture= CarDetailsService().fetchHirepointDetails();
    maintainanceFuture= CarDetailsService().fetchMaintainDetails();
    reviewFuture= CarDetailsService().fetchReviewDetails();

    allCarBookingDetails= CarDetailsService().fetchAllBooling();
    bookingbyuser= CarDetailsService().fetchbookingbyuser();
    popularcar= CarDetailsService().fetchpopularcar();

    dashboard();
    count();
  }

  Widget contentWidget = Center(child: Text('Content'));
  String counts="0";
  String availablecarcounts="0";
  String revenuecounts="0";
  void count() async{
    counts= await  AuthService().personCounter();
    availablecarcounts= await  AuthService().availableCarCounter();
    revenuecounts= await  AuthService().availableRevCounter();

    setState(() {

    });
  }


  void dashboard() {
    setState(() {
      contentWidget = FutureBuilder<List<CarDetails>>(
        future: carDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final carDetails = snapshot.data!;
            return Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Container(
                         decoration: BoxDecoration(
                             color: Color(0xfff2f2f2),
                           borderRadius: BorderRadius.circular(10)
                         ),
                          height: 300,
                          width: 300,

                          child: Center(child: Text('Total User\n'+counts,style: TextStyle(color: Color(0xffaeaeae),fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                        ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffe2fdee),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height:300,
                        width: 300,

                        child: Center(child: Text('Total Available Car\n'+availablecarcounts,style: TextStyle(color: Color(0xff87ae8d),fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                      ),


                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffe8eeff),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text('Total Revenue\n'+revenuecounts+'৳',style: TextStyle(color: Color(
                            0xff616a8e),fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                        height:300,
                        width: 300,

                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xfffcf8d7),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 300,
                        width: 300,

                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllCars() {
    setState(() {
      contentWidget = FutureBuilder<List<CarDetails>>(
        future: carDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final carDetails = snapshot.data!;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 50,
                    width: 200,

                    decoration: BoxDecoration(
                        color: Color(0xff5850d2),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCarPage(),));
                    }, child: Text("Add New Car",style: TextStyle(color: Colors.black,fontSize: 20),))
                  ),
              Expanded(
                child: ListView.builder(
                itemCount: carDetails.length,
                  itemBuilder: (context, index) {
                    final car = carDetails[index];
                    return Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                      ),
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),

                      height: 200,
                      width:double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: Colors.black.withAlpha(10), width: 2),
                                    image:   car.photo!=null || car.photo!=''? DecorationImage(image: NetworkImage(car.photo!)): DecorationImage(image: AssetImage('assets/logo.png'))
                                ),
                                margin: EdgeInsets.all(10),
                                width: 200,

                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.only(left:10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //    Text("Car ID: ${car.carId}",style: TextStyle(fontSize: 20),),
                                    Text("${car.modelName}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('CarID: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.carId}  ',style: TextStyle(fontSize: 20,),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Year: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.year}  ',style: TextStyle(fontSize: 20,),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Type: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.carType} ',style: TextStyle(fontSize: 20,),),
                                              ],
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Registration no: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.registrationNumber} ',style: TextStyle(fontSize: 20,),),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Brand: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.manufacturer} ',style: TextStyle(fontSize: 20,),),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Availability: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                                Text('${car.available_status} ',style: TextStyle(fontSize: 20,),),

                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                },
                                child: Text('Add to Maintainance',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 12),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text("${car.amount?.toInt()}৳",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Color(0xff5850d2)),),
                              Text("/day",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                              SizedBox(width: 40,)
                            ],
                          )
                        ],
                      ),

                    );
                  },
                ),
              )
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllPersons() {
    setState(() {
      contentWidget = FutureBuilder<List<Person>>(
        future: personDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final personDetails = snapshot.data!;
            return ListView.builder(
              itemCount: personDetails.length,
              itemBuilder: (context, index) {
                final person = personDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                       //   color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.black.withAlpha(10), width: 2),
                        ),
                        margin: EdgeInsets.all(10),
                        width: 200,
                        height: double.infinity,
                        child: Icon(Icons.person,size: 40,),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Person ID: ${person.personId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${person.name} (${person.age})",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              "Person Type: ${person.customerId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Person Type: ${person.dob}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Person Type: ${DateTime.now().difference(person.dob!).inDays}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllCustomers() {
    setState(() {
      contentWidget = FutureBuilder<List<Person>>(
        future: customerDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final personDetails = snapshot.data!;
            return ListView.builder(
              itemCount: personDetails.length,
              itemBuilder: (context, index) {
                final person = personDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //   color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.black.withAlpha(10), width: 2),
                        ),
                        margin: EdgeInsets.all(10),
                        width: 200,
                        height: double.infinity,
                        child: Icon(Icons.person,size: 40,),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Person ID: ${person.personId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "${person.name} (${person.age})",
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              "Person Type: ${person.customerId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Person Type: ${person.dob}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Person Type: ${DateTime.now().difference(person.dob!).inDays}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllPayments() {
    setState(() {
      contentWidget = FutureBuilder<List<Payment>>(
        future: paymentDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final paymentDetails = snapshot.data!;
            return ListView.builder(
              itemCount: paymentDetails.length,
              itemBuilder: (context, index) {
                final payment = paymentDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
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
                        child: Icon(Icons.payment, size: 40),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment ID: ${payment.paymentId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Amount: \$${payment.payAmount}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Payment Type: ${payment.paymentType}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Payment Date: ${payment.paymentDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Booking ID: ${payment.bookingId}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllReports() {
    setState(() {
      contentWidget = FutureBuilder<List<Report>>(
        future: reportDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final reportDetails = snapshot.data!;
            return ListView.builder(
              itemCount: reportDetails.length,
              itemBuilder: (context, index) {
                final report = reportDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
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
                        child: Icon(Icons.report, size: 40),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Report ID: ${report.reportId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Descriptoon: ${report.description}",
                              style: TextStyle(fontSize: 20),
                            ),

                            Text(
                              "Date: ${report.reportDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "BookingID: ${report.bookingId}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllHirePoints() {
    setState(() {
      contentWidget = FutureBuilder<List<HirePoint>>(
        future: reportHirepointFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final hirePointDetails = snapshot.data!;
            return ListView.builder(
              itemCount: hirePointDetails.length,
              itemBuilder: (context, index) {
                final hirePoint = hirePointDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
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
                        child: Icon(Icons.location_on, size: 40),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hire Point ID: ${hirePoint.pointId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Location:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Point name: ${hirePoint.pointName}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "State: ${hirePoint.state} - ${hirePoint.city} - ${hirePoint.zip} -  ${hirePoint.street}",
                              style: TextStyle(fontSize: 20),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }

  void showAllMaintainance() {
    setState(() {
      contentWidget = FutureBuilder<List<Maintenance>>(
        future: maintainanceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final maintainanceDetails = snapshot.data!;
            return ListView.builder(
              itemCount: maintainanceDetails.length,
              itemBuilder: (context, index) {
                final maintainance = maintainanceDetails[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
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
                        child: Icon(Icons.build, size: 40),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Maintainance ID: ${maintainance.maintenanceId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Description: ${maintainance.comments}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Date: ${maintainance.maintenanceDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Cost: \৳${maintainance.maintenanceCost.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      );
    });
  }


  void showAllReviews() {
    setState(() {
      contentWidget = FutureBuilder<List<Review>>(
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
      );
    });
  }

  void showAlbookings() {
    setState(() {
      contentWidget = FutureBuilder<List<Booking>>(
        future: allCarBookingDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final booking = snapshot.data!;
            return ListView.builder(
              itemCount: booking.length,
              itemBuilder: (context, index) {
                final bookin = booking[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 400,
                  width: double.infinity,
                  child: Row(
                    children: [

                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Review ID: ${bookin.bookingId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "status : ${bookin.status}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "pickupDate: ${bookin.pickupDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "dropDate: ${bookin.dropDate}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "carId: ${bookin.carId}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "pointId: ${bookin.pointId}",
                              style: TextStyle(fontSize: 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "personId: ${bookin.personId}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "registrationNumber: ${bookin.registrationNumber}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "photo: ${bookin.photo}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "carType: ${bookin.carType}",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "amount: ${bookin.amount}",
                              style: TextStyle(fontSize: 18),
                            ),


                          ],
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
      );
    });
  }

  void showAlbookingvyuser() {
    setState(() {
      contentWidget = FutureBuilder<List<Person>>(
        future: bookingbyuser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final booking = snapshot.data!;
            return ListView.builder(
              itemCount: booking.length,
              itemBuilder: (context, index) {
                final bookin = booking[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    children: [

                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Person ID: ${bookin.personId}",
                              style: TextStyle(fontSize: 20),
                            ),Text(
                              "Name: ${bookin.name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Total Booking : ${bookin.totalBooking?.toInt()}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Total spend : ${bookin.totalPayment}",
                              style: TextStyle(fontSize: 20),
                            ),




                          ],
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
      );
    });
  }

  void showAllpopularcar() {
    setState(() {
      contentWidget = FutureBuilder<List<CarDetails>>(
        future: popularcar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final booking = snapshot.data!;
            return ListView.builder(
              itemCount: booking.length,
              itemBuilder: (context, index) {
                final bookin = booking[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                  ),
                  margin: EdgeInsets.only(top: 13, left: 20, right: 20),
                  height: 120,
                  width: double.infinity,
                  child: Row(
                    children: [

                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Car ID: ${bookin.carId}",
                              style: TextStyle(fontSize: 20),
                            ),Text(
                              "Model Name: ${bookin.modelName}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Rating : ${bookin.OverAll_ratings}",
                              style: TextStyle(fontSize: 20),
                            ),




                          ],
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
      );
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 1,
        shadowColor: Colors.grey.withAlpha(10),
        backgroundColor: Color(0xff5850d2),
        title: Text(
          "Admin Panel",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(40),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => user_page(),
              ));
            },
            child: CircleAvatar(
              child: Icon(Icons.person, color: Colors.white),
              backgroundColor: Colors.black,
              radius: 25,
            ),
          ),
          SizedBox(width: 20),
          IconButton(
              onPressed: () {
                logClear();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => login(),
                ));
              },
              icon: Icon(Icons.logout, color: Colors.white)),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        color: Color(0xFFEAE8EB),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Dashboard",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    onTap: dashboard,
                  ),
                  ListTile(
                    title: Text(
                      "View All Cars",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllCars,
                  ),
                  ListTile(
                    title: Text(
                      "View All Persons",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllPersons,
                  ),
                  ListTile(
                    title: Text(
                      "View All Customers",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllCustomers,
                  ),
                  ListTile(
                    title: Text(
                      "View All Payments",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllPayments,
                  ),
                  ListTile(
                    title: Text(
                      "View All Reports",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllReports,
                  ),
                  ListTile(
                    title: Text(
                      "View All Hirepoints",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllHirePoints,
                  ),
                  ListTile(
                    title: Text(
                      "View All Maintainance Record",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllMaintainance,
                  ),
                  ListTile(
                    title: Text(
                      "View All Review Record",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllReviews,
                  ),
                  ListTile(
                    title: Text(
                      "View All Booking Details",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAlbookings,
                  ),
                  ListTile(
                    title: Text(
                      "Booking count total spend",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAlbookingvyuser,
                  ),
                  ListTile(
                    title: Text(
                      "Show All popular Car",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onTap: showAllpopularcar,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                color: Colors.white,
                child: contentWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
