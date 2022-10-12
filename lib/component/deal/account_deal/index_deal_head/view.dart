import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexDealHeadState state, Dispatch dispatch, ViewService viewService) {
  UserInfo userInfo = LoginControl.getUserInfo();
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        IndexedStack(
          index: state.stackIndex,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              height: 67,
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(getText(name: 'textLookOrderInfoAfterLogin'))),
                  Container(
                    child: MaterialButton(
                      onPressed: () {
                        dispatch(IndexDealHeadActionCreator.gotoLogin());
                      },
                      height: 33,
                      minWidth: 67,
                      color: AppTheme.colors.themeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Text(
                        getText(name: 'login'),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    width: 67,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13))),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              height: 67,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(LoginControl.getUserName()),
                        Text(
                          userInfo != null &&
                                  userInfo.data != null &&
                                  userInfo.data.mobile != null &&
                                  userInfo.data.mobile.isNotEmpty
                              ? getText(name: 'textHasBondPhone')
                              : getText(name: 'textNoBindPhone'),
                          style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.colors.textSubColor),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      dispatch(IndexDealHeadActionCreator.gotoMySellPage(1));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 29),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            state.dealIndexData != null
                                ? state.dealIndexData.data.sellingCnt.toString()
                                : "0",
                            style: TextStyle(
                                fontSize: 22, color: AppTheme.colors.textColor),
                          ),
                          Text(
                            getText(name: 'textOnSale'),
                            style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.colors.textSubColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      dispatch(IndexDealHeadActionCreator.gotoMySellPage(2));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 29),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            state.dealIndexData != null
                                ? state.dealIndexData.data.soldCnt.toString()
                                : "0",
                            style: TextStyle(
                                fontSize: 22, color: AppTheme.colors.textColor),
                          ),
                          Text(
                            getText(name: 'textHasSold'),
                            style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.colors.textSubColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dispatch(IndexDealHeadActionCreator.gotoMyBuyPage());
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 29),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            state.dealIndexData != null
                                ? state.dealIndexData.data.boughtCnt.toString()
                                : "0",
                            style: TextStyle(
                                fontSize: 22, color: AppTheme.colors.textColor),
                          ),
                          Text(
                            getText(name: 'textBought'),
                            style: TextStyle(
                                fontSize: 10,
                                color: AppTheme.colors.textSubColor),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SplitLine(),
      ],
    ),
  );
}

Widget buildNextTitleItem(String title, ViewService viewService) {
  return Container(
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
        Text(getText(name: 'textMore'),
            style: commonTextStyle(
                AppTheme.colors.textSubColor, HuoTextSizes.game_title_sub)),
        Icon(
          Icons.arrow_forward_ios,
          size: 12,
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size) {
  return TextStyle(color: color, fontSize: size);
}
