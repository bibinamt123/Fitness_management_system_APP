import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_guide/homee/screens/main_screen.dart';
import 'package:gym_guide/login/main.dart';
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
      home: const MyHealthProfile(title: 'Health Profile'),
    );
  }
}

class MyHealthProfile extends StatefulWidget {
  const MyHealthProfile({super.key, required this.title});

  final String title;

  @override
  State<MyHealthProfile> createState() => _MyHealthProfileState();
}

class _MyHealthProfileState extends State<MyHealthProfile> {
  int _counter = 0;

  TextEditingController heightController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  // String gender = "Male";
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHealthProfile object that was created by
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
              onTap: () async {
                // Set an initial date
                DateTime initialDate = ageController.text.isEmpty
                    ? DateTime.now()
                    : DateTime.parse(ageController.text);

                // Open a date picker with the initial date
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: initialDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  ageController.text = "${pickedDate.toLocal()}".split(' ')[0];
                }
              },
              controller: ageController,
              keyboardType:TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Dob',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            // SizedBox(
            //   height: 4,
            // ),
            //
            //
            // Row(
            //   children: [
            //     Text(" Gender:"),
            //     Radio(
            //         value: "Male",
            //         groupValue: gender,
            //         onChanged: (value) {
            //           setState(() {
            //             gender = "Male";
            //           });
            //         }),
            //     Text("Male"),
            //     SizedBox(
            //       width: 3,
            //     ),
            //     Radio(
            //         value: "Female",
            //         groupValue: gender,
            //         onChanged: (value) {
            //           setState(() {
            //             gender = "Female";
            //           });
            //         }),
            //     Text("Female"),
            //     SizedBox(
            //       width: 3,
            //     ),
            //     Radio(
            //         value: "Others",
            //         groupValue: gender,
            //         // onChanged: (String? value) {
            //         //   gender = "Others";
            //         onChanged: (value) {
            //           setState(() {
            //             gender = "Others";
            //           });
            //         }),
            //     Text("Others")
            //   ],
            // ),
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
            ), Row(children: [
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
            SizedBox(
              height: 4,
            ),
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

    final urls = Uri.parse('$url/Add_health_profile/');
    try {
      final response = await http.post(urls, body: {
        'Height': height,
        'Weight': weight,
        'Age': age,
        // 'Gender': gender,
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
                builder: (context) => MainScreen(title: '',),
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
}

