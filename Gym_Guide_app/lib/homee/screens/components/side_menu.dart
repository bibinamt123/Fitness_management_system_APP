
import 'package:flutter/material.dart';
import 'package:gym_guide/change%20pass.dart';
import 'package:gym_guide/login.dart';
import 'package:gym_guide/login/view_progress.dart';
import 'package:gym_guide/upload_file.dart';
import 'package:gym_guide/viewDietPlanTemp.dart';
import 'package:gym_guide/viewattendance.dart';
import 'package:gym_guide/viewclass.dart';
import 'package:gym_guide/send_review.dart';
import 'package:gym_guide/track_their_progress.dart';
import 'package:gym_guide/view%20reply.dart';
import 'package:gym_guide/view%20rq%20status.dart';
import 'package:gym_guide/view_health_profile.dart';
import 'package:gym_guide/view_motivationalvideos.dart';
import 'package:gym_guide/view_profile.dart';
import 'package:gym_guide/view_serviceplans.dart';
import 'package:gym_guide/view_tips.dart';
import 'package:gym_guide/view_trainers.dart';
import 'package:gym_guide/view_workoutvideos.dart';
import 'package:gym_guide/viewfacility.dart';
import '../../constant.dart';
import '../main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          // SizedBox(
          //   height: 100,width: 1000,
          //   child: DrawerHeader(
          //       child: Image.asset(
          //         "images/gym.jpg",
          //       )),
          // ),

          DrawerListTile(
            icon: Icons.home_max_outlined,
            title: "Home",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(title: '',)));
            },
          ),


          DrawerListTile(
            icon: Icons.person_2_outlined,
            title: "Profile",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => viewprofilePage(title: '',)));
            },
          ),

          DrawerListTile(
            icon: Icons.track_changes_outlined,
            title: "Trainers",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewTrainers()));
            },
          ),
          DrawerListTile(
            icon: Icons.remove_from_queue_outlined,
            title: "Status",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => reqstatus(
                        title: '',
                      )));
            },
          ),  DrawerListTile(
            icon: Icons.remove_from_queue_outlined,
            title: "Diet Recommendation",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewDietPlanNew(
                        title: '',
                      )));
            },
          ), DrawerListTile(
            icon: Icons.remove_from_queue_outlined,
            title: "Nutritions check",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Myuploadpage(
                        title: '',
                      )));
            },
          ),
          DrawerListTile(
            icon: Icons.next_plan_outlined,
            title: "Service Plans",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewServicePlans(

                      )));
            },
          ),
          DrawerListTile(
            icon: Icons.tips_and_updates_outlined,
            title: "Tips",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewTipsPage(
                        title: '',
                      )));
            },
          ),
          DrawerListTile(
            icon: Icons.feed_outlined,
            title: "Classes",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => viewclassplan(title: '',)));
            },
          ),

          DrawerListTile(
            icon: Icons.mark_chat_read_outlined,
            title: "Attendance",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewAttendance(title: '',)));
            },
          ),



          DrawerListTile(
            icon: Icons.feed_outlined,
            title: "Workout Videos",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => viewworkoutvideos(title: '',)));
            },
          ),


          DrawerListTile(
            icon: Icons.bar_chart_outlined,
            title: "View Progress",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewProgress(title: '',)));
            },
          ), DrawerListTile(
            icon: Icons.list,
            title: "View Facilities",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewFacility(title: '',)));
            },
          ),

           DrawerListTile(
            icon: Icons.bar_chart_outlined,
            title: "View Health Profile",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewHealthProfile(title: '',)));
            },
          ),




          DrawerListTile(
            icon: Icons.feedback_outlined,
            title: "Complaints",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => viewreply(title: '',)));
            },
          ),


          //
          // DrawerListTile(
          //   icon: Icons.reviews_outlined,
          //   title: "Reviews",
          //   onTap: () {
          //     Navigator.pushReplacement(context,
          //         MaterialPageRoute(builder: (context) => sendreview(title: '',)));
          //   },
          // ),



          DrawerListTile(
            icon: Icons.password_outlined,
            title: "Password",
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserChangePass(title: '',)));
            },
          ),



          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "images/help.png",
            height: 150,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: kLightBlue, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [


                const Text("See you soon",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("LOGOUT", style: TextStyle(color: kDarkBlue)),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyloginPage()));
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: kDarkBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: kDarkBlue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0,
      leading: Icon(
        icon,
        color: Colors.grey,
        size: 18,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
