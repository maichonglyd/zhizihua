import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';

class GameCommentResponseState implements Cloneable<GameCommentResponseState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  TextEditingController contentController = TextEditingController();
  Comment comment;
  num gameId;
  List<Comment> commentList = [];

  @override
  GameCommentResponseState clone() {
    return GameCommentResponseState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..contentController = contentController
      ..comment = comment
      ..gameId = gameId
      ..commentList = commentList;
  }
}

GameCommentResponseState initState(Map<String, dynamic> args) {
  return GameCommentResponseState()
    ..comment = args['comment']
    ..gameId = args['gameId'];
}
