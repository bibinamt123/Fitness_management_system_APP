// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gym_guide/homee/main.dart';
// import 'package:gym_guide/view%20rating.dart';
// import 'package:gym_guide/view%20rq%20status.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const ViewTrainers());
// }
//
// class ViewTrainers extends StatelessWidget {
//   const ViewTrainers({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Reply',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const ViewTrainersPage(title: 'View Trainers'),
//     );
//   }
// }
//
// class ViewTrainersPage extends StatefulWidget {
//   const ViewTrainersPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewTrainersPage> createState() => _ViewTrainersPageState();
// }
//
// class _ViewTrainersPageState extends State<ViewTrainersPage> {
//   List<String> ids = [];
//   List<String> names = [];
//   List<String> phones = [];
//   List<String> emails = [];
//   List<String> qualifications = [];
//   List<String> specialization = [];
//   List<String> ages = [];
//   List<String> genders = [];
//   List<String> photos = [];
//   List<String> experiences = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewTrainers();
//   }
//
//   Future<void> viewTrainers() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = '${sh.getString('url')}/viewtrainers/';
//       String lid = sh.getString('lid').toString();
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsonData = json.decode(data.body);
//       String status = jsonData['status'];
//
//       var trainersData = jsonData['data'];
//
//       for (var trainer in trainersData) {
//         ids.add(trainer['id'].toString());
//         names.add(trainer['name'].toString());
//         phones.add(trainer['phone'].toString());
//         emails.add(trainer['email'].toString());
//         qualifications.add(trainer['qualification'].toString());
//         specialization.add(trainer['specialization'].toString());
//         ages.add(trainer['age'].toString());
//         genders.add(trainer['gender'].toString());
//         photos.add(trainer['photo'].toString());
//         experiences.add(trainer['experience'].toString());
//       }
//
//       setState(() {});
//     } catch (e) {
//       print("Error fetching trainers data: $e");
//     }
//   }
//
//   Future<void> sendRequest(BuildContext context, String trainerId) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String lid = sh.getString('lid').toString();
//       String? url = sh.getString('url');
//
//       if (url == null || lid == null) {
//         Fluttertoast.showToast(msg: 'Error fetching URL or User ID');
//         return;
//       }
//
//       final response = await http.post(Uri.parse('$url/sendtrainerrequest/'), body: {
//         "tid": trainerId,
//         "lid": lid,
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Request sent successfully');
//           Navigator.push(context, MaterialPageRoute(builder: (context) => reqstatus(title: '',)));
//         } else {
//           Fluttertoast.showToast(msg: 'Already Requested');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => MainScreen(title: "")),
//             );
//           }),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           itemCount: ids.length,
//           itemBuilder: (context, index) {
//             return TrainerCard(
//               name: names[index],
//               phone: phones[index],
//               email: emails[index],
//               specialization: specialization[index],
//               qualification: qualifications[index],
//               age: ages[index],
//               gender: genders[index],
//               photo: photos[index],
//               experience: experiences[index],
//               onRequest: () => sendRequest(context, ids[index]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class TrainerCard extends StatelessWidget {
//   final String name, phone, email, qualification, specialization,age, gender, photo, experience;
//   final VoidCallback onRequest;
//
//   const TrainerCard({
//     super.key,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.qualification,
//     required this.specialization,
//     required this.age,
//     required this.gender,
//     required this.photo,
//     required this.experience,
//     required this.onRequest,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       margin: const EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.person, color: Colors.deepPurple),
//                     SizedBox(width: 8),
//                     Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(name),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.phone, color: Colors.green),
//                     SizedBox(width: 8),
//                     Text('Phone:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(phone),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.email, color: Colors.blue),
//                     SizedBox(width: 8),
//                     Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(email),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.school, color: Colors.orange),
//                     SizedBox(width: 8),
//                     Text('Qualification:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(qualification),
//               ],
//             ),
//
//
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.folder_special, color: Colors.black),
//                     SizedBox(width: 8),
//                     Text('Specialization:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(specialization),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_today, color: Colors.purple),
//                     SizedBox(width: 8),
//                     Text('Dob:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(age),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.wc, color: Colors.red),
//                     SizedBox(width: 8),
//                     Text('Gender:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(gender),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.work, color: Colors.blueGrey),
//                     SizedBox(width: 8),
//                     Text('Experience:', style: TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(experience),
//               ],
//             ),
//             Divider(),
//             ElevatedButton(
//               onPressed: onRequest,
//               child: Text("Request"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 sh.setString('tid', ids[index]);
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => View_Rating(title: '')),
//                 );
//
//               },
//               child: Text("Review"),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/login/view_schedule.dart';
import 'package:gym_guide/view%20rating.dart';
import 'package:gym_guide/view%20rq%20status.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewTrainers());
}

class ViewTrainers extends StatelessWidget {
  const ViewTrainers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTrainersPage(title: 'View Trainers'),
    );
  }
}

class ViewTrainersPage extends StatefulWidget {
  const ViewTrainersPage({super.key, required this.title});

  final String title;

  @override
  State<ViewTrainersPage> createState() => _ViewTrainersPageState();
}

class _ViewTrainersPageState extends State<ViewTrainersPage> {
  List<String> ids = [];
  List<String> names = [];
  List<String> phones = [];
  List<String> emails = [];
  List<String> qualifications = [];
  List<String> specialization = [];
  List<String> ages = [];
  List<String> genders = [];
  List<String> photos = [];
  List<String> experiences = [];

  @override
  void initState() {
    super.initState();
    viewTrainers();
  }

  Future<void> viewTrainers() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = '${sh.getString('url')}/viewtrainers/';
      String lid = sh.getString('lid').toString();

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsonData = json.decode(data.body);
      String status = jsonData['status'];

      var trainersData = jsonData['data'];

      for (var trainer in trainersData) {
        ids.add(trainer['id'].toString());
        names.add(trainer['name'].toString());
        phones.add(trainer['phone'].toString());
        emails.add(trainer['email'].toString());
        qualifications.add(trainer['qualification'].toString());
        specialization.add(trainer['specialization'].toString());
        ages.add(trainer['age'].toString());
        genders.add(trainer['gender'].toString());
        photos.add(trainer['photo'].toString());
        experiences.add(trainer['experience'].toString());
      }

      setState(() {});
    } catch (e) {
      print("Error fetching trainers data: $e");
    }
  }

  Future<void> sendRequest(BuildContext context, String trainerId) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String lid = sh.getString('lid').toString();
      String? url = sh.getString('url');

      if (url == null || lid == null) {
        Fluttertoast.showToast(msg: 'Error fetching URL or User ID');
        return;
      }

      final response = await http.post(Uri.parse('$url/sendtrainerrequest/'), body: {
        "tid": trainerId,
        "lid": lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Request sent successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context) => reqstatus(title: '',)));
        } else {
          Fluttertoast.showToast(msg: 'Already Requested');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen(title: "")),
            );
          }),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: ids.length,
          itemBuilder: (context, index) {
            return TrainerCard(
              id: ids[index],  // Pass the trainer's ID here
              name: names[index],
              phone: phones[index],
              email: emails[index],
              specialization: specialization[index],
              qualification: qualifications[index],
              age: ages[index],
              gender: genders[index],
              photo: photos[index],
              experience: experiences[index],
              onRequest: () => sendRequest(context, ids[index]),  // Pass trainer ID
              onReview: () async {
                SharedPreferences sh = await SharedPreferences.getInstance();
                sh.setString('tid', ids[index]);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => View_Rating(title: '')),
                );
              },
              onSchedule: () async {
                SharedPreferences sh = await SharedPreferences.getInstance();
                sh.setString('tid', ids[index]);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewSchedule(title: '')),
                );
              },

            );
          },
        ),
      ),
    );
  }
}

class TrainerCard extends StatelessWidget {
  final String id, name, phone, email, qualification, specialization, age, gender, photo, experience;
  final VoidCallback onRequest;
  final VoidCallback onReview;
  final VoidCallback onSchedule;

  const TrainerCard({
    super.key,
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.qualification,
    required this.specialization,
    required this.age,
    required this.gender,
    required this.photo,
    required this.experience,
    required this.onRequest,
    required this.onReview,
    required this.onSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(name),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Phone:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(phone),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(email),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.school, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Qualification:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(qualification),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.folder_special, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Specialization:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(specialization),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.purple),
                    SizedBox(width: 8),
                    Text('Dob:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(age),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.wc, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Gender:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(gender),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.work, color: Colors.blueGrey),
                    SizedBox(width: 8),
                    Text('Experience:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(experience),
              ],
            ),
            Divider(),
            ElevatedButton(
              onPressed: onRequest,
              child: Text("Request"),
            ),
            ElevatedButton(
              onPressed: onReview,
              child: Text("Review"),
            ),

            ElevatedButton(
              onPressed: onSchedule,
              child: Text("Schedule"),
            ),
          ],
        ),
      ),
    );
  }
}
