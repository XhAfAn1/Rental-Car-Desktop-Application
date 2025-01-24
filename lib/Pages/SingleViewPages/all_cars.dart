import 'package:car_rental_app/Pages/SingleViewPages/single_car_view.dart';
import 'package:flutter/material.dart';

import '../../data management/all classes/car_model.dart';
import '../../data management/api/fetch_api.dart';

class view_all_cars extends StatefulWidget {
  const view_all_cars({super.key});

  @override
  State<view_all_cars> createState() => _view_all_carsState();
}

class _view_all_carsState extends State<view_all_cars> {
  late Future<List<CarDetails>> carDetailsFuture;
  @override
  void initState() {
    super.initState();
    carDetailsFuture = CarDetailsService().fetchAvlCarDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xffffffff),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
        title: Text("All Available Cars",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<CarDetails>>(
        future: carDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final carDetails = snapshot.data!;
            return ListView.builder(
              itemCount: carDetails.length,
              itemBuilder: (context, index) {
                final car = carDetails[index];
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => single_car_view(carId: car.carId,),));
                  },
                  child: Container(

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
                                             Text('Brand: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                             Text('${car.manufacturer} ',style: TextStyle(fontSize: 20,),),
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
                            Text("${car.amount?.toInt()}৳",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Color(0xff5850d2)),),
                            Text("/day",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                            SizedBox(width: 40,)
                          ],
                        )
                      ],
                    ),

                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
