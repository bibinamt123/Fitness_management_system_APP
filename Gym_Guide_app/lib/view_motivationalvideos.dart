import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_guide/homee/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
      home: const ViewSession(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewSession extends StatefulWidget {
  const ViewSession({super.key, required this.title});

  final String title;

  @override
  State<ViewSession> createState() => _ViewSessionState();
}

class _ViewSessionState extends State<ViewSession> {
  _ViewSessionState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> title_ = <String>[];
  List<String> vedio_ = <String>[];
  List<String> about_ = <String>[];
  List<String> name_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> title = <String>[];
    List<String> name = <String>[];
    List<String> vedio = <String>[];
    List<String> about = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/viewmotivationalvideos/';

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        title.add(arr[i]['title'].toString());
        name.add(arr[i]['trainer'].toString());
        vedio.add(sh.getString("img_url").toString() + arr[i]['vid']);
        about.add(arr[i]['about']);
      }

      setState(() {
        id_ = id;
        title_ = title;
        vedio_ = vedio;
        name_ = name;
        about_ = about;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen(title: '')),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen(title: '')),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
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
                        const SizedBox(height: 5),
                        Text(
                          "By: ${name_[index]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          about_[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 10),
                        VideoPlayerWidget(videoUrl: vedio_[index]),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
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
            const Icon(
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
