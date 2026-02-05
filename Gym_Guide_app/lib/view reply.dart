import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/send_complaint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const viewreply(title: 'View Reply'),
    );
  }
}

class viewreply extends StatefulWidget {
  const viewreply({super.key, required this.title});

  final String title;

  @override
  State<viewreply> createState() => _viewreplyState();
}

class _viewreplyState extends State<viewreply> {

  _viewreplyState(){
    viewserviceplans();
  }

  List<String> id_ = [];
  List<String> com_ = [];
  List<String> status_ = [];
  List<String> reply_ = [];
  List<String> date_ = [];

  // This function will fetch service plan data
  Future<void> viewserviceplans() async {
    List<String> id = [];
    List<String> com = [];
    List<String> statuss = [];
    List<String> reply = [];
    List<String> date = [];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewreply/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        com.add(arr[i]['complaint'].toString());
        date.add(arr[i]['date'].toString());
        reply.add(arr[i]['reply'].toString()); // Use correct key if needed
        statuss.add(arr[i]['status'].toString()); // Use correct key if needed
      }

      setState(() {
        id_ = id;
        com_ = com;
        date_ = date;
        reply_ = reply;
        status_ = statuss;
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

              com: com_[index],
              date: date_[index],
              status: status_[index],
              reply : reply_[index],
            );
          },
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sendcomplaint(title: '',)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),

      ),
    );
  }
}

// Extracted widget for service plan card
class ServicePlanCard extends StatelessWidget {
  final String com;
  final String date;
  final String status;
  final String reply;


  const ServicePlanCard({
    Key? key,
    required this.com,
    required this.date,
    required this.status,
    required this.reply,
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
            // Complaint Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.card_giftcard, size: 20),
                    SizedBox(width: 8),
                    Text("Complaint"),
                  ],
                ),
                Text(com, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),

            // Reply Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.reply_all, size: 20),
                    SizedBox(width: 8),
                    Text("Reply"),
                  ],
                ),
                Text(reply, style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Text("Status"),
                  ],
                ),
                Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),

            // Date Row
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
            Divider(),


          ],
        ),
      ),
    );
  }
}













