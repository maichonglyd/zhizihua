import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FeedbackState state, Dispatch dispatch, ViewService viewService) {
  FocusNode focusNode =
      state.blankToolBarModel.getFocusNodeByController(state.contentController);
  FocusNode focusNode2 =
      state.blankToolBarModel.getFocusNodeByController(state.mobileController);

  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textFeedbackAdvise')),
      centerTitle: true,
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
    ),
    body: BlankToolBarTool.blankToolBarWidget(viewService.context,
        model: state.blankToolBarModel,
        body: Column(
          children: <Widget>[
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
                  hintText: getText(name: 'textFeedbackTips'),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.hintTextColor,
                  ),
                  counterText: "",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: 15,
                ),
                focusNode: focusNode,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffeeeeee), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              margin: EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: TextField(
                controller: state.mobileController,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r'\d+')),
                  LengthLimitingTextInputFormatter(11)
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: getText(name: 'textLeavePhone'),
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: AppTheme.colors.hintTextColor,
                  ),
                  counterText: "",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: 15,
                ),
                focusNode: focusNode2,
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
                        child: new Text(getText(name: 'textConfirm')),
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        onPressed: () {
                          dispatch(FeedbackActionCreator.feedback());
                        },
                      ),
                    ),
                  ],
                )),
          ],
        )),
  );
}
