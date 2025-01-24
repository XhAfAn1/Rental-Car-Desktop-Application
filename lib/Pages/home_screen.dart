import 'package:car_rental_app/Pages/Login.dart';
import 'package:car_rental_app/Pages/SingleViewPages/all_cars.dart';
import 'package:car_rental_app/Pages/SingleViewPages/drawerViews/cancelled.dart';
import 'package:car_rental_app/Pages/SingleViewPages/filtered_cars.dart';
import 'package:car_rental_app/Pages/SingleViewPages/userPage.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../data management/all classes/car_model.dart';
import '../data management/api/fetch_api.dart';
import '../data management/api/sharedPref.dart';
import 'SingleViewPages/drawerViews/onGoing.dart';
import 'SingleViewPages/drawerViews/reports.dart';
import 'SingleViewPages/drawerViews/reviews.dart';
import 'SingleViewPages/single_car_view.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  late Future<List<CarDetails>> carDetailsFuture;
  List<String> CarType = ['TYPE', 'NAMES'];
  void get_list() async {
    CarType = await CarDetailsService().fetchCarType();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    get_list();
    carDetailsFuture = CarDetailsService().fetchAvlCarDetails();
    print(carDetailsFuture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {

            return Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.menu, color: Colors.black,size: 35,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        toolbarHeight: 100,
          surfaceTintColor: Colors.transparent,
       // elevation: 1,
        shadowColor: Colors.grey.withValues(alpha: 10),
        backgroundColor: Color(0xffffffff),
        title: Image(image: AssetImage('assets/logo.png'),height: 80,),
        titleSpacing: 0,
        // leadingWidth: 100,
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(20),
        //         bottomRight: Radius.circular(20))),
        //
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
              icon: Icon(Icons.logout, color: Colors.black,size: 30,)),
          SizedBox(width: 20),
        ],
      ),
      drawer: Drawer(
        shape: const LinearBorder(),
        width: 350,
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            // ListTile(
            //   leading: Image.asset('assets/appstore.png'),
            //   title: const Text(
            //     'Note Keep',
            //     style: TextStyle(
            //         fontSize: 25,
            //         color: Colors.black87,
            //         fontWeight: FontWeight.w500),
            //   ),
            //   onTap: null,
            // ),
            const Divider(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              decoration: const BoxDecoration(
                  //color: Color(0XFFE8F0FE),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: ListTile(
                leading: const Icon(
                  color: Color(0XFF3C88EC),
                  Icons.lightbulb_outline,
                  size: 23,
                ),
                title: const Text(
                  'On Going',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0XFF3C88EC),
                      fontWeight: FontWeight.bold),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => onGoing(),));
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  color: Colors.black.withOpacity(0.75),
                  Icons.notifications_none_outlined,
                  size: 23,
                ),
                title: Text(
                  'Scheduled',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
            ),
            const Divider(
              height: 10,
              indent: 60,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(left: 17, top: 20, bottom: 20),
              child: Text(
                "Report & Review",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.label_outline,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Reports',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => reportlist(),));
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.mode_edit_outline_outlined,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Reviews',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => reviewlist(),));
                },
              ),
            ),
            const Divider(
              height: 10,
              indent: 60,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.archive_outlined,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'test',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Canceled',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => cancellist(),));
                },
              ),
            ),
            const Divider(
              height: 10,
              indent: 60,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Setting',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.feedback_outlined,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Send app feedback',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              margin: const EdgeInsets.only(right: 15),
              child: ListTile(
                leading: Icon(
                  Icons.help_outline,
                  color: Colors.black.withOpacity(0.75),
                  size: 23,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                ),
                onTap: null,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

              Container(
                height: 600,
                width: double.infinity,
                color: Colors.black,
                child: Center(child: Text("Explore the world's largest car sharing \nand rental platform",style: TextStyle(color: Colors.white,fontSize: 80,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
              ),

            Container(
              margin: EdgeInsets.only(left: 250, right: 250),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                  height: 90,
                ),
                Container(
                  child: Text(
                    "Browse by Type",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 1300,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 1.8,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 40),
                    itemCount: CarType.length,
                    itemBuilder: (context, index) {
                      final type = CarType[index];
                      return InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hoverColor: Color(0xff5850d2).withAlpha(20),

                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => view_filter_cars(
                              type: type,
                            ),
                          ));
                        },
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black.withAlpha(40), width: 2),
                          ),
                         // height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('$type',
                                  style: TextStyle(
                                      color: Color(0XFF5850d2),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 90,
                ),
                Container(
                  child: Text(
                    "Popular Cars",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FutureBuilder<List<CarDetails>>(
                  future: carDetailsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final carDetails = snapshot.data!;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.4,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30
                        ),
                        itemCount: carDetails.length > 10 ? 9 : carDetails.length,
                        itemBuilder: (context, index) {
                          final car = carDetails[index];
                          return InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hoverColor: Color(0xff5850d2).withAlpha(20),

                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => single_car_view(
                                  carId: car.carId,
                                ),
                              ));
                            },
                            child: Container(
                              // height: 30,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15, right: 15,top: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color:Colors.black.withAlpha(50), width: 2),
                              ),
                              child: Container(

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text('${car.modelName} (${car.year})',
                                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                                            Text('${car.carType} - ${car.manufacturer}',
                                                style: TextStyle(fontSize: 20,color: Color(0xffaaaaaa),fontWeight: FontWeight.w400)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '৳ ${car.amount?.toInt()}',
                                                  style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),Row(
                                              children: [
                                                Text(
                                                  '/day',
                                                  style: TextStyle(fontSize: 23,fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Expanded(
                                      child: Container(
                                        child: car.photo != null
                                            ? Container(

                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(car.photo!),
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        )
                                            : Icon(Icons.car_rental),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),


                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
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
                SizedBox(
                  height: 50,
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => view_all_cars()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    width: double.infinity,
                    child: Text(
                      "View All Cars",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.2,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 50,
                )
              ]),
            ),
          ],
        )
      ),
    );
  }
}
