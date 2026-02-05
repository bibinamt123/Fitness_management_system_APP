import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_guide/login.dart';
import 'package:gym_guide/view_profile.dart';
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
      home: const MyEditProfilePage(title: 'Ip'),
    );
  }
}

class MyEditProfilePage extends StatefulWidget {
  const MyEditProfilePage({super.key, required this.title});

  final String title;

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {

  _MyEditProfilePageState(){
    get_data();
  }


  String gender = "Male";
  File? uploadimage;
  String img="";
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phoneno=TextEditingController();
  TextEditingController place =TextEditingController();
  TextEditingController post =TextEditingController();
  TextEditingController pin =TextEditingController();
  TextEditingController district =TextEditingController();



  void get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String img_url = sh.getString('img_url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
           name.text = jsonDecode(response.body)['name'].toString();
          String gender_ = jsonDecode(response.body)['gender'].toString();
          email.text = jsonDecode(response.body)['email'].toString();
          phoneno.text = jsonDecode(response.body)['phoneno'].toString();
          place.text = jsonDecode(response.body)['place'].toString();
          post.text = jsonDecode(response.body)['post'].toString();
          pin.text  = jsonDecode(response.body)['pin'].toString();
          district.text = jsonDecode(response.body)['district'].toString();
         String img_ = img_url + jsonDecode(response.body)['photo'].toString();


          setState(() {
            img = img_;
            gender = gender_;

          });

        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>viewprofilePage(title: '',)),);
      return Future.value(true);
    },
     child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyEditProfilePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      SingleChildScrollView(
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
                    Image(image: NetworkImage(img),height: 200,width: 200,),
                    Text('Select Image',style: TextStyle(color: Colors.cyan))
                  ],
                ),
              ),
            },
            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:name,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("name"),
              )),),
            RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
            RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
            RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:email,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("email"),
              )),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:phoneno,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("phoneno"),
              )),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:place,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("place"),
              )),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:post,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("post"),
              )),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:pin,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("pin"),
              )),),

            Padding(padding: EdgeInsets.all(8),
              child: TextField(controller:district,decoration:InputDecoration(border: OutlineInputBorder(),label: Text("district"),
              )),),


            Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(onPressed: () {
                _send_data();
              }, child: Text("Update")),)


          ],
        ),
      ),  // This trailing comma makes auto-formatting nicer for build methods.
     )
    );

  }
  void _send_data() async{

    String uname=name.text;
    String uemail=email.text;
    String uphoneno=phoneno.text;
    String uplace=place.text;
    String upin=pin.text;
    String upost=post.text;
    String udistrict=district.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    print(url);

    final urls = Uri.parse('$url/editprofile/');
    print(urls);
    try {

      final response = await http.post(urls, body: {
        "photo":photo,
        "name":uname,
        "email":uemail,
        "gender":gender,
        "phoneno":uphoneno,
        "place":uplace,
        "pin":upin,
        "post":upost,
        "district":udistrict,
        'lid':lid


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          Fluttertoast.showToast(msg: 'Edited ');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => viewprofilePage(title: ""),));
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

}

