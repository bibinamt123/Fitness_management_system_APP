

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';

var _formKey = GlobalKey<FormState>();


void main() {
  runApp(const Myupload());
}

class Myupload extends StatelessWidget {
  const Myupload({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Myuploadpage(title: 'MySignup'),
    );
  }
}

class Myuploadpage extends StatefulWidget {
  const Myuploadpage({super.key, required this.title});
  final String title;

  @override
  State<Myuploadpage> createState() => _MyMySignupPageState();
}

class _MyMySignupPageState extends State<Myuploadpage> {


  File? uploadimage;



  var isLoading = false;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async{ return true; },
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          //   title: Text(widget.title),
          // ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 40,),
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
                          Image(image: AssetImage('images/gal.jpg'),height: 200,width: 200,),
                          Text('Select Image',style: TextStyle(color: Colors.cyan))
                        ],
                      ),
                    ),
                  },
                  SizedBox(height: 12,),
                  SizedBox(width: 350,height: 50,
                    child: ElevatedButton(onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        // if(uploadimage==null){
                        //   Fluttertoast.showToast(
                        //       msg: "Upload photo",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       backgroundColor: Colors.grey,
                        //       textColor: Colors.white,
                        //       fontSize: 12.0
                        //   );
                        //
                        // }
                        // else{
                          _send_data();
                        // }


                      }else{
                        Fluttertoast.showToast(
                            msg: "Fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                      }
                    },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        child: Text('Upload')),
                  )


                ],
              ),
            ),
          ),
        )
    );
  }
  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();


    final urls = Uri.parse('$url/nutrition_detect/');
    try {

      final response = await http.post(urls, body: {
        "photo":photo,
        "lid":lid
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name = jsonDecode(response.body)['food'].toString();
          String nut = jsonDecode(response.body)['nutrition'].toString();
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title:  Text('Output'),
              content:  Text(
                "Food name "+name+"\n"'Nutritions are'+nut
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );


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
        _selectedImage = File(pickedImage.path);
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
