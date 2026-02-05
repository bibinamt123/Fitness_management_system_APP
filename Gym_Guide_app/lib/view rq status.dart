import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/chat.dart';
import 'package:gym_guide/home.dart';
import 'package:gym_guide/homee/main.dart';
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
      home: const reqstatus(title: 'PWD Details'),
    );
  }
}

class reqstatus extends StatefulWidget {
  const reqstatus({super.key, required this.title});

  final String title;

  @override
  State<reqstatus> createState() => _reqstatusState();
}

class _reqstatusState extends State<reqstatus> {

  _reqstatusState() {
    viewPwd();
  }

  List<String> id_ = <String>[];
  List<String> tid_ = <String>[];
  List<String> name_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> mail_ = <String>[];
  List<String> status_ = <String>[];
  List<String> date_ = <String>[];
  List<String> photo_ = <String>[]; // Trainer photo list

  Future<void> viewPwd() async {
    List<String> id = <String>[];
    List<String> tid = <String>[];
    List<String> name = <String>[];
    List<String> phone = <String>[];
    List<String> mail = <String>[];
    List<String> statuss = <String>[];
    List<String> date = <String>[];
    List<String> photo = <String>[];  // Trainer photo list

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String img_url = sh.getString('img_url').toString();
      String url = '$urls/user_view_req_status/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        phone.add(arr[i]['phone'].toString());
        mail.add(arr[i]['mail'].toString());
        date.add(arr[i]['date'].toString());
        tid.add(arr[i]['tid'].toString());
        statuss.add(arr[i]['status'].toString());
        photo.add(img_url + arr[i]['photo'].toString());  // Fetching trainer photo URL
      }

      setState(() {
        id_ = id;
        name_ = name;
        phone_ = phone;
        mail_ = mail;
        status_ = statuss;
        date_ = date;
        tid_ = tid;
        photo_ = photo;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(title: '',)), // Home navigation
            );
          }),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: Text("Request status",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),  // Add padding for the content
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status at the top with color
                        Text(
                          status_[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: status_[index] == 'approved' ? Colors.green : Colors.red,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Trainer Image and Details
                        Row(
                          children: [
                            // Trainer Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(photo_[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Space between image and text

                            // Trainer Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildRow(Icons.person, "", name_[index]),
                                  buildRow(Icons.phone, "", phone_[index]),
                                  buildRow(Icons.email, "", mail_[index]),
                                  buildRow(Icons.date_range, "", date_[index]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),


                        if(status_[index]=='approved')...{
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferences sh = await SharedPreferences.getInstance();
                                sh.setString('tid', tid_[index]);
                                // sh.setString("tid", tid);
                                sh.setString("name", name_[index].toString());
                                // String? url = sh.getString('url');
                                // if (url == null || lid == null || tid == null) {
                                //   Fluttertoast.showToast(msg: 'Error fetching URL or User ID');
                                //   return;
                                // }
                                // final urls = Uri.parse('$url/User_viewchat/');
                                // try {
                                //   final response = await http.post(urls, body: {
                                //     "tid": tid,
                                //     "lid": lid,
                                //   });
                                //   if (response.statusCode == 200) {
                                //     String status = jsonDecode(response.body)['status'];
                                //     if (status == 'ok') {
                                //       if (status_[index] == 'approved') {
                                //         Fluttertoast.showToast(msg: 'Redirecting to chat...');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyChatNew(title: '',)));
                                //         );
                                //       } else {
                                //         Fluttertoast.showToast(msg: 'Will be verified soon');
                                //       }
                                //     } else {
                                //       Fluttertoast.showToast(msg: 'Failed to send request');
                                //     }
                                //   } else {
                                //     Fluttertoast.showToast(msg: 'Network Error');
                                //   }
                                // } catch (e) {
                                //   Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
                                // }
                              },
                              child: Text("Chat"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,  // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                        }
                        else...{

                        }

                        // Chat button aligned at the bottom center
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: Colors.deepPurple, size: 24),
                SizedBox(width: 8),
                Text(
                  value,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          // Heading aligned to the right
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
