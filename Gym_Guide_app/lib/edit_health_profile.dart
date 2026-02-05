import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:gym_guide/login/main.dart';
import 'package:gym_guide/view_health_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditHealthProfile(title: 'Health Profile'),
    );
  }
}

class EditHealthProfile extends StatefulWidget {
  const EditHealthProfile({super.key, required this.title});

  final String title;

  @override
  State<EditHealthProfile> createState() => _EditHealthProfileState();
}

class _EditHealthProfileState extends State<EditHealthProfile> {
  int _counter = 0;

  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  String gender = "Male";
  String obesity = "Normal";
  String bloodPressure = "Normal";
  String diabetes = "Normal";
  String cholestrol = "low-density lipoprotein (LDL)";
  String alcoholabuse = "Light or social drinkers";
  String druguse = "No";
  String smoking = "No";
  String headaches = "No";
  String asthma = "No";
  String heart = "No";
  String cancer = "No";
  String stroke = "No";
  String bone = "No";
  String kidney = "No";
  String liver = "No";
  String depression = "No";
  String allergies = "No";
  String arthritis = "No";
  String pregnancy = "No";

  _EditHealthProfileState(){
    _send_data();
  }

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
          String Age=jsonDecode(response.body)['Age'].toString();
          String Gender=jsonDecode(response.body)['Gender'].toString();
          String Obicity=jsonDecode(response.body)['Obicity'].toString();
          String Bloodpressure=jsonDecode(response.body)['Bloodpressure'].toString();
          String Diabetes=jsonDecode(response.body)['Diabetes'].toString();
          String Cholestrol=jsonDecode(response.body)['Cholestrol'].toString();
          String Alcoholabuse=jsonDecode(response.body)['Alcoholabuse'].toString();
          String Druguse=url=jsonDecode(response.body)['Druguse'].toString();
          String Smoking=url=jsonDecode(response.body)['Smoking'].toString();
          String Headaches=url=jsonDecode(response.body)['Headaches'].toString();
          String Asthma=url=jsonDecode(response.body)['Asthma'].toString();
          String Heartproblem=url=jsonDecode(response.body)['Heartproblem'].toString();
          String Cancer=url=jsonDecode(response.body)['Cancer'].toString();
          String Stroke=url=jsonDecode(response.body)['Stroke'].toString();
          String Bone_joint=url=jsonDecode(response.body)['Bone_joint'].toString();
          String Kidney=url=jsonDecode(response.body)['Kidney'].toString();
          String Liver=url=jsonDecode(response.body)['Liver'].toString();
          String Depression=url=jsonDecode(response.body)['Depression'].toString();
          String Allergies=url=jsonDecode(response.body)['Allergies'].toString();
          String Arthritis=url=jsonDecode(response.body)['Arthritis'].toString();
          String Pregnancy=url=jsonDecode(response.body)['Pregnancy'].toString();
          String bmi=url=jsonDecode(response.body)['bmi'].toString();
          // String Bloodgroup=url+jsonDecode(response.body)['Bloodgroup'];
          // String Bodytype=url+jsonDecode(response.body)['Bodytype'];

          setState(() {

            heightController.text = Height;
            weightController.text = Weight;
            ageController.text = Age;
            Gender=Gender;
            obesity=Obicity;
            bloodPressure=Bloodpressure;
            diabetes=Diabetes;
            cholestrol=Cholestrol;
            alcoholabuse=Alcoholabuse;
            druguse=Druguse;
            smoking=Smoking;
            headaches=Headaches;
            asthma=Asthma;
            heart=Heartproblem;
            cancer=Cancer;
            stroke=Stroke;
            bone=Bone_joint;
            kidney=Kidney;
            liver=Liver;
            depression=Depression;
            allergies=Allergies;
            arthritis=Arthritis;
            pregnancy=Pregnancy;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the EditHealthProfile object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(
          child: Text(widget.title, textAlign: TextAlign.center),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 3,
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(
                labelText: 'Height',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: 'Weight',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),

            SizedBox(
              height: 4,
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 4,
            ),


            Row(
              children: [
                Text(" Gender:"),
                Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = "Male";
                      });
                    }),
                Text("Male"),
                SizedBox(
                  width: 3,
                ),
                Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = "Female";
                      });
                    }),
                Text("Female"),
                SizedBox(
                  width: 3,
                ),
                Radio(
                    value: "Others",
                    groupValue: gender,
                    // onChanged: (String? value) {
                    //   gender = "Others";
                    onChanged: (value) {
                      setState(() {
                        gender = "Others";
                      });
                    }),
                Text("Others")
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(children: [
              SizedBox(
                width: 105,
                child: Text("  Obesity : "),
              ),
              DropdownButton(
                value: obesity,
                onChanged: (String? newValue) {
                  setState(() {
                    obesity = newValue.toString();
                  });
                },
                items: <String>[
                  'Normal',
                  'OverWeight',
                  'Obesity',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
            Row(children: [
              SizedBox(width: 105, child: Text("  Blood Pressure : ")),
              DropdownButton(
                value: bloodPressure,
                onChanged: (String? newValue) {
                  setState(() {
                    bloodPressure = newValue.toString();
                  });
                },
                items: <String>[
                  'Low',
                  'Normal',
                  'High',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 3,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Diabetes : ")),
              DropdownButton(
                value: diabetes,
                onChanged: (String? newValue) {
                  setState(() {
                    diabetes = newValue.toString();
                  });
                },
                items: <String>[
                  'Low',
                  'Normal',
                  'High',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Cholestrol : ")),
              DropdownButton(
                value: cholestrol,
                onChanged: (String? newValue) {
                  setState(() {
                    cholestrol = newValue.toString();
                  });
                },
                items: <String>[
                  'low-density lipoprotein (LDL)',
                  'high-density lipoprotein (HDL)',
                  'Lipoprotein(a) Cholesterol ',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Alcohol Abuse : ")),
              DropdownButton(
                value: alcoholabuse,
                onChanged: (String? newValue) {
                  setState(() {
                    alcoholabuse = newValue.toString();
                  });
                },
                items: <String>[
                  'Light or social drinkers',
                  'Moderate drinker',
                  'Heavy drinkers',
                  'No Use',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Drug use: ")),
              DropdownButton(
                value: druguse,
                onChanged: (String? newValue) {
                  setState(() {
                    druguse = newValue.toString();
                  });
                },
                items: <String>['stimulants', 'narcotics', 'sedatives', 'No']
                    .map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Smoking: ")),
              DropdownButton(
                value: smoking,
                onChanged: (String? newValue) {
                  setState(() {
                    smoking = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Headaches: ")),
              DropdownButton(
                value: headaches,
                onChanged: (String? newValue) {
                  setState(() {
                    headaches = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Asthma: ")),
              DropdownButton(
                value: asthma,
                onChanged: (String? newValue) {
                  setState(() {
                    asthma = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Heart Problems: ")),
              DropdownButton(
                value: heart,
                onChanged: (String? newValue) {
                  setState(() {
                    heart = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Cancer: ")),
              DropdownButton(
                value: cancer,
                onChanged: (String? newValue) {
                  setState(() {
                    cancer = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Stroke: ")),
              DropdownButton(
                value: stroke,
                onChanged: (String? newValue) {
                  setState(() {
                    stroke = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Bone issue: ")),
              DropdownButton(
                value: bone,
                onChanged: (String? newValue) {
                  setState(() {
                    bone = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Kidney issue: ")),
              DropdownButton(
                value: kidney,
                onChanged: (String? newValue) {
                  setState(() {
                    kidney = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Liver issue: ")),
              DropdownButton(
                value: liver,
                onChanged: (String? newValue) {
                  setState(() {
                    liver = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Depression: ")),
              DropdownButton(
                value: depression,
                onChanged: (String? newValue) {
                  setState(() {
                    depression = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Allergics/sinus: ")),
              DropdownButton(
                value: allergies,
                onChanged: (String? newValue) {
                  setState(() {
                    allergies = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            Row(children: [
              SizedBox(width: 105, child: Text("  Pregnancy: ")),
              DropdownButton(
                value: pregnancy,
                onChanged: (String? newValue) {
                  setState(() {
                    pregnancy = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 4,
            ),
            Row(children: [
              SizedBox(width: 105, child: Text("  Arthritis: ")),
              DropdownButton(
                value: arthritis,
                onChanged: (String? newValue) {
                  setState(() {
                    arthritis = newValue.toString();
                  });
                },
                items: <String>[
                  'No',
                  'Yes',
                ].map<DropdownMenuItem<String>>((String values) {
                  return DropdownMenuItem<String>(
                    value: values,
                    child: Text(values),
                  );
                }).toList(),
              ),
            ]),

            SizedBox(
              height: 4,
            ),
            ElevatedButton(
                onPressed: () {
                  senddata();
                  // Route
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => MyHome(title: 'Login'),
                  //     ));
                },
                child: Text('Submit'))
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void senddata() async {
    // void senddata() async {
    String height = heightController.text;
    String weight = weightController.text;
    String age = ageController.text;
    // String phone = phoneController.text;
    // String place = placeController.text;
    // String post = postController.text;
    // String district = postController.text;
    // String pin = pinController.text;
    // String password = passwordController.text;
    // String cpassword = confirmPasswordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/Edit_health_profile/');
    try {
      final response = await http.post(urls, body: {
        'Height': height,
        'Weight': weight,
        'Age': age,
        'Gender': gender,
        'Obicity': obesity,
        'Bloodpressure': bloodPressure,
        'Diabetes': diabetes,
        'Cholestrol': cholestrol,
        'Alcoholabuse': alcoholabuse,
        'Druguse': druguse,
        'Smoking': smoking,
        'Headaches': headaches,
        'Asthma': asthma,
        'Heartproblem': heart,
        'Cancer': cancer,
        'Stroke': stroke,
        'Bone_joint': bone,
        'Kidney': kidney,
        'Liver': liver,
        'Depression': depression,
        'Allergies': allergies,
        'Arthritis': arthritis,
        'Pregnancy': pregnancy,
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == "ok") {
          Fluttertoast.showToast(msg: "Health profile Added Successfully..");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewHealthProfile(title: ''),
              ));
        } else {
          Fluttertoast.showToast(msg: "Not found");
        }
      } else {
        Fluttertoast.showToast(msg: "Not Found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
// }
}

