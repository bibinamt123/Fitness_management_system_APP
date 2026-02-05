// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gym_guide/homee/screens/main_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const sendreview(title: 'Submit Review'),
//     );
//   }
// }
//
// class sendreview extends StatefulWidget {
//   const sendreview({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<sendreview> createState() => _sendreviewState();
// }
//
// class _sendreviewState extends State<sendreview> {
//   TextEditingController reviewController = TextEditingController();
//   bool isSubmitting = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const MainScreen(title: "")),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 // Review Input Field
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: TextField(
//                     controller: reviewController,
//                     maxLines: 4,
//                     decoration: InputDecoration(
//                       labelText: 'Your Review',
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     ),
//                   ),
//                 ),
//
//                 // Submit Button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: ElevatedButton(
//                     onPressed: isSubmitting ? null : _sendData,
//                     child: isSubmitting
//                         ? const CircularProgressIndicator()
//                         : const Text('Send Review'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Function to send the review data to the server
//   void _sendData() async {
//     String about = reviewController.text;
//
//     if (about.isEmpty) {
//       Fluttertoast.showToast(msg: "Please provide a description.");
//       return;
//     }
//
//     setState(() {
//       isSubmitting = true; // Disable button during the submission
//     });
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     print(url);
//
//     final Uri sendreviewUrl = Uri.parse('$url/sendreview/');
//     print(sendreviewUrl);
//
//     try {
//       final response = await http.post(sendreviewUrl, body: {
//         "about": about,
//         "lid": lid,
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           Fluttertoast.showToast(msg: 'Review Submitted Successfully');
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const MainScreen(title: 'Login')),
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Review Submission Failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     } finally {
//       setState(() {
//         isSubmitting = false; // Enable button after submission is done
//       });
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import the rating bar

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
      home: const sendreview(title: 'Submit Review'),
    );
  }
}

class sendreview extends StatefulWidget {
  const sendreview({super.key, required this.title});

  final String title;

  @override
  State<sendreview> createState() => _sendreviewState();
}

class _sendreviewState extends State<sendreview> {
  TextEditingController reviewController = TextEditingController();
  double rating = 0;  // Variable to store the rating value
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen(title: "")),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Rating Bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    itemSize: 40,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        rating = newRating;
                      });
                    },
                  ),
                ),

                // Review Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Your Review',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    ),
                  ),
                ),

                // Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : _sendData,
                    child: isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Send Review'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to send the review data to the server
  void _sendData() async {
    String about = reviewController.text;

    if (about.isEmpty) {
      Fluttertoast.showToast(msg: "Please provide a description.");
      return;
    }

    if (rating == 0) {
      Fluttertoast.showToast(msg: "Please provide a rating.");
      return;
    }

    setState(() {
      isSubmitting = true; // Disable button during the submission
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    String tid = sh.getString('tid') ?? '';
    print(url);

    final Uri sendreviewUrl = Uri.parse('$url/sendreview/');

    try {
      final response = await http.post(sendreviewUrl, body: {
        "about": about,
        "rating": rating.toString(),  // Send the rating value
        "lid": lid,
        "tid": tid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Review Submitted Successfully');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen(title: 'Login')),
          );
        } else {
          Fluttertoast.showToast(msg: 'Review Submission Failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      setState(() {
        isSubmitting = false; // Enable button after submission is done
      });
    }
  }
}
