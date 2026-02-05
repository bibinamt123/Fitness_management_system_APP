import 'package:flutter/material.dart';
import 'package:gym_guide/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../widgets/courses_grid.dart';
import 'components/side_menu.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Future<String> loadUserImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String image = prefs.getString('im') ?? '';
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.grey, size: 28),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.grey,
          //   ),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.notifications,
          //     color: Colors.grey,
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 5, right: 16, bottom: 5),
            child: GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => viewprofilePage(
                      title: "User's Profile", // Replace with actual data or title
                    ),
                  ),
                );
              },
              child: FutureBuilder<String>(
                future: loadUserImage(), // Async operation to fetch image
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Loading state
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error, color: Colors.red); // Error state
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!),
                    );
                  } else {
                    return const CircleAvatar(
                      backgroundImage: AssetImage('images/logoutt.png'), // Default image if no data
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                text: const TextSpan(
                  text: "Hello ",
                  style: TextStyle(color: kDarkBlue, fontSize: 20),
                  children: [
                    TextSpan(
                      text: "BRUNO",
                      style: TextStyle(
                          color: kDarkBlue, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ", welcome back!",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   "View All",
                  //   style: TextStyle(color: kDarkBlue),
                  // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CourseGrid(),
              const SizedBox(
                height: 20,
              ),
              // const PlaningHeader(),
              const SizedBox(
                height: 15,
              ),
              // const PlaningGrid(),
              const SizedBox(
                height: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }
}


