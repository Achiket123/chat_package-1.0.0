import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/utils/constants.dart';
import 'package:flutter/material.dart';

/// this widget is used to render a text message container

class TextMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final Color senderColor;

  const TextMessageWidget({
    Key? key,
    required this.message,
    required this.senderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2, minWidth: 50),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: message.isSender
                  ? Color.fromARGB(255, 48, 152, 95)
                  : Color.fromARGB(255, 52, 115, 163),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              message.text,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
