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
      home: const ViewProgress(title: 'View date'),
    );
  }
}

class ViewProgress extends StatefulWidget {
  const ViewProgress({super.key, required this.title});

  final String title;

  @override
  State<ViewProgress> createState() => _ViewProgressState();
}

class _ViewProgressState extends State<ViewProgress> {
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> weight_ = <String>[];
  List<String> workout_ = <String>[];
  List<String> desc_ = <String>[];
  List<String> calory_ = <String>[];

  Future<void> viewdate() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> weight = <String>[];
    List<String> workout = <String>[];
    List<String> desc = <String>[];
    List<String> calory = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewprogress/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        weight.add(arr[i]['weight'].toString());
        workout.add(arr[i]['workout'].toString());
        desc.add(arr[i]['progressnotes'].toString());
        calory.add(arr[i]['caloriesburned'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        weight_ = weight;
        workout_=workout;
        desc_=desc;
        calory_=calory;
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
              weight: weight_[index],
              workout: workout_[index],
              desc: desc_[index],
              calory: calory_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String tip;
  final String workout;
  final String desc;
  final String weight;
  final String calory;

  const TipCard({Key? key, required this.tip,required this.workout,required this.desc, required this.weight, required this.calory}) : super(key: key);

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
                Icon(Icons.short_text_outlined, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Calories:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    calory,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),



            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.upload, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Progressnote:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    desc,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // weight Information
            Row(
              children: [
                Icon(Icons.calculate, size: 20),
                SizedBox(width: 8),
                Text(
                  "Weight:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  weight,
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
