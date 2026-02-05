import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login/login.dart';

// import 'Signup.dart';
// import 'home.dart';

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
      home: const UserChangePass(title: 'changepassword'),
    );
  }
}

class UserChangePass extends StatefulWidget {
  const UserChangePass({super.key, required this.title});

  final String title;

  @override
  State<UserChangePass> createState() => _UserChangePassState();
}

class _UserChangePassState extends State<UserChangePass> {
  final formcontroller = GlobalKey<FormState>();

  TextEditingController currentpasscontroller = new TextEditingController();
  TextEditingController newpasscontroller = new TextEditingController();
  TextEditingController confirmpasscontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(title: '')),
        );
        return true;
      },
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img.png'), fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //
                  //   child: TextFormField(
                  //
                  //     controller: currentpasscontroller,
                  //     decoration: InputDecoration(border: OutlineInputBorder(),
                  //       labelText: 'Current Password',
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: currentpasscontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Current Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      obscureText: true, // To hide the text (password style)
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        if (value.length < 6) {
                          return null;
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: newpasscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),

                      obscureText: true, // To hide the text (password style)
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your current password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }

                        String pattern =
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: confirmpasscontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      obscureText: true, // To hide the text (password style)
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != newpasscontroller.text) {
                          return 'Passwords do not match';
                        }

                        // Add password strength validation if necessary (can be skipped for Confirm Password)
                        String pattern =
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number';
                        }

                        return null;
                      },
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          senddata();
                        }
                        // Navigate to signup screen
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 16)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void senddata() async {
    String currentpswd = currentpasscontroller.text;
    String newpswd = newpasscontroller.text;
    String confrmpswd = confirmpasscontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_change_pass/');
    try {
      final response = await http.post(urls, body: {
        'op': currentpswd,
        'np': newpswd,
        'cp': confrmpswd,
        'lid': sh.getString("lid").toString(),
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(status);
        if (status == 'ok') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyloginPage(),
              ));
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

  String? Validatecurrentpswd(String value) {
    if (value.isEmpty) {
      return 'please enter a password';
    }
    return null;
  }

  String? Validatenewpswd(String value) {
    if (value.isEmpty) {
      return 'please enter a password';
    }
    return null;
  }

  String? Validateconfrmpswd(String value) {
    if (value.isEmpty) {
      return 'please enter a password';
    }
    return null;
  }
}
