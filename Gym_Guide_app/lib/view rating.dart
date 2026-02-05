import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/send_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const View_Rating(title: 'Flutter Demo Home Page'),
    );
  }
}

class View_Rating extends StatefulWidget {
  const View_Rating({super.key, required this.title});

  final String title;

  @override
  State<View_Rating> createState() => _View_RatingState();
}

class _View_RatingState extends State<View_Rating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: id_.length,
        itemBuilder: (context, index) =>
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date-time"),
                          Text(date_time_[index]),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Review"),
                          Text(review_[index]),
                        ],
                      )),



                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("User"),
                          Text(USER_[index]),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RatingBarIndicator(
                      rating: double.parse(rating_[index]),
                      itemBuilder: (context, index) =>
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      itemCount: 5,
                      itemSize: 50.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sendreview(title: ''),
              ));
        },
        child: Text('send'),
      ),

    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List id_ = [],
      date_time_ = [],
      USER_ = [],
      review_ = [],
      rating_ = [];

  void getData() async {
    List id = [],
        date_time = [],
        USER = [],
        review = [],
        rating = [];
    final sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String tid = sh.getString('tid').toString();
    try {
      final response =
      await http.post(Uri.parse('$url/viewreviewfromuser/'), body: {
        'lid': sh.getString('lid').toString(),
        'tid': sh.getString('tid').toString(),
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          var data = jsonDecode(response.body)['data'];
          for (int i = 0; i < data.length; i++) {
            id.add(data[i]['id'].toString());
            date_time.add(data[i]['date'].toString());
            review.add(data[i]['review'].toString());
            rating.add(data[i]['rating'].toString());
            USER.add(data[i]['user'].toString());
          }
          setState(() {
            id_ = id;
            date_time_ = date_time;
            USER_ = USER;
            review_ = review;
            rating_ = rating;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
