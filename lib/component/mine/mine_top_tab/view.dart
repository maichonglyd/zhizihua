import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/action.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineTopTabState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
      color: Colors.white,
    ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: state.tabNames
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          state.tabImages[index],
                          height: 35,
                          width: 35,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Text(
                              state.tabNames[index],
                              style: TextStyle(
                                fontSize: HuoTextSizes.mine_tab,
                                color: AppTheme.colors.textSubColor,
                              ),
                            )),
                      ]),
                  onTap: () {
                    print("onTap");
                    switch (index) {
                      case 0: //跳转我的礼包
                        {
                          dispatch(MineTopTabActionCreator.gotoMyGift());
                          break;
                        }
                      case 1: //跳转我的下载 or 邀请好友
                        {
                          if (Platform.isIOS) {
                            dispatch(MineFunListActionCreator.gotoInvite());
                          } else {
                            dispatch(MineTopTabActionCreator.gotoDownload());
                          }
                          break;
                        }
                      case 2: // 跳转充值页面
                        {
                          dispatch(MineTopTabActionCreator.gotoRecharge());
                          break;
                        }
                      case 3: //跳转 积分商城
                        {
                          dispatch(MineTopTabActionCreator.gotoIntegralShop());
                          break;
                        }
                    }
                  },
                ))
            .toList()),
  );
}
