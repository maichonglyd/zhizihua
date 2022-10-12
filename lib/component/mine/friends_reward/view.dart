import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/coupon_friend_reward_data.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FriendRewardState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Expanded(
        child: ListView(
          children: <Widget>[
            if (null == state.dataList || state.dataList.length <= 0)
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5, left: 14, right: 14),
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xffFFF8ED),
                  border: new Border.all(
                      width: 0.5, color: AppTheme.colors.themeColor),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                child: Text(getText(name: 'textNoFriendObtain'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.colors.textSubColor2,
                    )),
              ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(state, state.dataList[index], viewService);
                },
                itemCount: state.dataList.length,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 14, right: 14),
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Color(0xffFFF8ED),
                border: new Border.all(
                    width: 0.5, color: AppTheme.colors.themeColor),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(getText(name: 'textInvitationRewardTip'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.colors.textSubColor2,
                  )),
            ),
          ],
        ),
      )
    ],
  );
}

Widget buildItem(
    FriendRewardState state, DataInfo data, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5, left: 14, right: 14),
    padding: EdgeInsets.only(top: 15, bottom: 15, left: 14, right: 14),
    decoration: BoxDecoration(
      color: Color(0xffFFF8ED),
      border: new Border.all(width: 0.5, color: AppTheme.colors.themeColor),
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(data.username,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.colors.textColor,
                  )),
            ),
            Text(AppUtil.formatDate2(data.createTime),
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.colors.textSubColor2,
                )),
          ],
        ),
        Text(getText(name: 'textGetCouponSuccessful', args: [data.gmCnt]),
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.colors.textSubColor,
            )),
      ],
    ),
  );
}
