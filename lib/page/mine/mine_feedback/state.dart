import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';

class FeedbackState implements Cloneable<FeedbackState> {
  TextEditingController contentController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  BlankToolBarModel blankToolBarModel = BlankToolBarModel();

  @override
  FeedbackState clone() {
    return FeedbackState()
      ..contentController = contentController
      ..mobileController = mobileController
      ..blankToolBarModel = blankToolBarModel;
  }
}

FeedbackState initState(Map<String, dynamic> args) {
  return FeedbackState();
}
