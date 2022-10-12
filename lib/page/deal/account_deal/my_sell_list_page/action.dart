import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

//TODO replace with your own action
enum MySellListAction { action }

class MySellListActionCreator {
  static Action onAction() {
    return const Action(MySellListAction.action);
  }
}
