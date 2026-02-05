
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_guide/constants.dart';
import 'package:gym_guide/homee/main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewDietPlan());
}

class ViewDietPlan extends StatelessWidget {
  const ViewDietPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View DietPlan',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewDietPlanNew(title: 'View DietPlan'),
    );
  }
}

class ViewDietPlanNew extends StatefulWidget {
  const ViewDietPlanNew({super.key, required this.title});

  final String title;

  @override
  State<ViewDietPlanNew> createState() => _ViewDietPlanNewState();
}

class _ViewDietPlanNewState extends State<ViewDietPlanNew> {

  _ViewDietPlanNewState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> Date_= <String>[];
  List<String> Name_= <String>[];
  List<String> Dietplan_= <String>[];
  List<String> Time_= <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> Date = <String>[];
    List<String> Name = <String>[];
    List<String> Dietplan = <String>[];
    List<String> Time = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String imgurl = sh.getString('img_url').toString();
      String url = '$urls/Get_health_pr/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        Time.add(arr[i]['time'].toString());
        Date.add(arr[i]['date'].toString());
        Name.add(arr[i]['name'].toString());
        Dietplan.add(imgurl+arr[i]['dietplan'].toString());
      }

      setState(() {
        id_ = id;
        Date_ = Date;
        Name_ = Name;
        Dietplan_ = Dietplan;
        Time_ = Time;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(title: "",),));
      return false; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.deepPurple,


          title: Text("DietPlan " ,style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w600),
          ),),

        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,

          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Container(
                        width: 400,
                        child: Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            color: kGinColor,
                            // color: Colors.blue,

                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Date: " ,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ), Text(
                                   Date_[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      "Time: ",
                                      style: TextStyle(fontSize: 16),
                                    ),  Text(
                                   Time_[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      "Name: ",
                                      style: TextStyle(fontSize: 16),
                                    ),Text(
                                       Name_[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network(Dietplan_[index],height: 295,width: 295),
                                ),
                                // Text(
                                //   "Reply: " + reply_[index],
                                //   style: TextStyle(fontSize: 16),
                                // ),
                                // SizedBox(height: 8),
                                // Text(
                                //   "Status: " + status_[index],
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: status_[index] == "replied"
                                //         ? Colors.green
                                //         : Colors.red,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),



                      // Card(
                      //   child:
                      //   Row(
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsets.all(5),
                      //               child: Text("Date: "+date_[index]),
                      //             ),
                      //             Padding(
                      //               padding: EdgeInsets.all(5),
                      //               child: Text("Complaint: "+complaint_[index]),
                      //             ),    Padding(
                      //               padding: EdgeInsets.all(5),
                      //               child: Text("Reply: "+reply_[index]),
                      //             ),  Padding(
                      //               padding: EdgeInsets.all(5),
                      //               child: Text("Status: "+status_[index]),
                      //             ),
                      //           ],
                      //         ),
                      //
                      //       ]
                      //   ),
                      //
                      //   elevation: 6,
                      // ),
                    ],
                  )),
            );
          },
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => SendComplaint(title: '',)));
        //
        // },
        //   child: Icon(Icons.add),
        // ),


      ),
    );
  }
}
