// import 'package:flutter/material.dart';
// import 'package:gym_guide/track_their_progress.dart';
// import 'package:gym_guide/view%20rq%20status.dart';
// import 'package:gym_guide/view_dietplans.dart';
// import 'package:gym_guide/view_motivationalvideos.dart';
// import 'package:gym_guide/view_profile.dart';
// import 'package:gym_guide/view_serviceplans.dart';
// import 'package:gym_guide/view_tips.dart';
// import 'package:gym_guide/view_trainers.dart';
// import 'package:gym_guide/view_workoutplans.dart';
// import 'package:gym_guide/view_workoutvideos.dart';
//
// // function to trigger app build
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   final appTitle = 'Flutter Drawer Demo';
//
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: appTitle,
//       home: MyHomePage(title: appTitle),
//     ); // MaterialApp
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   final String title;
//
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: Colors.green,
//       ),
//       body: const Center(
//           child: Text(
//             'A drawer is an invisible side screen.',
//             style: TextStyle(fontSize: 20.0),
//           )),
//       drawer: Drawer(
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.green,
//               ), //BoxDecoration
//               child: UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(color: Colors.green),
//                 accountName: Text(
//                   "Abhishek Mishra",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 accountEmail: Text("abhishekm977@gmail.com"),
//                 currentAccountPictureSize: Size.square(50),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundColor: Color.fromARGB(255, 165, 255, 137),
//                   child: Text(
//                     "A",
//                     style: TextStyle(fontSize: 30.0, color: Colors.blue),
//                   ), //Text
//                 ), //circleAvatar
//               ), //UserAccountDrawerHeader
//             ), //DrawerHeader
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text(' My Profile '),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => viewprofilePage(title: "Home"),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.book),
//               title: const Text(' View Trainer '),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => viewtrainersPage(title: ""),));
//               },
//             ),ListTile(
//               leading: const Icon(Icons.book),
//               title: const Text(' View Trainer Request'),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => reqstatus(title: ""),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.workspace_premium),
//               title: const Text(' Services '),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => viewserviceplans(),));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.video_label),
//               title: const Text('Workout Plans '),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => ViewWorkoutPlans(title: '',),));
//
//               },
//             ),
//
//
//
//             ListTile(
//               leading: const Icon(Icons.video_label),
//               title: const Text('Diet Plans '),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => ViewDietPlans(title: '',),));
//
//               },
//             ),
//
//
//
//             ListTile(
//               leading: const Icon(Icons.video_label),
//               title: const Text('Tips'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => ViewTipsPage(title: '',),));
//
//               },
//             ),
//
//
//
//
//
//             ListTile(
//               leading: const Icon(Icons.video_label),
//               title: const Text('Motivational Videos'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => ViewSession(title: '',),));
//
//               },
//             ),
//
//
//             ListTile(
//               leading: const Icon(Icons.video_label),
//               title: const Text('Workout Videos'),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => viewworkoutvideos(title: '',),));
//
//               },
//             ),
//
//
//
//
//
//
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Add Progress '),
//               onTap: () {
//
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => TrackTheirProgressApp(),));
//
//               },
//             ),
//
//
//
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('LogOut'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ), //Drawer
//     );
//   }
// }
