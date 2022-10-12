import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameHotClassifyState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: state.gameSpecial.cateList.asMap().keys.map((index) => _buildItemView(
          state, dispatch, viewService, index)).toList(),
    ),
  );
}

Widget _buildItemView(GameHotClassifyState state, Dispatch dispatch,
    ViewService viewService, int index) {
  List<Color> colorList = [
    Color(0xFFFF8483),
    Color(0xFFFF8DCB),
    Color(0xFF45E575),
    Color(0xFFFFAD6D),
    Color(0xFF76B2FF),
    Color(0xFF5BDEDA),
    Color(0xFFFFCA61),
    Color(0xFFFF8483),
  ];
  CateList cateList = state.gameSpecial.cateList[index];
  return GestureDetector(
    onTap: () {
      dispatch(GameHotClassifyActionCreator.gotoClassify(cateList.typeId));
    },
    child: Container(
      width: 74,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: colorList[index % colorList.length],
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        cateList.typeName ?? '',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  );
}
