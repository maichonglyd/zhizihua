import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCommitCommentState state, Dispatch dispatch, ViewService viewService) {
  List<int> list = List.generate(5, (index) => index);

  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textGameComment')),
      centerTitle: true,
      elevation: 0,
    ),
    body: RefreshHelper().getEasyRefresh(
        ListView(
          children: <Widget>[
            Container(
              height: 80,
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: list.asMap().keys.map((index) {
                  return GestureDetector(
                    onTap: () {
                      dispatch(GameCommitCommentActionCreator.changeNum(index));
                    },
                    child: Image.asset(
                      index >= state.starNum
                          ? "images/icon_n_stars_normal.png"
                          : "images/icon_n_stars_selected.png",
                      height: 48,
                      width: 48,
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 163,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffeeeeee), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: TextField(
                maxLines: 10,
                controller: state.contentController,
                decoration: InputDecoration(
                  hintText: getText(name: 'textInputCommentHint'),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.hintTextColor,
                  ),
                  contentPadding: EdgeInsets.all(14),
                  counterText: "",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: AppTheme.colors.textColor,
                ),
              ),
            ),
            Container(
                height: 40,
                margin: EdgeInsets.all(30),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new MaterialButton(
                        color: AppTheme.colors.themeColor,
                        textColor: Colors.white,
                        child: new Text(getText(name: 'textSubmit')),
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        onPressed: () {
                          dispatch(
                              GameCommitCommentActionCreator.commitComment());
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
        controller: RefreshHelperController()),
  );
}
