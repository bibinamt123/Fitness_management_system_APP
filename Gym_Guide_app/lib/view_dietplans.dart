import 'package:flutter/material.dart';
import 'package:gym_guide/view_workoutplans.dart';
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
      title: 'View Diet Plan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewDietPlans(title: 'View Diet Plan'),
    );
  }
}

class ViewDietPlans extends StatefulWidget {
  const ViewDietPlans({super.key, required this.title});

  final String title;

  @override
  State<ViewDietPlans> createState() => _ViewDietPlansState();
}

class _ViewDietPlansState extends State<ViewDietPlans> {
  List<String> id_ = <String>[];
  List<String> days_ = <String>[];
  List<String> session_ = <String>[];
  List<String> diets_ = <String>[];

  Future<void> viewDietPlan() async {
    List<String> id = <String>[];
    List<String> days = <String>[];
    List<String> session = <String>[];
    List<String> diets = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String wid = sh.getString('wid').toString();
      String url = '$urls/viewdietplan/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
        'wid': wid
      });

      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        days.add(arr[i]['days'].toString());
        session.add(arr[i]['session'].toString());
        diets.add(arr[i]['diets'].toString());
      }

      setState(() {
        id_ = id;
        days_ = days;
        session_ = session;
        diets_ = diets;
      });

      print(statuss);
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    viewDietPlan();
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
                MaterialPageRoute(builder: (context) => ViewWorkoutPlan()),
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
            return DietPlanCard(
              day: days_[index],
              session: session_[index],
              diet: diets_[index],
            );
          },
        ),
      ),
    );
  }
}

class DietPlanCard extends StatelessWidget {
  final String day;
  final String session;
  final String diet;

  const DietPlanCard({
    Key? key,
    required this.day,
    required this.session,
    required this.diet,
  }) : super(key: key);

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
            // Day Information
            Row(
              children: [
                Icon(Icons.calendar_today, size: 20),
                SizedBox(width: 8),
                Text(
                  "Day:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(day),
              ],
            ),
            SizedBox(height: 8),

            // Session Information
            Row(
              children: [
                Icon(Icons.access_time, size: 20),
                SizedBox(width: 8),
                Text(
                  "Session:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(session),
              ],
            ),
            SizedBox(height: 8),

            // Diet Information
            Row(
              children: [
                Icon(Icons.restaurant, size: 20),
                SizedBox(width: 8),
                Text(
                  "Diet:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(diet),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
