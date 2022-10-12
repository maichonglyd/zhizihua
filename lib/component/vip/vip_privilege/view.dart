import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/action.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/mine_setting/action.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    VIPPrivilegeState state, Dispatch dispatch, ViewService viewService) {
  //vip功能栏
  List<Widget> commonWidgets = List();
  commonWidgets.clear();
  Widget widget = buildWidget(state.commonTabs, dispatch, viewService, 1);
  commonWidgets.add(widget);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          "会员特权",
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.colors.textColor,
              fontWeight: FontWeight.w600),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      ),
      Container(
          height: 134,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 1),
                blurRadius: 5,
              )
            ],
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: commonWidgets,
          )),
    ],
  );
}

Widget buildWidget(
    List<Item> tabs, Dispatch dispatch, ViewService viewService, int type) {
  return Container(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tabs
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 82.5,
                    margin: type == 2
                        ? EdgeInsets.only(top: 15)
                        : EdgeInsets.all(0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            tabs[index].url,
                            height: 28,
                            width: 28,
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Text(
                                tabs[index].name,
                                style: TextStyle(
                                  fontSize: HuoTextSizes.mine_tab_small,
                                  color: AppTheme.colors.textSubColor,
                                ),
                              )),
                        ]),
                  ),
                  onTap: () {
                    switch (tabs[index].id) {
                      case 0: //任务大厅
                        {
                          dispatch(HomeActionCreator.gotoTaskCenter());
                          break;
                        }
                      case 1: //小号回收
                        {
                          dispatch(HomeActionCreator.gotoRecycle());
                          break;
                        }
                      case 2: // 充值返利
                        {
//                          dispatch(MineCommonFuncActionCreator.gotoRebate());
                          break;
                        }
                      case 3: //活动中心
                        {
//                          dispatch(
//                              MineCommonFuncActionCreator.gotoActivityNews());
                          break;
                        }
                      case 4: //开服表
                        {
                          dispatch(HomeActionCreator.gotoKaifu());
//                    showToast("开服表");
                          break;
                        }
                    }
                  },
                ))
            .toList()),
  );
}
