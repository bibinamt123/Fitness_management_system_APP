import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'edit_health_profile.dart';


void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewHealthProfile(title: 'View Profile'),
    );
  }
}

class ViewHealthProfile extends StatefulWidget {
  const ViewHealthProfile({super.key, required this.title});

  final String title;

  @override
  State<ViewHealthProfile> createState() => _ViewHealthProfileState();
}

class _ViewHealthProfileState extends State<ViewHealthProfile> {

  _ViewHealthProfileState()
  {
    _send_data();
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Image(image: NetworkImage(photo_),height: 200,width: 200,),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Height_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Height: "),
                        Text(Height_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Weight_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Weight: "),
                        Text(Weight_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Age_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Age: "),
                        Text(Age_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Gender_),
                    // ),
                    // SizedBox(
                    //   height: 11,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("Gender: "),
                    //     Text(Gender_),
                    //   ],
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text( Obicity_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Obicity: "),
                        Text(Obicity_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Bloodpressure_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bloodpressure: "),
                        Text(Bloodpressure_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Diabetes_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Diabetes: "),
                        Text(Diabetes_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Cholestrol_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cholestrol: "),
                        Text(Cholestrol_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Alcoholabuse_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Alcoholabuse: "),
                        Text(Alcoholabuse_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Druguse_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Druguse: "),
                        Text(Druguse_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Smoking_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Smoking: "),
                        Text(Smoking_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Headaches_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Headaches: "),
                        Text(Headaches_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Asthma_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Asthma: "),
                        Text(Asthma_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Heartproblem_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Heartproblem: "),
                        Text(Heartproblem_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Cancer_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cancer: "),
                        Text(Cancer_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Stroke_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Stroke: "),
                        Text(Stroke_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Bone_joint_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bone joint: "),
                        Text(Bone_joint_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Kidney_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Kidney: "),
                        Text(Kidney_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Liver_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Liver: "),
                        Text(Liver_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Depression_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Depression: "),
                        Text(Depression_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Allergies_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Allergies: "),
                        Text(Allergies_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Arthritis_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Arthritis: "),
                        Text(Arthritis_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Pregnancy_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pregnancy: "),
                        Text(Pregnancy_),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(bmi_),
                    // ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("bmi: "),
                        Text(bmi_),
                      ],
                    ),
                
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Bloodgroup_),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(Bodytype_),
                    // ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditHealthProfile(title: "Edit Health Profile"),));
                },
                child: Text("Edit Profile"),
              ),

            ],
          ),
        ),
      ),
    );
  }


  String Height_="";
  String Weight_="";
  String Age_="";
  // String Gender_="";
  String Obicity_="";
  String Bloodpressure_="";
  String Diabetes_="";
  String Cholestrol_="";
  String Alcoholabuse_="";
  String Druguse_="";
  String Smoking_="";
  String Headaches_="";
  String Asthma_="";
  String Heartproblem_="";
  String Cancer_="";
  String Stroke_="";
  String Bone_joint_="";
  String Kidney_="";
  String Liver_="";
  String Depression_="";
  String Allergies_="";
  String Arthritis_="";
  String Pregnancy_="";
  String bmi_="";
  // String Bloodgroup_="";
  // String Bodytype_="";



  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/View_health_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String Height=jsonDecode(response.body)['Height'].toString();
          String Weight=jsonDecode(response.body)['Weight'].toString();
          String Age=jsonDecode(response.body)['Age'];
          // String Gender=jsonDecode(response.body)['Gender'];
          String Obicity=jsonDecode(response.body)['Obicity'];
          String Bloodpressure=jsonDecode(response.body)['Bloodpressure'];
          String Diabetes=jsonDecode(response.body)['Diabetes'];
          String Cholestrol=jsonDecode(response.body)['Cholestrol'];
          String Alcoholabuse=jsonDecode(response.body)['Alcoholabuse'];
          String Druguse=url=jsonDecode(response.body)['Druguse'];
          String Smoking=url=jsonDecode(response.body)['Smoking'];
          String Headaches=url=jsonDecode(response.body)['Headaches'];
          String Asthma=url=jsonDecode(response.body)['Asthma'];
          String Heartproblem=url=jsonDecode(response.body)['Heartproblem'];
          String Cancer=url=jsonDecode(response.body)['Cancer'];
          String Stroke=url=jsonDecode(response.body)['Stroke'];
          String Bone_joint=url=jsonDecode(response.body)['Bone_joint'];
          String Kidney=url=jsonDecode(response.body)['Kidney'];
          String Liver=url=jsonDecode(response.body)['Liver'];
          String Depression=url=jsonDecode(response.body)['Depression'];
          String Allergies=url=jsonDecode(response.body)['Allergies'];
          String Arthritis=url=jsonDecode(response.body)['Arthritis'];
          String Pregnancy=url=jsonDecode(response.body)['Pregnancy'];
          String bmi=url=jsonDecode(response.body)['bmi'].toString();
          // String Bloodgroup=url+jsonDecode(response.body)['Bloodgroup'];
          // String Bodytype=url+jsonDecode(response.body)['Bodytype'];

          setState(() {

            Height_= Height;
            Weight_= Weight;
            Age_= Age;
            // Gender_= Gender;
            Obicity_= Obicity;
            Bloodpressure_= Bloodpressure;
            Diabetes_= Diabetes;
            Cholestrol_= Cholestrol;
            Alcoholabuse_= Alcoholabuse;
            Druguse_= Druguse;
            Smoking_= Smoking;
            Headaches_= Headaches;
            Asthma_= Asthma;
            Heartproblem_= Heartproblem;
            Cancer_= Cancer;
            Stroke_= Stroke;
            Bone_joint_= Bone_joint;
            Kidney_= Kidney;
            Liver_= Liver;
            Depression_= Depression;
            Allergies_= Allergies;
            Arthritis_= Arthritis;
            Pregnancy_= Pregnancy;
            bmi_= bmi;
            // Bloodgroup_= Bloodgroup;
            // Bodytype_= Bodytype;
          });





        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       // Here we take the value from the MyProfile object that was created by
  //       // the App.build method, and use it to set our appbar title.
  //       title: Align(
  //         child: Text(widget.title, textAlign: TextAlign.center),
  //         alignment: Alignment.center,
  //       ),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           // CircleAvatar(
  //           //   backgroundImage: NetworkImage(photo_),
  //           //   radius: 50,
  //           // ),
  //
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Height:"),
  //               Text(Height_),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 11,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Weight:"),
  //               Text(Weight_),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 11,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Age:"),
  //               Text(Age_),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 11,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Obicity:"),
  //               Text(Obicity_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Bloodpressure:"),
  //               Text(Bloodpressure_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Diabetes:"),
  //               Text(Diabetes_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Pincode:"),
  //               Text(post_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Pin:"),
  //               Text(pin_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("District:"),
  //               Text(district_),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text("Blood:"),
  //               Text(type_),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 4,
  //           ),
  //           ElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => MyEditPage(title: 'Login'),
  //                     ));
  //               },
  //               child: Text('EDIT'))
  //           // ElevatedButton(
  //           //     onPressed: () {
  //           //       Navigator.push(
  //           //           context,
  //           //           MaterialPageRoute(
  //           //             builder: (context) => MySignPage(title: 'Signup'),
  //           //           ));
  //           //     },
  //           //     child: Text("Button"))
  //           // const Text(
  //           //   'You have pushed the button this many times:',
  //           // ),
  //           // Text(
  //           //   '$_counter',
  //           //   style: Theme.of(context).textTheme.headline4,
  //           // ),
  //         ],
  //       ),
  //     ),
  //     // floatingActionButton: FloatingActionButton(
  //     //   onPressed: _incrementCounter,
  //     //   tooltip: 'Increment',
  //     //   child: const Icon(Icons.add),
  //     // ), // This trailing comma makes auto-formatting nicer for build methods.
  //   );
  // }
}
