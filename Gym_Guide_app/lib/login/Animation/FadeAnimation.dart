// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';
//
// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;
//
//   FadeAnimation(this.delay, this.child);
//
//   @override
//   Widget build(BuildContext context) {
//     // Define a sequence of animations (opacity and translation)
//     final tween = TweenSequence([
//       TweenSequenceItem(
//         tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 50,
//       ),
//       TweenSequenceItem(
//         tween: Tween(begin: -30.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)),
//         weight: 50,
//       ),
//     ]);
//
//     // Use PlayAnimation to control the animation
//     return PlayAnimation<TimelineValue>(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: 1,
//       tween: tween,
//       builder: (context, child, animation) {
//         return Opacity(
//           opacity: animation.value[0], // Opacity animation
//           child: Transform.translate(
//             offset: Offset(0, animation.value[1]), // Translate Y-axis
//             child: child,
//           ),
//         );
//       },
//       child: child,
//     );
//   }
// }
