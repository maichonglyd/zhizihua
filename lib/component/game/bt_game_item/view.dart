import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'state.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget buildView(
    BTGameItemState state, Dispatch dispatch, ViewService viewService) {
  return GameItemView(state.game, kfType: state.kfType,);
}
