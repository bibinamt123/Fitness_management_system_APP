import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/home.dart';
import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/view%20reply.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
      home: const sendcomplaint(title: 'Track Your Progress'),
    );
  }
}

class sendcomplaint extends StatefulWidget {
  const sendcomplaint({super.key, required this.title});

  final String title;

  @override
  State<sendcomplaint> createState() => _sendcomplaintState();
}

class _sendcomplaintState extends State<sendcomplaint> {
  TextEditingController aboutCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => viewreply(title: '')),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => viewreply(title: '')),
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
                    "Record Your Complaints",
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
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: aboutCon,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Describe your complaint',
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
                      "Send",
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

  void _sendData() async {
    String about = aboutCon.text;

    if (about.isEmpty) {
      Fluttertoast.showToast(msg: "Please provide a description.");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    print(url);

    final urls = Uri.parse('$url/sendcomplaint/');
    print(urls);
    try {
      final response = await http.post(urls, body: {
        "about": about,
        "lid": lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Progress Added');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => viewreply(title: 'Login')),
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
