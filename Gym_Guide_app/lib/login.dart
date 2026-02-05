

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyloginPage(title: 'Ip'),
//     );
//   }
// }
//
// class MyloginPage extends StatefulWidget {
//   const MyloginPage({super.key, required this.title});
//  
//   final String title;
//
//   @override
//   State<MyloginPage> createState() => _MyloginPageState();
// }
//
// class _MyloginPageState extends State<MyloginPage> {
//
// TextEditingController username =TextEditingController();
// TextEditingController password =TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const MyipPage(title: '')),
//         );
//         return false;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             leading: BackButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyipPage(title: '')),
//                 );
//               },
//             ),
//             backgroundColor: Theme.of(context).colorScheme.primary,
//             title: Text(widget.title),
//           ),
//
//
//       body:
//       Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(padding: EdgeInsets.all(8),
//               child: TextField(controller:username,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("Username"),
//               )),),
//             Padding(padding: EdgeInsets.all(8),
//               child: TextField(controller:password,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("password"),
//               )),),
//             Padding(padding: EdgeInsets.all(8),
//             child: ElevatedButton(onPressed: () {
//               _send_data();
//             }, child: Text("login")),),
//              Padding(padding: EdgeInsets.all(8),
//             child: TextButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => MylSignupPage(title: "Signup"),));
//             }, child: Text("newusersignup")),)
//
//            
//           ],
//         ),
//       ),  // This trailing comma makes auto-formatting nicer for build methods.
//       )
//     );
//   }
// void _send_data() async{
//
//
//   String uname=username.text;
//   String upassword=password.text;
//
//   SharedPreferences sh = await SharedPreferences.getInstance();
//   String url = sh.getString('url').toString();
//
//   final urls = Uri.parse('$url/and_login/');
//   try {
//     final response = await http.post(urls, body: {
//       'name':uname,
//       'password':upassword,
//     });
//     if (response.statusCode == 200) {
//       String status = jsonDecode(response.body)['status'];
//       if (status=='ok') {
//
//         String lid=jsonDecode(response.body)['lid'];
//         sh.setString("lid", lid);
//
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) => MainScreen(title: "Home"),));
//       }else {
//         Fluttertoast.showToast(msg: 'Not Found');
//       }
//     }
//     else {
//       Fluttertoast.showToast(msg: 'Network Error');
//     }
//   }
//   catch (e){
//     Fluttertoast.showToast(msg: e.toString());
//   }
// }
//
// }


















import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/main.dart';
import 'package:gym_guide/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




void main() {
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      home:  MyloginPage(),
    );
  }
}


class MyloginPage extends StatefulWidget {


  MyloginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyloginPage> createState() => _LoginState();
}

class _LoginState extends State<MyloginPage> {

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formkey=GlobalKey<FormState>();


  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyIpPage(title: '',),));

        return false;
      },      child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.deepPurple.shade900,
                    Colors.deepPurple.shade800,
                    Colors.deepPurple.shade400
                  ]
              )
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),)),
                      SizedBox(height: 10,),
                      FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 60,),
                          FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                  ),
                                  child: TextFormField(
                                    controller: _controllerUsername,
                                    decoration: InputDecoration(
                                        hintText: "Email or Phone number",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    onEditingComplete: () => _focusNodePassword.requestFocus(),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email or Phone number.";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey.shade200))
                                  ),
                                  child: TextFormField(
                                    controller: _controllerPassword,
                                    focusNode: _focusNodePassword,
                                    obscureText: _obscurePassword,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: InputBorder.none
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter password.";
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),

                          SizedBox(height: 40,),
                          FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                            onPressed: () {
                              if(_formkey.currentState!.validate()){
                                _send_data();
                              }

                            },
                            height: 50,
                            // margin: EdgeInsets.symmetric(horizontal: 50),
                            color: Colors.deepPurple[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),

                            ),
                            // decoration: BoxDecoration(
                            // ),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          )),
                          // SizedBox(height: 40,),
                          // FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Don't have an account?", style: TextStyle(color: Colors.grey),)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?", style: TextStyle(color: Colors.grey),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MylSignupPage(title: '',)));
                              }, child: Text(' Register here')
                              ),



                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }


  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }


void _send_data() async{


  String uname=_controllerUsername.text;
  String upassword=_controllerPassword.text;

  SharedPreferences sh = await SharedPreferences.getInstance();
  String url = sh.getString('url').toString();
  String img = sh.getString('img_url').toString();

  final urls = Uri.parse('$url/and_login/');
  try {
    final response = await http.post(urls, body: {
      'name':uname,
      'password':upassword,
    });
    if (response.statusCode == 200) {
      String status = jsonDecode(response.body)['status'];
      if (status=='ok') {

        String lid=jsonDecode(response.body)['lid'];
        String name=jsonDecode(response.body)['name'];
        String photo=img+jsonDecode(response.body)['photo'];
        sh.setString("lid", lid);
        sh.setString("name", name);
        sh.setString("photo", photo);

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainScreen(title: "Home"),));
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

  String? validateUsername(String value){
    if(value.isEmpty){
      return 'Please enter a User Name';
    }
    return null;

  }
  String? validatePassword(String value){
    if(value.isEmpty){
      return 'Please enter a Password';
    }
    return null;

  }

}