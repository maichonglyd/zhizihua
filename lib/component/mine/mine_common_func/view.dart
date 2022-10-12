import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_huoshu_app/common/auto_size/auto_size.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/action.dart';
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/action.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/base_icon_button.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/mine_setting/action.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineCommonFuncState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          getText(name: 'textCommonFunction'),
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.colors.textColor,
              fontWeight: FontWeight.w600),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
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
          child: _buildWrapView(state.commonList, dispatch)),
      Container(
        child: Text(
          getText(name: 'textComprehensive'),
          style: TextStyle(
              fontSize: 16,
              color: AppTheme.colors.textColor,
              fontWeight: FontWeight.w600),
        ),
        margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      ),
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 5, top: 20, right: 5, bottom: 20),
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
          child: _buildWrapView(state.comprehensiveList, dispatch)),
    ],
  );
}

Widget buildWidget(List<Item> tabs, Dispatch dispatch, ViewService viewService,
    int type, double eachWidth) {
  return Container(
    child: Row(
//        mainAxisAlignment:
//            type == 1 ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tabs
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: eachWidth,
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
                          dispatch(MineCommonFuncActionCreator.gotoRebate());
                          break;
                        }
                      case 3: //活动中心
                        {
                          dispatch(
                              MineCommonFuncActionCreator.gotoActivityNews());
                          break;
                        }
                      case 4: //开服表
                        {
                          dispatch(HomeActionCreator.gotoKaifu());
                          break;
                        }
//                      case 5: //优惠券
//                        {
//                          dispatch(MineCommonFuncActionCreator.gotoCoupon());
//                          break;
//                        }
                      case 5: //积分商城
                        {
                          dispatch(
                              MineCommonFuncActionCreator.gotoIntegralShop());
                          break;
                        }
                      case 6: //游戏币
                        {
                          dispatch(MineCommonFuncActionCreator
                              .gotoGameCurrencyList());
                          break;
                        }
                    }
                  },
                ))
            .toList()),
  );
}

Widget buildBottomWidget(List<Item> tabs, Dispatch dispatch,
    ViewService viewService, int type, double eachWidth) {
  return Container(
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment:
//            type == 1 ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs
            .asMap()
            .keys
            .map((index) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: eachWidth,
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
                      case 0: //我的礼包
                        {
                          dispatch(MineCommonFuncActionCreator.gotoMyGift());
                          break;
                        }
                      case 1: //我的账单
                        {
                          dispatch(MineCommonFuncActionCreator.gotoRecharge());
                          break;
                        }
                      case 2: // 邀请列表
                        {
                          dispatch(
                              MineCommonFuncActionCreator.gotoInviteList());
                          break;
                        }
                      case 3: //使用指南
                        {
                          dispatch(MineCommonFuncActionCreator
                              .gotoUseInstructions());
                          break;
                        }
                      case 4: //投诉反馈
                        {
                          dispatch(MineCommonFuncActionCreator.gotoFeedback());
                          break;
                        }
                      case 5: //联系客服
                        {
                          dispatch(MineCommonFuncActionCreator.gotoService());
                          break;
                        }
                      case 6: //隐私协议
                        {
                          dispatch(
                              MineCommonFuncActionCreator.gotoUserPrivacy());
                          break;
                        }
                      case 7: //免责声明
                        {
                          dispatch(
                              MineCommonFuncActionCreator.gotoDisclaimer());
                          break;
                        }
                      case 8: //纠纷处理
                        {
                          dispatch(MineCommonFuncActionCreator
                              .gotoDisputeResolution());
                          break;
                        }
                    }
                  },
                ))
            .toList()),
  );
}

Widget _buildWrapView(List<BaseIconButton> list, Dispatch dispatch) {
  return Wrap(
    spacing: 8,
    runSpacing: 20,
    children: list.map((value) => _buildIconButton(value, dispatch)).toList(),
  );
}

Widget _buildIconButton(BaseIconButton iconButton, Dispatch dispatch) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    child: Container(
      width: 70,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              iconButton.icon ?? 0,
              height: 28,
              width: 28,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text(
                  iconButton.name,
                  style: TextStyle(
                    fontSize: HuoTextSizes.mine_tab_small,
                    color: AppTheme.colors.textSubColor,
                  ),
                )),
          ]),
    ),
    onTap: () {
      switch (iconButton.id) {
        case 100: //任务大厅
          {
            dispatch(HomeActionCreator.gotoTaskCenter());
            break;
          }
        case 101: //小号回收
          {
            dispatch(HomeActionCreator.gotoRecycle());
            break;
          }
        case 102: // 充值返利
          {
            dispatch(MineCommonFuncActionCreator.gotoRebate());
            break;
          }
        case 103: //活动中心
          {
            dispatch(MineCommonFuncActionCreator.gotoActivityNews());
            break;
          }
        case 104: //开服表
          {
            dispatch(HomeActionCreator.gotoKaifu());
            break;
          }
        case 105: //优惠券
          {
            dispatch(MineCommonFuncActionCreator.gotoCoupon());
            break;
          }
        case 106: //积分商城
          {
            dispatch(MineCommonFuncActionCreator.gotoIntegralShop());
            break;
          }
        case 107: //游戏币
          {
            dispatch(MineCommonFuncActionCreator.gotoGameCurrencyList());
            break;
          }
        case 1000: //我的礼包
          {
            dispatch(MineCommonFuncActionCreator.gotoMyGift());
            break;
          }
        case 1001: //我的账单
          {
            dispatch(MineCommonFuncActionCreator.gotoRecharge());
            break;
          }
        case 1002: // 邀请列表
          {
            dispatch(MineCommonFuncActionCreator.gotoInviteList());
            break;
          }
        case 1003: //使用指南
          {
            dispatch(MineCommonFuncActionCreator.gotoUseInstructions());
            break;
          }
        case 1004: //投诉反馈
          {
            dispatch(MineCommonFuncActionCreator.gotoFeedback());
            break;
          }
        case 1005: //联系客服
          {
            dispatch(MineCommonFuncActionCreator.gotoService());
            break;
          }
        case 1006: //隐私协议
          {
            dispatch(MineCommonFuncActionCreator.gotoUserPrivacy());
            break;
          }
        case 1007: //免责声明
          {
            dispatch(MineCommonFuncActionCreator.gotoDisclaimer());
            break;
          }
        case 1008: //纠纷处理
          {
            dispatch(MineCommonFuncActionCreator.gotoDisputeResolution());
            break;
          }
      }
    },
  );
}
