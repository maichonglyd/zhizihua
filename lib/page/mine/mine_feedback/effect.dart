import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<FeedbackState> buildEffect() {
  return combineEffects(<Object, Effect<FeedbackState>>{
    FeedbackAction.feedback: _feedback,
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _onAction(Action action, Context<FeedbackState> ctx) {}

void _dispose(Action action, Context<FeedbackState> ctx) {
  ctx.state.blankToolBarModel.removeFocusListeners();
}

void _init(Action action, Context<FeedbackState> ctx) {
  ctx.state.blankToolBarModel.outSideCallback = () {
    ctx.dispatch(FeedbackActionCreator.onAction());
  };
}

void _feedback(Action action, Context<FeedbackState> ctx) {
  String content = ctx.state.contentController.text;
  String mobile = ctx.state.mobileController.text;

  if (content.isEmpty) {
    showToast(getText(name: 'toastContentNotNull'));
    return;
  }

  if (mobile.isEmpty) {
    showToast(getText(name: 'toastMobilePhoneNotNull'));
    return;
  }

  UserService.feedback(content, mobile).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastFeedbackSuccessful'));
      Navigator.of(ctx.context).pop();
    }
  }).catchError((err) {
    print(err);
  });
}
