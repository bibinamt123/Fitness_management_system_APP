import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Viewequipment_name());
}

class Viewequipment_name extends StatelessWidget {
  const Viewequipment_name({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View equipment_name',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewFacility(title: 'View equipment_name'),
    );
  }
}

class ViewFacility extends StatefulWidget {
  const ViewFacility({super.key, required this.title});

  final String title;

  @override
  State<ViewFacility> createState() => _ViewFacilityState();
}

class _ViewFacilityState extends State<ViewFacility> {
  List<String> id_ = <String>[];
  List<String> equipment_name_ = <String>[];
  List<String> maintanance_status_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> quantity_ = <String>[];

  Future<void> viewTips() async {
    List<String> id = <String>[];
    List<String> equipment_name = <String>[];
    List<String> maintanance_status = <String>[];
    List<String> photo = <String>[];
    List<String> quantity = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewgymfacility/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];
      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        equipment_name.add(arr[i]['equipment_name'].toString());
        maintanance_status.add(arr[i]['maintanance_status'].toString());
        photo.add(sh.getString('img_url').toString()+arr[i]['photo'].toString());
        quantity.add(arr[i]['quantityription'].toString());
      }

      setState(() {
        id_ = id;
        equipment_name_ = equipment_name;
        maintanance_status_ = maintanance_status;
        photo_=photo;
        quantity_=quantity;
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
              tip: equipment_name_[index],
              maintanance_status: maintanance_status_[index],
              photo: photo_[index],
              quantity: quantity_[index],
            );
          },
        ),
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String tip;
  final String photo;
  final String quantity;
  final String maintanance_status;

  const TipCard({Key? key, required this.tip,required this.photo,required this.quantity, required this.maintanance_status}) : super(key: key);

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


            Image(image: NetworkImage(photo),height: 100,width: 100,),

            Row(
              children: [
                Icon(Icons.list, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Equipment:",
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
                Icon(Icons.countertops, size: 20, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  "Quantity:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    quantity,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // maintanance_status Information
            Row(
              children: [
                Icon(Icons.note_sharp, size: 20),
                SizedBox(width: 8),
                Text(
                  "Maintanance_status:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  maintanance_status,
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
