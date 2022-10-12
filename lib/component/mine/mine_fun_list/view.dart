import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineFunListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: Colors.white,
    child: Column(
      children: state.names
          .asMap()
          .keys
          .map((index) => Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      height: 55,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(14, 0, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              state.icons[index],
                              height: 27,
                              width: 27,
                            ),
                            margin: EdgeInsets.only(right: 10),
                          ),
                          Expanded(
                            child: Text(
                              state.names[index],
                              style: TextStyle(
                                  color: AppTheme.colors.textColor,
                                  fontSize: HuoTextSizes.second_title),
                            ),
                          ),
                          Image.asset(
                            "images/ng_more_icon_dark.png",
                            alignment: Alignment.centerRight,
                            height: 12,
                            width: 7,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      dispatch(state.actions[index]);
                    },
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(14, 0, 15, 0),
                      height: 1,
                      color: AppTheme.colors.lineColor),
                ],
              ))
          .toList(),
    ),
  );
}
