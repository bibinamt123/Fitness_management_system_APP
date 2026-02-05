// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gym_guide/homee/screens/main_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../main.dart';
//
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
//       home: const login(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class login extends StatefulWidget {
//   const login({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<login> createState() => _loginState();
// }
//
// class _loginState extends State<login> {
//   TextEditingController namecontroller = new TextEditingController();
//   TextEditingController pcontroller = new TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 400,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/background.png'),
//                           fit: BoxFit.fill
//                       )
//                   ),
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned(
//                           left: 30,
//                           width: 80,
//                           height: 200,
//                           child: 	Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage('assets/images/light-1.png')
//                                 )
//                             ),
//                           )),
//                       Positioned(
//                           left: 140,
//                           width: 80,
//                           height: 150,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage('assets/images/light-2.png')
//                                 )
//                             ),
//                           )),
//                       Positioned(
//                           right: 40,
//                           top: 40,
//                           width: 80,
//                           height: 150,
//                           child:
//
//                           Container(
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage('assets/images/clock.png')
//                                 )
//                             ),
//                           )),
//
//                       Positioned(
//
//
//                           child:		Container(
//                             margin: EdgeInsets.only(top: 50),
//                             child: Center(
//                               child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
//                             ),
//                           )),
//
//                     ],
//                   ),
//                 ),
//
//
//                 Padding(
//                   padding: EdgeInsets.all(30.0),
//                   child: Column(
//                     children: <Widget>[
//
//
//                       Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromRGBO(143, 148, 251, .2),
//                                   blurRadius: 20.0,
//                                   offset: Offset(0, 10)
//                               )
//                             ]
//                         ),
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                   border: Border(bottom: BorderSide(color: Colors.grey))
//                               ),
//                               child: TextFormField(
//                                 controller: namecontroller,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Email or Phone number",
//                                     hintStyle: TextStyle(color: Colors.grey[400])
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(8.0),
//                               child: TextFormField(
//                                 controller: pcontroller,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Password",
//                                     hintStyle: TextStyle(color: Colors.grey[400])
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30,),
//
//
//                       Container(
//                         height: 50,
//                         width: 200,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromRGBO(143, 148, 251, 1),
//                                   Color.fromRGBO(143, 148, 251, .6),
//                                 ]
//                             )
//                         ),
//                         child: TextButton(
//                           onPressed: () {
//                             _send_data();
//                           },
//                           child: Text( "Login", style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, ), ),
//
//                           // FadeAnimation(1.5,
//                           //
//                           // Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
//                         ) ,
//
//                         ),
//
//
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
//   void _send_data() async {
//     String uname = namecontroller.text;
//     String pass = pcontroller.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String imgurl = sh.getString('img_url').toString();
//
//     final urls = Uri.parse('$url/user_login_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'username': uname, //'name'in request.post['name]
//         'password': pass,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String lid = jsonDecode(response.body)['lid'].toString();
//           String img = imgurl+jsonDecode(response.body)['image'].toString();
//           sh.setString("lid", lid);
//           sh.setString("im", img);
//           print("hellooo");
//
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(title: '',),),);
//
//
//
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => home(title: ""),
//           //     ));
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
// }
