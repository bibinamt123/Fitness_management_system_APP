import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Viewdiet());
}

class Viewdiet extends StatelessWidget {
  const Viewdiet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View diet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const VIewDietPlan(title: 'View diet'),
    );
  }
}

class VIewDietPlan extends StatefulWidget {
  const VIewDietPlan({super.key, required this.title});

  final String title;

  @override
  State<VIewDietPlan> createState() => _VIewDietPlanState();
}

class _VIewDietPlanState extends State<VIewDietPlan> {
  List<String> id_ = <String>[];
  List<String> diet_ = <String>[];
  List<String> trainer_ = <String>[];
  List<String> session_ = <String>[];
  List<String> day_ = <String>[];

  Future<void> viewdiet() async {
    List<String> id = <String>[];
    List<String> diet = <String>[];
    List<String> trainer = <String>[];
    List<String> session = <String>[];
    List<String> day = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewdiet/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        diet.add(arr[i]['diet'].toString());
        trainer.add(arr[i]['trainer'].toString());
        session.add(arr[i]['session'].toString());
        day.add(arr[i]['day'].toString());
      }

      setState(() {
        id_ = id;
        diet_ = diet;
        trainer_ = trainer;
        session_=session;
        day_=day;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    viewdiet();
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
              tip: diet_[index],
              trainer: trainer_[index],
              session: session_[index],
              day: day_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String tip;
  final String session;
  final String day;
  final String trainer;

  const TipCard({Key? key, required this.tip,required this.session,required this.day, required this.trainer}) : super(key: key);

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
                Icon(Icons.lightbulb, size: 20, color: Colors.yellow),
                SizedBox(width: 8),
                Text(
                  "Tip:",
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
                Icon(Icons.lightbulb, size: 20, color: Colors.yellow),
                SizedBox(width: 8),
                Text(
                  "sessionegory:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    session,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),



            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.lightbulb, size: 20, color: Colors.yellow),
                SizedBox(width: 8),
                Text(
                  "dayription:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    day,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Trainer Information
            Row(
              children: [
                Icon(Icons.person, size: 20),
                SizedBox(width: 8),
                Text(
                  "Trainer:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  trainer,
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
