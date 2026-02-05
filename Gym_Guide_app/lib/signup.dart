 import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MylSignupPage(title: 'Ip'),
    );
  }
}

class MylSignupPage extends StatefulWidget {
  const MylSignupPage({super.key, required this.title});

  final String title;

  @override
  State<MylSignupPage> createState() => _MylSignupPageState();
}

class _MylSignupPageState extends State<MylSignupPage> {
  String gender = "Male";
  File? uploadimage;
  TextEditingController name =TextEditingController();
  TextEditingController dob =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phoneno=TextEditingController();
  TextEditingController place =TextEditingController();
  TextEditingController post =TextEditingController();
  TextEditingController pin =TextEditingController();
  TextEditingController district =TextEditingController();
  TextEditingController height =TextEditingController();
  TextEditingController weight =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController confirmpassword =TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    } else {
      Fluttertoast.showToast(msg: 'No file selected');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        // Here we take the value from the MylSignupPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_selectedImage != null) ...{
                InkWell(
                  child:
                  Image.file(_selectedImage!, height: 400,),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child:Column(
                    children: [
                      Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(
                  validator: (v) {
                    if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                      return 'Must enter your Name';
                    }
                    return null;
                  },


                    controller:name,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("name"),
                )),),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _selectDate(context), // Open the date picker when the TextField is tapped
                  child: AbsorbPointer( // Disable the default text field input
                    child: TextFormField(

                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Must enter valid DOB';
                        }
                        return null;
                      },
                      controller: dob,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Dob",
                      ),
                    ),
                  ),
                ),
              ),


              RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                    controller:email,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("email"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(
                    validator: (v) {
                      if (v == null || v.isEmpty || !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
                        return 'Enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                    controller:phoneno,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("phoneno"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must enter valid place';
                      }
                      return null;
                    },
                    controller:place,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("place"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (v) {
                      if (v!.isEmpty || !RegExp(r"^[a-z A_Z]*").hasMatch(v)) {
                        return 'Must enter valid Post';
                      }
                      return null;
                    },
                    controller:post,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("post"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(
                    validator: (v) {
                      if (v == null || v.isEmpty || !RegExp(r"^[0-9]{6}").hasMatch(v)) {
                        return 'Enter a valid 6-digit PIN code';
                      }
                      return null;
                    },
                    controller:pin,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("pin"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must enter valid district';
                      }
                      return null;
                    },
                    controller:district,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("district"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must enter valid height';
                      }
                      return null;
                    },
                    controller:height,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("Height"),
                )),),
              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(


                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must enter valid weight';
                      }
                      return null;
                    },
                    controller:weight,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("Weight"),
                )),),



              if (_selectedFile != null)
                Text('Selected file: ${_selectedFile!.path.split('/').last}')
              else
                Text('No file selected'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Pick a Certificate'),
              ),



                Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Must enter a password';
                      }
                      return null;
                    },

                    controller:password,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("password"),
                )),),

              Padding(padding: EdgeInsets.all(8),
                child: TextFormField(

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      } else if (value != password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller:confirmpassword,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("confirm password"),
                )),),


              Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(onPressed: () {
                if (_formKey.currentState !.validate()) {
                  _send_data();
                }
              }, child: Text("signup")),)


            ],
          ),
        ),
      ),  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void _send_data() async {
    // if (_formKey.currentState!.validate()) {
      String uname = name.text;
      String uemail = email.text;
      String uphoneno = phoneno.text;
      String uplace = place.text;
      String upin = pin.text;
      String upost = post.text;
      String udob = dob.text;
      String udistrict = district.text;
      String upassword = password.text;
      String uheight = height.text;
      String uweight = weight.text;
      String uconfirmpasssword = confirmpassword.text;

      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      print(url);

      final urls = Uri.parse('$url/signup/');
      print(urls);
      try {
        var request = http.MultipartRequest('POST', urls)
          ..fields['name'] = uname
          ..fields['email'] = uemail
          ..fields['gender'] = gender
          ..fields['dob'] = udob
          ..fields['phoneno'] = uphoneno
          ..fields['place'] = uplace
          ..fields['pin'] = upin
          ..fields['post'] = upost
          ..fields['district'] = udistrict
          ..fields['password'] = upassword
          ..fields['confirmpassword'] = uconfirmpasssword
          ..fields['height'] = uheight
          ..fields['photo'] = photo
          ..fields['weight'] = uweight;

        if (_selectedFile != null) {
          request.files.add(await http.MultipartFile.fromPath('medical', _selectedFile!.path));
        }

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseBody = await response.stream.bytesToString();
          final responseJson = jsonDecode(responseBody);
          String status = responseJson['status'];

          if (status == 'ok') {
            Fluttertoast.showToast(msg: 'Registration Successful');
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyloginPage()));
          } else {
            Fluttertoast.showToast(msg: 'Registration failed');
          }
        } else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    // }
  }

  // void _send_data() async{
  //
  //   String uname=name.text;
  //   String uemail=email.text;
  //   String uphoneno=phoneno.text;
  //   String uplace=place.text;
  //   String upin=pin.text;
  //   String upost=post.text;
  //   String udistrict=district.text;
  //   String upassword=password.text;
  //   String uheight=height.text;
  //   String uweight=weight.text;
  //   String uconfirmpasssword=confirmpassword.text;
  //
  //
  //
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString('url').toString();
  //   print(url);
  //
  //   final urls = Uri.parse('$url/signup/');
  //   print(urls);
  //   try {
  //
  //     final response = await http.post(urls, body: {
  //       "photo":photo,
  //       "name":uname,
  //       "email":uemail,
  //       "gender":gender,
  //       "phoneno":uphoneno,
  //       "place":uplace,
  //       "pin":upin,
  //       "post":upost,
  //       "district":udistrict,
  //       "password":upassword,
  //       "confirmpassword":uconfirmpasssword,
  //       'height':uheight,
  //       'weight':uweight,
  //
  //
  //     });
  //     var request = http.MultipartRequest('POST', urls)
  //       ..files.add(await http.MultipartFile.fromPath('file', _selectedFile!.path));
  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       String status = jsonDecode(response.body)['status'];
  //       if (status=='ok') {
  //
  //         Fluttertoast.showToast(msg: 'Registration Successfull');
  //         Navigator.push(context, MaterialPageRoute(
  //           builder: (context) => MyloginPage(),));
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

  // void _send_data() async {
  //   String uname = name.text;
  //   String uemail = email.text;
  //   String uphoneno = phoneno.text;
  //   String uplace = place.text;
  //   String upin = pin.text;
  //   String upost = post.text;
  //   String udob = dob.text;
  //   String udistrict = district.text;
  //   String upassword = password.text;
  //   String uheight = height.text;
  //   String uweight = weight.text;
  //   String uconfirmpasssword = confirmpassword.text;
  //
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString('url').toString();
  //   print(url);
  //
  //   final urls = Uri.parse('$url/signup/');
  //   print(urls);
  //   try {
  //     // Define response for the POST request
  //     final response = await http.post(urls, body: {
  //       "photo": photo,
  //       "dob": udob,
  //       "name": uname,
  //       "email": uemail,
  //       "gender": gender,
  //       "phoneno": uphoneno,
  //       "place": uplace,
  //       "pin": upin,
  //       "post": upost,
  //       "district": udistrict,
  //       "password": upassword,
  //       "confirmpassword": uconfirmpasssword,
  //       'height': uheight,
  //       'weight': uweight,
  //     });
  //
  //     // Define a separate response for the file upload request
  //     var uploadRequest = http.MultipartRequest('POST', urls)
  //       ..files.add(await http.MultipartFile.fromPath('file', _selectedFile!.path));
  //
  //     final uploadResponse = await uploadRequest.send();
  //
  //     if (uploadResponse.statusCode == 200) {
  //       String status = jsonDecode(await uploadResponse.stream.bytesToString())['status'];
  //       if (status == 'ok') {
  //         Fluttertoast.showToast(msg: 'Registration Successfull');
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => MyloginPage()));
  //       } else {
  //         Fluttertoast.showToast(msg: 'Not Found');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Network Error');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage =  File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';



  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime tenYearsAgo = DateTime(currentDate.year - 10, currentDate.month, currentDate.day);

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: tenYearsAgo, // Default selection is 10 years ago
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: tenYearsAgo, // Prevents selecting a date within the last 10 years
    );

    if (selectedDate != null) {
      setState(() {
        dob.text = "${selectedDate.toLocal()}".split(' ')[0]; // Format as yyyy-mm-dd
      });
    }
  }

}










//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gym_guide/login.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
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
//       home: const MylSignupPage(title: 'Ip'),
//     );
//   }
// }
//
// class MylSignupPage extends StatefulWidget {
//   const MylSignupPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MylSignupPage> createState() => _MylSignupPageState();
// }
//
// class _MylSignupPageState extends State<MylSignupPage> {
//   final _formKey = GlobalKey<FormState>();
//   String gender = "Male";
//   File? uploadimage;
//   TextEditingController name = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController phoneno = TextEditingController();
//   TextEditingController place = TextEditingController();
//   TextEditingController post = TextEditingController();
//   TextEditingController pin = TextEditingController();
//   TextEditingController district = TextEditingController();
//   TextEditingController height = TextEditingController();
//   TextEditingController weight = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmpassword = TextEditingController();
//
//   File? _selectedImage;
//   File? _selectedFile; // File for certificate upload
//   String photo = '';
//
//   // Certificate File Picker
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     } else {
//       Fluttertoast.showToast(msg: 'No file selected');
//     }
//   }
//
//   // Image Picker
//   Future<void> _chooseAndUploadImage() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//         photo = base64Encode(_selectedImage!.readAsBytesSync());
//       });
//     }
//   }
//
//   // Check Permissions and Choose Image
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   // Date Picker for DOB
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//     if (selectedDate != null) {
//       setState(() {
//         dob.text = "${selectedDate.toLocal()}".split(' ')[0]; // Format the date to yyyy-mm-dd
//       });
//     }
//   }
//
//   // Form Submission with Validation
//   void _send_data() async {
//     if (_formKey.currentState!.validate()) {
//       String uname = name.text;
//       String uemail = email.text;
//       String uphoneno = phoneno.text;
//       String uplace = place.text;
//       String upin = pin.text;
//       String upost = post.text;
//       String udob = dob.text;
//       String udistrict = district.text;
//       String upassword = password.text;
//       String uheight = height.text;
//       String uweight = weight.text;
//       String uconfirmpasssword = confirmpassword.text;
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       print(url);
//
//       final urls = Uri.parse('$url/signup/');
//       print(urls);
//       try {
//         var request = http.MultipartRequest('POST', urls)
//           ..fields['name'] = uname
//           ..fields['email'] = uemail
//           ..fields['gender'] = gender
//           ..fields['dob'] = udob
//           ..fields['phoneno'] = uphoneno
//           ..fields['place'] = uplace
//           ..fields['pin'] = upin
//           ..fields['post'] = upost
//           ..fields['district'] = udistrict
//           ..fields['password'] = upassword
//           ..fields['confirmpassword'] = uconfirmpasssword
//           ..fields['height'] = uheight
//           ..fields['weight'] = uweight;
//
//         if (_selectedImage != null) {
//           request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//         }
//
//         if (_selectedFile != null) {
//           request.files.add(await http.MultipartFile.fromPath('certificate', _selectedFile!.path));
//         }
//
//         final response = await request.send();
//
//         if (response.statusCode == 200) {
//           final responseBody = await response.stream.bytesToString();
//           final responseJson = jsonDecode(responseBody);
//           String status = responseJson['status'];
//
//           if (status == 'ok') {
//             Fluttertoast.showToast(msg: 'Registration Successful');
//             Navigator.push(context, MaterialPageRoute(builder: (context) => MyloginPage()));
//           } else {
//             Fluttertoast.showToast(msg: 'Registration failed');
//           }
//         } else {
//           Fluttertoast.showToast(msg: 'Network Error');
//         }
//       } catch (e) {
//         Fluttertoast.showToast(msg: e.toString());
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               if (_selectedImage != null) ...{
//                 InkWell(
//                   child: SizedBox(
//                     height: 200,
//                     width: 200,
//                     child: Image.file(_selectedImage!, fit: BoxFit.cover),
//                   ),
//                   onTap: _checkPermissionAndChooseImage,
//                 ),
//               } else ...{
//                 InkWell(
//                   onTap: _checkPermissionAndChooseImage,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 200,
//                         width: 200,
//                         child: Image.network(
//                           'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Text('Select Image', style: TextStyle(color: Colors.cyan)),
//                     ],
//                   ),
//                 ),
//               },
//
//               TextFormField(
//                 controller: name,
//                 decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//
//               GestureDetector(
//                 onTap: () => _selectDate(context),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: dob,
//                     decoration: InputDecoration(labelText: "Date of Birth", border: OutlineInputBorder()),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select your date of birth';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               Row(
//                 children: [
//                   RadioListTile(
//                     value: "Male",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = "Male";
//                       });
//                     },
//                     title: Text("Male"),
//                   ),
//                   RadioListTile(
//                     value: "Female",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = "Female";
//                       });
//                     },
//                     title: Text("Female"),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//
//               TextFormField(
//                 controller: email,
//                 decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//
//               TextFormField(
//                 controller: phoneno,
//                 decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//
//               // Other form fields...
//
//               ElevatedButton(
//                 onPressed: _pickFile,
//                 child: Text('Pick a Certificate'),
//               ),
//               SizedBox(height: 16),
//
//               ElevatedButton(
//                 onPressed: _send_data,
//                 child: Text("Sign Up"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
