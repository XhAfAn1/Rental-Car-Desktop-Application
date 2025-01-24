import 'dart:convert';

import 'package:car_rental_app/data%20management/all%20classes/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../data management/userData/currentUser.dart';
class reportlist extends StatefulWidget {
  const reportlist({super.key});

  @override
  State<reportlist> createState() => _reportlistState();
}

class _reportlistState extends State<reportlist> {
  late Future<List<Report>> reportDetailsFuture;

  Future<List<Report>> fetchDetails() async{

    final response = await http.post(
      Uri.parse('https://localhost/flutter/rental_car_api/get_single_report.php'),
      body: jsonEncode({'PersonID': currentUser.CurrentUser?.personId}),
    );

     print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((car) => Report.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load car details');
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reportDetailsFuture = fetchDetails();
    print(reportDetailsFuture);
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
          title: Text("My Reports",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Report>>(
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
                              Text(
                                "Report Date: ${report.reportDate}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Status: ${report.status}",
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
        )
    );
  }


}


