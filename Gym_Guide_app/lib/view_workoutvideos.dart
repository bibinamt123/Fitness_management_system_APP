import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_guide/track_their_progress.dart';
import 'package:gym_guide/view_dietplans.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const viewworkoutvideos(title: 'Flutter Demo Home Page'),
    );
  }
}

class viewworkoutvideos extends StatefulWidget {
  const viewworkoutvideos({super.key, required this.title});

  final String title;

  @override
  State<viewworkoutvideos> createState() => _viewworkoutvideosState();
}

class _viewworkoutvideosState extends State<viewworkoutvideos> {
  _viewworkoutvideosState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> title_ = <String>[];
  List<String> vedio_ = <String>[];
  List<String> level_ = <String>[];
  List<String> desc_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> title = <String>[];
    List<String> vedio = <String>[];
    List<String> level = <String>[];
    List<String> desc = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/viewworkoutvideo/';

      var data = await http.post(Uri.parse(url), body: {'lid':lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        title.add(arr[i]['workoutname'].toString());
        level.add(arr[i]['level'].toString());
        desc.add(arr[i]['description'].toString());
        vedio.add(sh.getString("img_url").toString() + arr[i]['vid'].toString());

      }

      setState(() {
        id_ = id;
        title_ = title;
        vedio_ = vedio;
        level_=level;
        desc_=desc;

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => MainScreen(title: '',),
              // ));
            },
          ),
        ],
        backgroundColor: Color.fromARGB(255, 18, 82, 98),
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white.withOpacity(0.8),
                elevation: 10,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title_[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blueGrey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Align the content centrally
                        children: [
                          IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () => _launchURL(vedio_[index]),
                          ),
                          Text(
                            'Play Video', // The text label
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Customize the style
                          ),
                        ],
                      ),

                      // VideoPlayerWidget(videoUrl: vedio_[index]),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            sh.setString('wid', id_[index]);

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => TrackTheirProgressScreen(title: '',)));

                          },
                          child: Text("Add Progress"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 48), // Full-width button
                          ),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {

                            SharedPreferences sh = await SharedPreferences.getInstance();
                            sh.setString("wid", id_[index]);


                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ViewDietPlans(title: '',),));


                          },
                          child: Text("Diet Plans"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 48), // Full-width button
                          ),
                        ),



                      ),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isVideoPlaying = false;
      } else {
        _controller.play();
        isVideoPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!isVideoPlaying)
            Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
