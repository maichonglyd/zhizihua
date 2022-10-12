import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AccountRecycleCommitState state, Dispatch dispatch,
    ViewService viewService) {
  GlobalKey<ScaffoldState> key = GlobalKey();
  return Scaffold(
    backgroundColor: Colors.white,
    key: key,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textRecycle')),
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
      elevation: 0,
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SplitLine(),
        Container(
            height: 68,
            width: 68,
            margin: EdgeInsets.only(top: 40),
            child: ClipRRect(
              child: HuoNetImage(
                imageUrl: state.recycleMg.icon,
              ),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            )),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            state.recycleMg.gameName,
            style: TextStyle(
              color: AppTheme.colors.textColor,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            state.recycleMg.nickname,
            style: TextStyle(
              color: AppTheme.colors.textColor,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            getText(name: 'textExactlyRecharge', args: [state.recycleMg.sumMoney]),
            style: TextStyle(
              color: AppTheme.colors.textSubColor,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Text(
            getText(name: 'textRecycleAccountTip', args: [AppConfig.ptzName]),
            style: TextStyle(
              color: Color(0xFF62B0FF),
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            getText(name: 'textRecycleAccountTip', args: [AppConfig.ptzName]),
            style: TextStyle(
              color: AppTheme.colors.textSubColor,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            state.recycleMg.amount.toString(),
            style: TextStyle(
              color: AppTheme.colors.themeColor,
              fontSize: 32,
            ),
          ),
        ),
        Expanded(child: Container()),
        Container(
            height: 40,
            margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 100),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: new MaterialButton(
                    color: AppTheme.colors.themeColor,
                    textColor: Colors.white,
                    child: new Text(getText(name: 'textConfirmSubmit')),
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    onPressed: () {
//                      key.currentState.showSnackBar(SnackBar(
//                        content: Text(
//                          "绑定手机时间还未超过3天，绑定手机且绑定时间超过3天方能进行小号回收操作！",
//                          style: TextStyle(fontSize: 12,color: AppTheme.colors.themeColor),
//                        ),
//                        backgroundColor: Color(0xFFFEF1EF),
//                      ));
                      dispatch(AccountRecycleCommitActionCreator.commit(
                          state.recycleMg.mgMemId));
                    },
                  ),
                ),
              ],
            )),
      ],
    ),
  );
}
