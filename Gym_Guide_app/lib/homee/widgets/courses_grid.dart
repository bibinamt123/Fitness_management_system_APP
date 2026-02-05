import 'package:flutter/material.dart';
import 'package:gym_guide/add_health_profile.dart';
import 'package:gym_guide/send_complaint.dart';
import 'package:gym_guide/send_review.dart';
import 'package:gym_guide/view%20reply.dart';
import 'package:gym_guide/view_tips.dart';
import 'package:gym_guide/view_trainers.dart';
import '../data/data.dart';

class CourseGrid extends StatelessWidget {
  const CourseGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: course.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 16 / 7, // Adjust this ratio based on your UI design
        crossAxisCount: 1,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(course[index].backImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {


                if (course[index].text == "Trainer") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>ViewTrainers ()),
                  );
                } else if (course[index].text == "Tips") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewTips()),
                  );
                } else if (course[index].text == "Complaints") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => viewreply(title: '',)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>MyHealthProfile(title: '',)),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Column with course text and lessons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        course[index].text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   course[index].lessons,
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                    ],
                  ),
                  // Right Column with course image
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        course[index].imageUrl,
                        height: 110,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
