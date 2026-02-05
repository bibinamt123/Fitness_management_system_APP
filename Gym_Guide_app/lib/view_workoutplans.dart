import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/home.dart';
import 'package:gym_guide/view_dietplans.dart';
import 'package:gym_guide/view_serviceplans.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewWorkoutPlan());
}

class ViewWorkoutPlan extends StatelessWidget {
  const ViewWorkoutPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Plan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewWorkoutPlans(title: 'View Workout Plan'),
    );
  }
}

class ViewWorkoutPlans extends StatefulWidget {
  const ViewWorkoutPlans({super.key, required this.title});

  final String title;

  @override
  State<ViewWorkoutPlans> createState() => _ViewWorkoutPlansState();
}

class _ViewWorkoutPlansState extends State<ViewWorkoutPlans> {
  List<String> id_ = [];
  List<String> plan_ = [];
  List<String> photo_ = [];
  List<String> description_ = [];

  Future<void> viewWorkoutPlan() async {
    List<String> id = [];
    List<String> plan = [];
    List<String> photo = [];
    List<String> description = [];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String sid = sh.getString('sid').toString();
      String img = sh.getString('img_url').toString();
      String url = '$urls/viewworkoutplan/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
        'sid': sid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        plan.add(arr[i]['plan'].toString());
        photo.add(img+arr[i]['photo'].toString());
        description.add(arr[i]['description'].toString());
      }

      setState(() {
        id_ = id;
        plan_ = plan;
        photo_ = photo;
        description_ = description;
      });

      print(statuss);
    } catch (e) {
      print("Error: " + e.toString());
      Fluttertoast.showToast(msg: "Error loading workout plans.");
    }
  }

  @override
  void initState() {
    super.initState();
    viewWorkoutPlan();
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
                MaterialPageRoute(builder: (context) => ViewServicePlans()),
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
            return WorkoutPlanCard(
              id: id_[index],
              plan: plan_[index],
              photo: photo_[index],
              description: description_[index],
            );
          },
        ),
      ),
    );
  }
}

class WorkoutPlanCard extends StatelessWidget {
  final String id;
  final String plan;
  final String photo;
  final String description;

  const WorkoutPlanCard({
    Key? key,
    required this.id,
    required this.plan,
    required this.photo,
    required this.description,
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
            // Workout Plan Name
            Row(
              children: [
                Icon(Icons.fitness_center, size: 20),
                SizedBox(width: 8),
                Text(
                  "Plan:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              plan,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            // Workout Photo (if available)
            if (photo.isNotEmpty) ...[
              Image.network(
                photo,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
            ],

            // Workout Description
            Row(
              children: [
                Icon(Icons.description, size: 20),
                SizedBox(width: 8),
                Text(
                  "Description:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),




            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {

                  SharedPreferences sh = await SharedPreferences.getInstance();
                  sh.setString("wid", id);


                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewDietPlans(title: '',),));


                },
                child: Text("Diet Plans"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48), // Full-width button
                ),
              ),



            )

          ],
        ),
      ),
    );
  }
}
