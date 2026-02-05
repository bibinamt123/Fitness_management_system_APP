import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Viewdate());
}

class Viewdate extends StatelessWidget {
  const Viewdate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View date',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewAttendance(title: 'View date'),
    );
  }
}

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({super.key, required this.title});

  final String title;

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String>checkintime_ = <String>[];
  List<String> cat_ = <String>[];
  List<String> checkinout_ = <String>[];
  List<String> classname_ = <String>[];

  Future<void> viewdate() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String>checkintime = <String>[];
    List<String> cat = <String>[];
    List<String> checkinout = <String>[];
    List<String> classname = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String cid = sh.getString('lid').toString();
      String url = '$urls/viewattendance/';

      var data = await http.post(Uri.parse(url), body: {'lid': cid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
       checkintime.add(arr[i]['checkintime'].toString());
        cat.add(arr[i]['status'].toString());
        checkinout.add(arr[i]['checkouttime'].toString());
        classname.add(arr[i]['classname'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
       checkintime_ =checkintime;
        cat_=cat;
        checkinout_=checkinout;
        classname_=classname;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    viewdate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen(title: '')),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return TipCard(
              tip: date_[index],
              checkintime:checkintime_[index],
              cat: cat_[index],
              checkinout: checkinout_[index],
              classname: classname_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String tip;
  final String cat;
  final String checkinout;
  final String checkintime;
  final String classname;

  const TipCard({Key? key, required this.tip,required this.cat,required this.checkinout, required this.checkintime, required this.classname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tip Information
            Row(
              children: [
                Icon(Icons.date_range, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Date:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tip,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timelapse, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Checkin Time:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    checkintime,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),



            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timelapse, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Checkout Time:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    checkinout,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),


            SizedBox(height: 8),

            //checkintime Information
            Row(
              children: [
                Icon(Icons.class_, size: 20),
                SizedBox(width: 8),
                Text(
                  "Classname:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  classname,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),

            //checkintime Information
            Row(
              children: [
                Icon(Icons.front_hand_sharp, size: 20),
                SizedBox(width: 8),
                Text(
                  "Status:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                 cat,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
