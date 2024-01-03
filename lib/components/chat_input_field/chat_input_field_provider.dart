import 'dart:developer';

import 'package:chat_package/models/chat_message.dart';
import 'package:chat_package/models/media/chat_media.dart';
import 'package:chat_package/models/media/media_type.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChatInputFieldProvider extends ChangeNotifier {
  final Function(ChatMessage? audioMessage, bool cancel) handleRecord;
  final VoidCallback onSlideToCancelRecord;

  /// function to handle the selected image
  final Function(ChatMessage? imageMessage) handleImageSelect;

  /// The callback when send is pressed.
  final Function(ChatMessage text) onTextSubmit;
  final TextEditingController textController;
  final double cancelPosition;
  double _position = 0;
  int _duration = 0;
  bool _isRecording = false;
  int _recordTime = 0;
  bool isText = false;
  double _height = 70;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _formKey = GlobalKey<FormState>();

  /// getters
  int get duration => _duration;
  bool get isRecording => _isRecording;
  int get recordTime => _recordTime;
  GlobalKey<FormState> get formKey => _formKey;

  /// setters
  set height(double val) => _height = val;

  Permission micPermission = Permission.microphone;

  final SpeechToText speech = SpeechToText();
  ChatInputFieldProvider({
    required this.onTextSubmit,
    required this.textController,
    required this.handleRecord,
    required this.onSlideToCancelRecord,
    required this.cancelPosition,
    required this.handleImageSelect,
  });

  /// animated button on tap
  void onAnimatedButtonTap() async {
    _formKey.currentState?.save();
    if (isText && textController.text.isNotEmpty) {
      final textMessage =
          ChatMessage(isSender: true, text: textController.text);
      onTextSubmit(textMessage);
    }
    textController.clear();
    isText = false;
    notifyListeners();
  }

  String audioText = '';

  /// animated button on LongPress

  /// animated button on Long Press Move Update

  /// animated button on Long Press End

  /// function used to record audio
  recordAudio(ChatMessage message) async {
    onTextSubmit(message);
  }

  /// function used to stop recording
  /// and returns the record path as a string

  /// get the animated button position
  double getPosition() {
    log(_position.toString());
    if (_position < 0) {
      return 0;
    } else if (_position > cancelPosition - _height) {
      return cancelPosition - _height;
    } else {
      return _position;
    }
  }

  // TODO: make this custom from user
  /// open image picker from camera, gallery, or cancel the selection
  void pickImage(int type) async {
    final cameraPermission = Permission.camera;
    final storagePermission = Permission.camera;
    if (type == 1) {
      final permissionStatus = await cameraPermission.request();
      if (permissionStatus.isGranted) {
        final path = await _getImagePathFromSource(1);
        final imageMessage = _getImageMEssageFromPath(path);
        handleImageSelect(imageMessage);
        return;
      } else {
        handleImageSelect(null);
        return;
      }
    } else {
      final permissionStatus = await storagePermission.request();
      if (permissionStatus.isGranted) {
        final path = await _getImagePathFromSource(2);
        final imageMessage = _getImageMEssageFromPath(path);
        handleImageSelect(imageMessage);
        return;
      } else {
        handleImageSelect(null);
        return;
      }
    }
  }

  Future<String?> _getImagePathFromSource(int type) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: type == 1 ? ImageSource.camera : ImageSource.gallery,
    );
    return result?.path;
  }

  ChatMessage? _getImageMEssageFromPath(String? path) {
    if (path != null) {
      final imageMessage = ChatMessage(
        isSender: true,
        chatMedia: ChatMedia(
          url: path,
          mediaType: MediaType.imageMediaType(),
        ),
      );
      return imageMessage;
    } else {
      return null;
    }
  }

  void onTextFieldValueChanged(String value) {
    if (value.length > 0) {
      textController.text = value;
      isText = true;
      notifyListeners();
    } else {
      isText = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
