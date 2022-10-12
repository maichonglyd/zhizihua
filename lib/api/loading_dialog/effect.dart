import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/loading_dialog/action.dart';
import 'state.dart';

Effect<LoadingDialogState> buildEffect() {
  return combineEffects(<Object, Effect<LoadingDialogState>>{
    LoadingDialogAction.loadOK: _loadOK,
  });
}

void _loadOK(Action action, Context<LoadingDialogState> ctx) {
    Navigator.pop(ctx.context);
}

