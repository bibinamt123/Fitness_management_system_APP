import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewTips());
}

class ViewTips extends StatelessWidget {
  const ViewTips({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Tips',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTipsPage(title: 'View Tips'),
    );
  }
}

class ViewTipsPage extends StatefulWidget {
  const ViewTipsPage({super.key, required this.title});

  final String title;

  @override
  State<ViewTipsPage> createState() => _ViewTipsPageState();
}

class _ViewTipsPageState extends State<ViewTipsPage> {
  List<String> id_ = <String>[];
  List<String> tips_ = <String>[];
  List<String> trainer_ = <String>[];
  List<String> cat_ = <String>[];
  List<String> desc_ = <String>[];

  Future<void> viewTips() async {
    List<String> id = <String>[];
    List<String> tips = <String>[];
    List<String> trainer = <String>[];
    List<String> cat = <String>[];
    List<String> desc = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewtips/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        tips.add(arr[i]['tips'].toString());
        trainer.add(arr[i]['trainer'].toString());
        cat.add(arr[i]['category'].toString());
        desc.add(arr[i]['description'].toString());
      }

      setState(() {
        id_ = id;
        tips_ = tips;
        trainer_ = trainer;
        cat_=cat;
        desc_=desc;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    viewTips();
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
              tip: tips_[index],
              trainer: trainer_[index],
              cat: cat_[index],
              desc: desc_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String tip;
  final String cat;
  final String desc;
  final String trainer;

  const TipCard({Key? key, required this.tip,required this.cat,required this.desc, required this.trainer}) : super(key: key);

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
                  "Category:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    cat,
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
                  "Description:",
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
