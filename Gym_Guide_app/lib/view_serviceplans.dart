// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:gym_guide/homee/main.dart';
// // import 'package:gym_guide/view_workoutplans.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() {
// //   runApp(const viewserviceplans());
// // }
// //
// // class viewserviceplans extends StatelessWidget {
// //   const viewserviceplans({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Workout Plan',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
// //         useMaterial3: true,
// //       ),
// //       home: const viewserviceplanss(title: 'View Service Plan'),
// //     );
// //   }
// // }
// //
// // class viewserviceplanss extends StatefulWidget {
// //   const viewserviceplanss({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<viewserviceplanss> createState() => _viewserviceplanssState();
// // }
// //
// // class _viewserviceplanssState extends State<viewserviceplanss> {
// //
// //   _viewserviceplanssState(){
// //     viewserviceplans();
// //   }
// //
// //   String amounts_="0";
// //
// //
// //   List<String> id_ = [];
// //   List<String> splan_ = [];
// //   List<String> dur_ = [];
// //   List<String> amnt_ = [];
// //
// //   // This function will fetch service plan data
// //   Future<void> viewserviceplans() async {
// //     List<String> id = [];
// //     List<String> splan = [];
// //     List<String> dur = [];
// //     List<String> amnt = [];
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/viewserviceplan/';
// //
// //       var data = await http.post(Uri.parse(url), body: {'lid': lid});
// //       var jsondata = json.decode(data.body);
// //       String status = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         splan.add(arr[i]['plan'].toString());
// //         amnt.add(arr[i]['amnt'].toString());
// //         dur.add(arr[i]['dur'].toString()); // Use correct key if needed
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         splan_ = splan;
// //         amnt_ = amnt;
// //         dur_ = dur;
// //       });
// //
// //       print(status);
// //     } catch (e) {
// //       print("Error: " + e.toString());
// //       Fluttertoast.showToast(msg: "Error loading service plans.");
// //     }
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewserviceplans();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async => true,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leading: BackButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => MainScreen(title: '')),
// //               );
// //             },
// //           ),
// //           backgroundColor: Theme.of(context).colorScheme.primary,
// //           title: Text(widget.title),
// //         ),
// //         body: ListView.builder(
// //           physics: BouncingScrollPhysics(),
// //           itemCount: id_.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             return ServicePlanCard(
// //               id: id_[index],
// //               plan: splan_[index],
// //               amount: amnt_[index],
// //               duration: dur_[index],
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // Extracted widget for service plan card
// // class ServicePlanCard extends StatelessWidget {
// //   final String plan;
// //   final String id;
// //   final String amount;
// //   final String duration;
// //
// //   const ServicePlanCard({
// //     Key? key,
// //     required this.plan,
// //     required this.id,
// //     required this.amount,
// //     required this.duration,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 8,
// //       margin: EdgeInsets.all(10),
// //       child: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Service Plan Row
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Icon(Icons.card_giftcard, size: 20),
// //                     SizedBox(width: 8),
// //                     Text("Service"),
// //                   ],
// //                 ),
// //                 Text(plan, style: TextStyle(fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //             Divider(),
// //
// //             // Amount Row
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Icon(Icons.attach_money, size: 20),
// //                     SizedBox(width: 8),
// //                     Text("Amount"),
// //                   ],
// //                 ),
// //                 Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //             Divider(),
// //
// //             // Duration Row
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Row(
// //                   children: [
// //                     Icon(Icons.access_time, size: 20),
// //                     SizedBox(width: 8),
// //                     Text("Duration"),
// //                   ],
// //                 ),
// //                 Text(duration, style: TextStyle(fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //
// //
// //
// //
// //             Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 16.0),
// //               child: ElevatedButton(
// //                 onPressed: () async {
// //                   final pref =await SharedPreferences.getInstance();
// //                   pref.setString("sid", id.toString());
// //
// //
// //
// //                   _openCheckout(amount);
// //
// //
// //                 },
// //                 child: Text("Make Payment"),
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: Size(double.infinity, 48), // Full-width button
// //                 ),
// //               ),
// //
// //
// //
// //             ),
// //
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 16.0),
// //           child: ElevatedButton(
// //             onPressed: () async {
// //
// //               SharedPreferences sh = await SharedPreferences.getInstance();
// //               sh.setString("sid", id);
// //
// //
// //               Navigator.push(context, MaterialPageRoute(
// //                 builder: (context) => ViewWorkoutPlan(),));
// //
// //
// //             },
// //             child: Text("Workout Plans"),
// //             style: ElevatedButton.styleFrom(
// //               minimumSize: Size(double.infinity, 48), // Full-width button
// //             ),
// //           ),
// //
// //
// //
// //         )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //
// //
// //
// //
// //   late Razorpay _razorpay;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     viewserviceplans();
// //
// //     // Initializing Razorpay
// //     _razorpay = Razorpay();
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
// //     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
// //     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// //   }
// //
// //   @override
// //   void dispose() {
// //     // Disposing Razorpay instance to avoid memory leaks
// //     _razorpay.clear();
// //     super.dispose();
// //   }
// //
// //   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
// //     // Handle successful payment
// //     print("Payment Successful: ${response.paymentId}");
// //
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url').toString();
// //     String sid = sh.getString('sid').toString();
// //     String lid = sh.getString('lid').toString();
// //
// //     final urls = Uri.parse('$url/cartpayment/');
// //     try {
// //       final response = await http.post(urls, body: {
// //         'lid': lid,
// //         'sid': sid,
// //
// //
// //       });
// //       if (response.statusCode == 200) {
// //         String status = jsonDecode(response.body)['status'];
// //         if (status == 'ok') {
// //
// //
// //         } else {
// //           Fluttertoast.showToast(msg: 'Not Found');
// //         }
// //       }
// //       else {
// //         Fluttertoast.showToast(msg: 'Network Error');
// //       }
// //     }
// //     catch (e) {
// //       Fluttertoast.showToast(msg: e.toString());
// //     }
// //   }
// //
// //
// //
// //   void _handlePaymentError(PaymentFailureResponse response) {
// //     // Handle payment failure
// //     print("Error in Payment: ${response.code} - ${response.message}");
// //   }
// //
// //   void _handleExternalWallet(ExternalWalletResponse response) {
// //     // Handle external wallet
// //     print("External Wallet: ${response.walletName}");
// //   }
// //
// //   void _openCheckout(amount_) {
// //
// //     double am= double.parse(amount_.toString()) *100;
// //
// //     var options = {
// //       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
// //       'amount': am, // Amount in paise (e.g. 2000 paise = Rs 20)
// //       'name': 'Flutter Razorpay Example',
// //       'description': 'Payment for the product',
// //       'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
// //       'external': {
// //         'wallets': ['paytm'] // List of external wallets
// //       }
// //     };
// //
// //     try {
// //       _razorpay.open(options);
// //     } catch (e) {
// //       debugPrint('Error: ${e.toString()}');
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gym_guide/homee/main.dart';
// import 'package:gym_guide/view_workoutplans.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const viewserviceplans());
// }
//
// class viewserviceplans extends StatelessWidget {
//   const viewserviceplans({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Workout Plan',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const viewserviceplanss(title: 'View Service Plan'),
//     );
//   }
// }
//
// class viewserviceplanss extends StatefulWidget {
//   const viewserviceplanss({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<viewserviceplanss> createState() => _viewserviceplanssState();
// }
//
// class _viewserviceplanssState extends State<viewserviceplanss> {
//
//   _viewserviceplanssState(){
//     viewserviceplans();
//   }
//
//   String amounts_="0";
//
//   List<String> id_ = [];
//   List<String> splan_ = [];
//   List<String> dur_ = [];
//   List<String> amnt_ = [];
//
//   late Razorpay _razorpay;
//
//   // This function will fetch service plan data
//   Future<void> viewserviceplans() async {
//     List<String> id = [];
//     List<String> splan = [];
//     List<String> dur = [];
//     List<String> amnt = [];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/viewserviceplan/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//
//       var arr = jsondata["data"];
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         splan.add(arr[i]['plan'].toString());
//         amnt.add(arr[i]['amnt'].toString());
//         dur.add(arr[i]['dur'].toString()); // Use correct key if needed
//       }
//
//       setState(() {
//         id_ = id;
//         splan_ = splan;
//         amnt_ = amnt;
//         dur_ = dur;
//       });
//
//       print(status);
//     } catch (e) {
//       print("Error: " + e.toString());
//       Fluttertoast.showToast(msg: "Error loading service plans.");
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     viewserviceplans();
//
//     // Initializing Razorpay
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     // Disposing Razorpay instance to avoid memory leaks
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // Handle successful payment
//     print("Payment Successful: ${response.paymentId}");
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String sid = sh.getString('sid').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_payment/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'sid': id_[index],
//         'amount': amounts_,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           // Handle success
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
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Error in Payment: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet
//     print("External Wallet: ${response.walletName}");
//   }
//
//   void _openCheckout(String amount_) {
//     double am = double.parse(amount_) * 100;
//
//     var options = {
//       'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
//       'amount': am, // Amount in paise (e.g. 2000 paise = Rs 20)
//       'name': 'Flutter Razorpay Example',
//       'description': 'Payment for the product',
//       'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
//       'external': {
//         'wallets': ['paytm'] // List of external wallets
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => MainScreen(title: '')),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ServicePlanCard(
//               id: id_[index],
//               plan: splan_[index],
//               amount: amnt_[index],
//               duration: dur_[index],
//               onPayment: () {
//                 _openCheckout(amnt_[index]);
//               },
//               onWorkoutPlans: () async {
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 sh.setString("sid", id_[index]);
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => ViewWorkoutPlan()));
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // Extracted widget for service plan card
// class ServicePlanCard extends StatelessWidget {
//   final String plan;
//   final String id;
//   final String amount;
//   final String duration;
//   final VoidCallback onPayment;
//   final VoidCallback onWorkoutPlans;
//
//   const ServicePlanCard({
//     Key? key,
//     required this.plan,
//     required this.id,
//     required this.amount,
//     required this.duration,
//     required this.onPayment,
//     required this.onWorkoutPlans,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8,
//       margin: EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Service Plan Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.card_giftcard, size: 20),
//                     SizedBox(width: 8),
//                     Text("Service"),
//                   ],
//                 ),
//                 Text(plan, style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Divider(),
//
//             // Amount Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.attach_money, size: 20),
//                     SizedBox(width: 8),
//                     Text("Amount"),
//                   ],
//                 ),
//                 Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Divider(),
//
//             // Duration Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.access_time, size: 20),
//                     SizedBox(width: 8),
//                     Text("Duration"),
//                   ],
//                 ),
//                 Text(duration, style: TextStyle(fontWeight: FontWeight.bold)),
//               ],
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: ElevatedButton(
//                 onPressed: onPayment,
//                 child: Text("Make Payment"),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 48), // Full-width button
//                 ),
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 16.0),
//             //   child: ElevatedButton(
//             //     onPressed: onWorkoutPlans,
//             //     child: Text("Workout Plans"),
//             //     style: ElevatedButton.styleFrom(
//             //       minimumSize: Size(double.infinity, 48), // Full-width button
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:gym_guide/view_workoutplans.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewServicePlans());
}

class ViewServicePlans extends StatelessWidget {
  const ViewServicePlans({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Plan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewServicePlansScreen(title: 'View Service Plan'),
    );
  }
}

class ViewServicePlansScreen extends StatefulWidget {
  const ViewServicePlansScreen({super.key, required this.title});

  final String title;

  @override
  State<ViewServicePlansScreen> createState() => _ViewServicePlansScreenState();
}

class _ViewServicePlansScreenState extends State<ViewServicePlansScreen> {
  String selectedPlanId = ""; // To store the selected plan ID before payment
  String amounts_ = "0";

  List<String> id_ = [];
  List<String> splan_ = [];
  List<String> dur_ = [];
  List<String> amnt_ = [];
  List<String> sts_ = [];

  late Razorpay _razorpay;

  // Fetch service plans
  Future<void> viewServicePlans() async {
    List<String> id = [];
    List<String> splan = [];
    List<String> dur = [];
    List<String> amnt = [];
    List<String> sts = [];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewserviceplan/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        splan.add(arr[i]['plan'].toString());
        amnt.add(arr[i]['amnt'].toString());
        dur.add(arr[i]['dur'].toString());
        sts.add(arr[i]['sts'].toString());
      }

      setState(() {
        id_ = id;
        splan_ = splan;
        amnt_ = amnt;
        dur_ = dur;
        sts_ = sts;
      });

      print(status);
    } catch (e) {
      print("Error: " + e.toString());
      Fluttertoast.showToast(msg: "Error loading service plans.");
    }
  }

  @override
  void initState() {
    super.initState();
    viewServicePlans();

    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // Handle successful payment
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String amount = sh.getString('amount').toString();

    final urls = Uri.parse('$url/user_payment/');

    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'sid': selectedPlanId, // Use stored plan ID
        'amount': amount,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Payment Successful');
        } else {
          Fluttertoast.showToast(msg: 'Already paid');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error in Payment: ${response.code} - ${response.message}");
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
  }

  // Open Razorpay Checkout
  void _openCheckout(String amount_, String sid) {
    setState(() {
      selectedPlanId = sid;
    });

    double am = double.parse(amount_) * 100;

    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe', // Replace with your Razorpay API key
      'amount': am,
      'name': 'Flutter Razorpay Example',
      'description': 'Payment for the service plan',
      'prefill': {'contact': '9747360170', 'email': 'tlikhil@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen(title: '')),
            );
          },
        ),
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return ServicePlanCard(
            id: id_[index],
            plan: splan_[index],
            amount: amnt_[index],
            duration: dur_[index],
            sts: sts_[index],
            onPayment: () async {

              SharedPreferences sh = await SharedPreferences.getInstance();
              sh.setString("amount", amnt_[index]);
              _openCheckout(amnt_[index], id_[index]);
            },
            onWorkoutPlans: () async {
              SharedPreferences sh = await SharedPreferences.getInstance();
              sh.setString("sid", id_[index]);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewWorkoutPlan()));
            },
          );
        },
      ),
    );
  }
}

// Extracted widget for service plan card
class ServicePlanCard extends StatelessWidget {
  final String plan;
  final String id;
  final String amount;
  final String duration;
  final String sts;
  final VoidCallback onPayment;
  final VoidCallback onWorkoutPlans;

  const ServicePlanCard({
    Key? key,
    required this.plan,
    required this.id,
    required this.amount,
    required this.duration,
    required this.sts,
    required this.onPayment,
    required this.onWorkoutPlans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Service: $plan", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Amount: ₹$amount"),
            Text("Duration: $duration"),


            if(sts=='paid')...{
              Text("Already Paid")
            }
            else...{
              SizedBox(height: 10),
              ElevatedButton(

                onPressed: onPayment,



                child: Text("Make Payment"),
              ),
            }

          ],
        ),
      ),
    );
  }
}
