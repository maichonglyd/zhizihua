import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LoadingDialogState state, Dispatch dispatch, ViewService viewService) {
  return Material(
    //创建透明层
    type: MaterialType.transparency, //透明类型
    child: Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        //保证控件居中效果
        child: new CircularProgressIndicator(),
      ),
    )
  );
}
