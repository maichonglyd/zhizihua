import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/coupon_my_reward_data.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineRewardState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: ListView.builder(
//          physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return buildItem(state, state.dataList[index], viewService, dispatch);
      },
      itemCount: state.dataList.length,
    ),
  );
}

Widget buildItem(MineRewardState state, CouponData data,
    ViewService viewService, Dispatch dispatch) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5, left: 14, right: 14),
    padding: EdgeInsets.only(top: 15, bottom: 15, left: 14, right: 14),
    decoration: BoxDecoration(
      color: Color(0xffFFF8ED),
      border: new Border.all(width: 0.5, color: AppTheme.colors.themeColor),
      borderRadius: BorderRadius.all(Radius.circular(3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(getText(name: 'textInviteNumberSuccessful', args: [data.memCnt]),
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.colors.textColor,
                  )),
              Text(getText(name: 'textInviteRewardCoupon', args: [data.gmCondition, data.gmCnt]),
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.colors.textSubColor,
                  )),
            ],
          ),
        ),
        Container(
            height: 30,
            width: 52,
            child: MaterialButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                if (data.canGet != 2) {
                  showToast(getText(name: 'toastNotUpToStandard'));
                  return;
                }
                if (data.isGet == 2) {
                  showToast(getText(name: 'toastHasGotReward'));
                  return;
                }
                dispatch(MineRewardActionCreator.getReward(data));
              },
              child: Text(
                getText(name: 'textReceive'),
                style: TextStyle(
                    fontSize: 12,
                    color: data.isGet == 2
                        ? Colors.white
                        : data.canGet == 2
                            ? AppTheme.colors.textColor
                            : Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: data.isGet == 2
                  ? Color(0xffDDDDDD)
                  : data.canGet == 2
                      ? AppTheme.colors.themeColor
                      : Color(0xffDDDDDD),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                  color: data.isGet == 2
                      ? Color(0xffDDDDDD)
                      : data.canGet == 2
                          ? AppTheme.colors.themeColor
                          : Color(0xffDDDDDD)),
            ))
      ],
    ),
  );
}
