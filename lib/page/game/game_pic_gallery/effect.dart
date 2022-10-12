import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<GalleryState> buildEffect() {
  return combineEffects(<Object, Effect<GalleryState>>{
    GalleryAction.action: _onAction,
    GalleryAction.back: _back,
  });
}

void _onAction(Action action, Context<GalleryState> ctx) {}
void _back(Action action, Context<GalleryState> ctx) {
  Navigator.of(ctx.context).pop();
}
