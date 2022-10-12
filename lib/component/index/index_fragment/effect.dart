import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'component.dart';
import 'state.dart';

Effect<IndexFragmentState> buildEffect() {
  return combineEffects(<Object, Effect<IndexFragmentState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<IndexFragmentState> ctx) {}
