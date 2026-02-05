//  import 'package:flutter/material.dart';
// import 'package:gym_guide/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//       home: const MyipPage(title: 'Ip'),
//     );
//   }
// }
//
// class MyipPage extends StatefulWidget {
//   const MyipPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyipPage> createState() => _MyipPageState();
// }
//
// class _MyipPageState extends State<MyipPage> {
//
//   TextEditingController ipadress=TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => MyloginPage()),
//         );
//         return false;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             leading: BackButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyloginPage()),
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
//               child: TextField(controller:ipadress,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("IP Address"),
//               )),),
//             Padding(padding: EdgeInsets.all(8),
//             child: ElevatedButton(onPressed: () async {
//               String ip=ipadress.text;
//
//               SharedPreferences sh=await SharedPreferences.getInstance();
//               sh.setString("url", "http://"+ip+":8000/myapp");
//               sh.setString("img_url", "http://"+ip+":8000");
//               Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => MyloginPage(),));
//
//             }, child: Text("SET")),)
//
//
//           ],
//         ),
//       ),  // This trailing comma makes auto-formatting nicer for build methods.
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:gym_guide/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';

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
      home: const MyIpPage(title: 'Set IP Address'),
    );
  }
}

class MyIpPage extends StatefulWidget {
  const MyIpPage({super.key, required this.title});
  final String title;

  @override
  State<MyIpPage> createState() => _MyIpPageState();
}

class _MyIpPageState extends State<MyIpPage> {
  TextEditingController ipController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadStoredIP();
  }

  // Load stored IP
  Future<void> _loadStoredIP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedIp = prefs.getString("url");
    if (storedIp != null) {
      setState(() {
        ipController.text = storedIp.replaceAll("http://", "").split(":")[0];
      });
    }
  }

  // Validate IP address
  bool isValidIPAddress(String ip) {
    final RegExp ipRegex = RegExp(
        r"^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$"); // Simple regex for IPv4
    return ipRegex.hasMatch(ip);
  }

  // Save IP and navigate
  Future<void> _saveIPAddress() async {
    if (!_formKey.currentState!.validate()) return;

    String ip = ipController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("url", "http://$ip:8000/myapp");
    await prefs.setString("img_url", "http://$ip:8000");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyloginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyloginPage()));
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: ipController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "IP Address",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an IP address";
                    } else if (!isValidIPAddress(value)) {
                      return "Enter a valid IP address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveIPAddress,
                  child: const Text("SET"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
