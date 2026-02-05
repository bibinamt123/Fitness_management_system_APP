import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/viewattendance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const viewserviceplans());
}

class viewserviceplans extends StatelessWidget {
  const viewserviceplans({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Plan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const viewclassplan(title: 'View Service Plan'),
    );
  }
}

class viewclassplan extends StatefulWidget {
  const viewclassplan({super.key, required this.title});

  final String title;

  @override
  State<viewclassplan> createState() => _viewclassplanState();
}

class _viewclassplanState extends State<viewclassplan> {

  _viewclassplanState(){
    viewserviceplans();
  }

  List<String> id_ = [];
  List<String> time_ = [];
  List<String> class_ = [];
  List<String> video_ = [];
  List<String> date_ = [];
  List<String> desc_ = [];

  // This function will fetch service plan data
  Future<void> viewserviceplans() async {
    List<String> id = [];
    List<String> time = [];
    List<String> classname = [];
    List<String> desc = [];
    List<String> video = [];
    List<String> date = [];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewclassplan/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        time.add(arr[i]['time'].toString());
        date.add(arr[i]['date'].toString());
        video.add(sh.getString('img_url').toString()+arr[i]['video'].toString()); // Use correct key if needed
        classname.add(arr[i]['classname'].toString()); // Use correct key if needed
        desc.add(arr[i]['description'].toString()); // Use correct key if needed
      }

      setState(() {
        id_ = id;
        time_ = time;
        date_ = date;
        video_ = video;
        class_ = classname;
        desc_ = desc;
      });

      print(status);
    } catch (e) {
      print("Error: " + e.toString());
      Fluttertoast.showToast(msg: "Error loading service plans.");
    }
  }

  @override
  void initState() {
    super.initState();
    viewserviceplans();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen(title: '')),
        );
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
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ServicePlanCard(

              id: id_[index],
              time: time_[index],
              date: date_[index],
              classname: class_[index],
              desc: desc_[index],
              video : video_[index],
            );
          },
        ),




      ),
    );
  }
}

// Extracted widget for service plan card
class ServicePlanCard extends StatelessWidget {
  final String id;
  final String time;
  final String date;
  final String desc;
  final String classname;
  final String video;


  const ServicePlanCard({
    Key? key,
    required this.id,
    required this.time,
    required this.date,
    required this.classname,
    required this.desc,
    required this.video,
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
            // timeplaint Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range, size: 20),
                    SizedBox(width: 8),
                    Text("Date"),
                  ],
                ),
                Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

            Row(
              children: [
                Icon(Icons.card_giftcard, size: 20),
                SizedBox(width: 8),
                Text("time"),
              ],
            ),
            Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Divider(),

        // Status Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text("Classname"),
              ],
            ),
            Text(classname, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

            Divider(),

            // video Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Align the content centrally
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => _launchURL(video),
                ),
                Text(
                  'Play Video', // The text label
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Customize the style
                ),
              ],
            ),
            Divider(),

            // Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 20),
                    SizedBox(width: 8),
                    Text("Description"),
                  ],
                ),
                Text(desc, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),



            // ElevatedButton(onPressed: () async {
            //
            //   SharedPreferences sh = await SharedPreferences.getInstance();
            //   sh.setString('cid', id);
            //
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => ViewAttendance(title: '',)));
            //
            //
            // }, child: Text("Attendance"))



            // Date Row

          ],
        ),
      ),

    );
  }
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}













