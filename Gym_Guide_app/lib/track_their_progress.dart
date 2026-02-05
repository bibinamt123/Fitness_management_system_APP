import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/home.dart';
import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
void main() {
  runApp(const TrackTheirProgressApp());
}

class TrackTheirProgressApp extends StatelessWidget {
  const TrackTheirProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Progress',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TrackTheirProgressScreen(title: 'Track Your Progress'),
    );
  }
}

class TrackTheirProgressScreen extends StatefulWidget {
  const TrackTheirProgressScreen({super.key, required this.title});

  final String title;

  @override
  State<TrackTheirProgressScreen> createState() => _TrackTheirProgressScreenState();
}

class _TrackTheirProgressScreenState extends State<TrackTheirProgressScreen> {
  TextEditingController aboutCon = TextEditingController();
  TextEditingController datec = TextEditingController();
  TextEditingController caloriesc = TextEditingController();
  TextEditingController weightc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen(title: '')),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Title/Label Text
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "Please describe your workout progress:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Text Field for Description
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: datec,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Choose Date',
                      labelStyle: TextStyle(color: Colors.teal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.teal),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true, // Prevent manual text entry
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: weightc,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Weight',
                      labelStyle: TextStyle(color: Colors.teal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 16),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: caloriesc,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Calories burned',
                      labelStyle: TextStyle(color: Colors.teal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 16),
                  ),
                ),





                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: aboutCon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Describe your progress',
                      labelStyle: TextStyle(color: Colors.teal),
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                // Sign In Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _sendData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Set the background color of the button
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        datec.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _sendData() async {
    String about = aboutCon.text;
    String weight = weightc.text;
    String date = datec.text;
    String calory = caloriesc.text;

    if (about.isEmpty){
      Fluttertoast.showToast(msg: "Please provide a description.");
      return;
    }

    if (weight.isEmpty){
      Fluttertoast.showToast(msg: "Please provide a weight.");
      return;
    }


    if (date.isEmpty){
      Fluttertoast.showToast(msg: "Please provide a date.");
      return;
    }

    if (calory.isEmpty){
      Fluttertoast.showToast(msg: "Please provide a calories.");
      return;
    }
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String wid = sh.getString('wid').toString();
    print(url);

    final urls = Uri.parse('$url/tracktheirprogress/');
    print(urls);
    try {
      final response = await http.post(urls, body: {
        "about": about,
        "date": date,
        "calories": calory,
        "weight": weight,
        "lid": lid,
        "wid": wid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Progress Added');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen(title: 'Login')),
          );
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
