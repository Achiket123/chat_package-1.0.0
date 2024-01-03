import 'package:chat_package/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatAnimatedButton extends StatelessWidget {
  final int duration;
  final rightPosition;
  final bool isRecording;
  final bool isText;
  final Widget? animatedButtonWidget;
  final Function() onAnimatedButtonTap;
  final BorderRadiusGeometry? borderRadius;
  final IconData sendTextIcon;
  //TODO SHould add button shape

  const ChatAnimatedButton(
      {super.key,
      required this.duration,
      this.rightPosition,
      required this.isRecording,
      required this.isText,
      this.animatedButtonWidget,
      required this.onAnimatedButtonTap,
      this.borderRadius,
      required this.sendTextIcon});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      curve: Curves.bounceOut,
      right: rightPosition,
      // top: 0,

      child: GestureDetector(
          onTap: onAnimatedButtonTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.send,
              color: Colors.blue,
            ),
          )),
    );
  }
}
