import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../utils/constants.dart';

class ChatInputFieldContainerWidget extends StatefulWidget {
  final Color chatInputFieldColor;
  final bool isRecording;
  final String recordingNoteHintText;
  final int recordTime;
  final TextEditingController textController;
  final String sendMessageHintText;
  final GlobalKey<FormState> formKey;
  final Function(BuildContext context) attachmentClick;
  final Function()? onSubmitted;
  final Function()? recording;
  final Function(String)? onTextFieldValueChanged;

  //TODO should add container shape

  ChatInputFieldContainerWidget(
      {super.key,
      required this.chatInputFieldColor,
      required this.isRecording,
      required this.recordingNoteHintText,
      required this.recordTime,
      required this.textController,
      required this.sendMessageHintText,
      required this.formKey,
      required this.attachmentClick,
      required this.onTextFieldValueChanged,
      this.onSubmitted,
      this.recording});

  @override
  State<ChatInputFieldContainerWidget> createState() =>
      _ChatTextViewWidgetState();
}

class _ChatTextViewWidgetState extends State<ChatInputFieldContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.chatInputFieldColor,
        //TODO the shape should be from user
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          IconButton(onPressed: widget.recording, icon: Icon(Icons.mic)),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              widget.attachmentClick(context);
            },
            child: Icon(
              widget.isRecording ? Icons.delete : Icons.camera_alt_outlined,
              color: widget.isRecording
                  ? kErrorColor
                  : Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.64),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Form(
              key: widget.formKey,
              child: Container(
                padding: const EdgeInsets.only(top: 0.0, right: 10),
                child: widget.isRecording
                    ? Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            widget.recordingNoteHintText +
                                " " +
                                StopWatchTimer.getDisplayTime(
                                    widget.recordTime),
                          ),
                        ),
                      )
                    : TextFormField(
                        controller: widget.textController,
                        onChanged: widget.onTextFieldValueChanged,
                        decoration: InputDecoration(
                          hintText: widget.sendMessageHintText,
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (_) {
                          if (widget.onSubmitted != null) widget.onSubmitted!();
                        },
                        textDirection: TextDirection.ltr,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
