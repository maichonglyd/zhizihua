import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class GameCommitCommentState implements Cloneable<GameCommitCommentState> {
  TextEditingController contentController = TextEditingController();
  int gameId;
  int starNum;
  @override
  GameCommitCommentState clone() {
    return GameCommitCommentState()
      ..contentController = contentController
      ..gameId = gameId
      ..starNum = starNum;
  }
}

GameCommitCommentState initState(int gameId) {
  return GameCommitCommentState()
    ..gameId = gameId
    ..starNum = 5;
}
