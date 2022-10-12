import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/Star_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCommentHeadState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 16, bottom: 30),
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    getText(name: 'textGameRating'),
                    style: TextStyle(
                        fontSize: HuoTextSizes.mine_tab,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    state.starCnt.starCnt.toString(),
                    style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.textColor),
                  ),
                  Container(
                    child: StarWidget((state.starCnt.starCnt / 2).round()),
                  ),
                  Text(
                    getText(name: 'textNumberRating', args: [state.starCnt.starAll]),
                    style: TextStyle(
                        fontSize: HuoTextSizes.mine_tab,
                        color: AppTheme.colors.textSubColor),
                  )
                ],
              ),
              flex: 4,
            ),
            Expanded(
              child: CommentWidget(state.starCnt),
              flex: 4,
            ),
          ],
        ),
      ),
      Container(
        width: 360,
        height: 44,
        margin: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(width: 1, color: Color(0xFF999999))),
        child: MaterialButton(
          onPressed: () {
            dispatch(GameCommentHeadActionCreator.gotoCommitComment());
          },
          child: Text(
            getText(name: 'textComment'),
            style: TextStyle(fontSize: 16, color: AppTheme.colors.textColor),
          ),
        ),
      )
    ],
  );
}
