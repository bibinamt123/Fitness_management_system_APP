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
      home: const ViewSchedule(title: 'View date'),
    );
  }
}

class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key, required this.title});

  final String title;

  @override
  State<ViewSchedule> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {
  _ViewScheduleState(){viewdate();}
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> fromtime_ = <String>[];
  // List<String> cat_ = <String>[];
  List<String> totime_ = <String>[];

  Future<void> viewdate() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> fromtime = <String>[];
    // List<String> cat = <String>[];
    List<String> totime = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String tid = sh.getString('tid').toString();
      String url = '$urls/viewtrainerschedule/';

      var data = await http.post(Uri.parse(url), body: {'tid': tid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        fromtime.add(arr[i]['fromtime'].toString());
        // cat.add(arr[i]['category'].toString());
        totime.add(arr[i]['totime'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        fromtime_ = fromtime;
        // cat_=cat;
        totime_=totime;
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
              date: date_[index],
              fromtime: fromtime_[index],
              // cat: cat_[index],
              totime: totime_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String date;
  final String totime;
  final String fromtime;

  const TipCard({Key? key, required this.date,required this.totime, required this.fromtime}) : super(key: key);

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
                    date,
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
                  "Fromtime:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fromtime,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // fromtime Information
            Row(
              children: [
                Icon(Icons.timelapse, size: 20),
                SizedBox(width: 8),
                Text(
                  "Totime:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  totime,
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
