import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealItemTitleState state, Dispatch dispatch, ViewService viewService) {
  return buildNextTitleItem(state.title, dispatch, state);
}

Widget buildNextTitleItem(
    String title, Dispatch dispatch, DealItemTitleState state) {
  return Container(
    color: Colors.white,
    height: 45,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Row(
      children: <Widget>[
        Container(
          height: 15,
          width: 5,
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(3))),
        ),
        Expanded(
          child: Text(title,
              style: commonTextStyle(
                  AppTheme.colors.textColor, HuoTextSizes.second_title)),
        ),
        GestureDetector(
          onTap: () {
            dispatch(DealItemTitleActionCreator.selectType());
          },
          child: Text(state.types[state.typeIndex],
              style: commonTextStyle(
                  AppTheme.colors.textSubColor, HuoTextSizes.game_title_sub)),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          size: 12,
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size) {
  return TextStyle(color: color, fontSize: size);
}
