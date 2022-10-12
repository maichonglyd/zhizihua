import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/lottery_index.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'package:flutter_huoshu_app/widget/separator_view.dart';

import 'action.dart';
import 'state.dart';
import 'dart:ui' as ui;

Widget buildView(
    LotteryState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textLottery')),
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
    body: state.lotteryIndexData != null
        ? Stack(
            children: <Widget>[
              Image.asset(
                "images/bg_sc_choujiang.png",
                width: double.maxFinite,
                fit: BoxFit.fill,
                height: double.maxFinite,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 60, right: 60, top: 20, bottom: 10),
                            child: Image.asset(
                              "images/bg_wa_goodluck.png",
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0x12000000),
//                                border: new Border.all(
//                                    width: 0.5, color: Color(0x12000000)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 4, bottom: 4),
                                    child: Text(getText(name: 'textTaskWinNumber'),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    dispatch(
                                        LotteryActionCreator.gotoTaskCenter());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffFF6720),
                                        border: new Border.all(
                                            width: 0.5,
                                            color: Color(0xffFF6720)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 4, bottom: 4),
                                    child: Text(getText(name: 'textGotoTaskCenter'),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                RotationTransition(
                                  //设置动画的旋转中心
                                  alignment: Alignment.center,
                                  //动画控制器
                                  turns: state.animation,
                                  //将要执行动画的子view
                                  child: Container(
                                    height: 300,
                                    width: 300,
                                    child: ClipRRect(
                                      child: new HuoNetImage(
                                        imageUrl: state
                                            .lotteryIndexData.data.rouletteImg,
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    child: ClipRRect(
                                      child: new HuoNetImage(
                                        imageUrl: state
                                            .lotteryIndexData.data.pointerImg,
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  ),
                                  onTap: () {
                                    dispatch(
                                        LotteryActionCreator.startLottery());
                                    //state.animationController.forward();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 70, right: 70, top: 0, bottom: 10),
                                  child: Image.asset(
                                    "images/bg_sc_qipao.png",
                                  ),
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        left: 70,
                                        right: 70,
                                        top: 17,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(getText(name: 'textTodayHas'),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            )),
                                        Text(
                                            state.lotteryIndexData.data.freeCnt
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xffFF6720),
                                              fontSize: 16,
                                            )),
                                        Text(getText(name: 'textFreeChange'),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            )),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          _createTitle(
                            getText(name: 'textWinningList'),
                          ),
                          _winningListView(state.lotteryIndexData.data.awardAd, viewService),
                          _createTitle(
                            getText(name: 'textMyReward'),
                          ),
                          state.lotteryIndexData.data.myAward.list.length > 0
                              ? Container(
                                  height: (state.lotteryIndexData.data.myAward
                                                      .list.length >
                                                  3
                                              ? 3
                                              : state.lotteryIndexData.data
                                                  .myAward.list.length) *
                                          72 +
                                      37.0,
                                  padding: EdgeInsets.only(top: 0),
                                  margin: EdgeInsets.only(
                                      left: 15, top: 5, right: 15, bottom: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          children: state.lotteryIndexData.data
                                              .myAward.list
                                              .sublist(
                                                  0,
                                                  state
                                                              .lotteryIndexData
                                                              .data
                                                              .myAward
                                                              .list
                                                              .length >
                                                          3
                                                      ? 3
                                                      : state
                                                          .lotteryIndexData
                                                          .data
                                                          .myAward
                                                          .list
                                                          .length)
                                              .map((data) =>
                                                  _buildItem(data, dispatch, viewService))
                                              .toList(),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          height: 37,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 5),
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 4,
                                              bottom: 4),
                                          child: Text(getText(name: 'textLookMore'),
                                              style: TextStyle(
                                                color: AppTheme
                                                    .colors.textSubColor2,
                                                fontSize: 11,
                                              )),
                                        ),
                                        onTap: () {
                                          AppUtil.gotoPageByName(
                                              viewService.context,
                                              ExchangeRecordPage.pageName,
                                              arguments: null);
                                        },
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                )
                              : Container(
                                  height: (state.lotteryIndexData.data.myAward
                                                      .list.length >
                                                  3
                                              ? 3
                                              : state.lotteryIndexData.data
                                                  .myAward.list.length) *
                                          75 +
                                      37.0,
                                  padding: EdgeInsets.only(top: 0),
                                  margin: EdgeInsets.only(
                                      left: 15, top: 5, right: 15, bottom: 15),
                                  child: Container(
                                    height: 37,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 4, bottom: 4),
                                    child: Text(getText(name: 'textNoHistory'),
                                        style: TextStyle(
                                          color: AppTheme.colors.textSubColor2,
                                          fontSize: 11,
                                        )),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Container(),
  );
}

Widget _buildItem(AwardListBean awardListBean, Dispatch dispatch, ViewService viewService) {
  String shippingStatus = "";
  switch (awardListBean.shippingStatus) {
    case 1:
      shippingStatus = getText(name: 'textNotDelivered');
      break;
    case 2:
      shippingStatus = getText(name: 'textHasDelivered');
      break;
    case 3:
      shippingStatus = getText(name: 'textDeliveredFailed');
      break;
    case 4:
      shippingStatus = getText(name: 'textUnclaimed');
      break;
    default:
      break;
  }
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              child: ClipRRect(
                child: new HuoNetImage(
                  imageUrl: awardListBean.originalImg,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Expanded(
                child: Container(
              height: 53,
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(awardListBean.awardName,
                      style: TextStyle(
                        color: AppTheme.colors.textColor,
                        fontSize: 14,
                      )),
                  Text(AppUtil.formatDate2(awardListBean.createTime),
                      style: TextStyle(
                        color: AppTheme.colors.textSubColor2,
                        fontSize: 11,
                      )),
                  Text(shippingStatus,
                      style: TextStyle(
                        color: Color(0xffFF6720),
                        fontSize: 11,
                      )),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                dispatch(LotteryActionCreator.showLotteryAddressDialog(
                    awardListBean.orderId));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: awardListBean.shippingStatus == 4
                        ? Color(0xffFF6720)
                        : Color(0xffDDDDDD),
                    border: new Border.all(
                        width: 0.5,
                        color: awardListBean.shippingStatus == 4
                            ? Color(0xffFF6720)
                            : Color(0xffDDDDDD)),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                margin: EdgeInsets.only(right: 5),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
                child: Text(getText(name: 'textGetPrize'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    )),
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 9, right: 9),
        height: 0.7,
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}

_winningListView(AwardList awardAd, ViewService viewService) {
  return Container(
      height: 120,
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Row(
        children: <Widget>[
          SeparatorView(
            color: Colors.white,
            isHorizontal: false,
            dashCount: 9,
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              SeparatorView(
                color: Colors.white,
                isHorizontal: true,
                dashCount: 20,
              ),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 15, bottom: 15, left: 17, right: 17),
                  child: ListView(
                    shrinkWrap: false,
                    physics: NeverScrollableScrollPhysics(),
                    children: awardAd.list
                        .sublist(0,
                            awardAd.list.length > 3 ? 3 : awardAd.list.length)
                        .map((data) => _buildWinningListItem(data, viewService))
                        .toList(),
                  ),
                ),
              ),
              SeparatorView(
                color: Colors.white,
                isHorizontal: true,
                dashCount: 20,
              ),
            ],
          )),
          SeparatorView(
            color: Colors.white,
            isHorizontal: false,
            dashCount: 9,
          ),
        ],
      ));
}

Widget _buildWinningListItem(AwardListBean data, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(
      top: 5,
      bottom: 5,
    ),
    child: Row(
      children: <Widget>[
        Text(getText(name: 'textUserGetReward', args: [data.username]),
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            )),
        Expanded(child: Container()),
        Text(data.awardName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
            )),
      ],
    ),
  );
}

_createTitle(String s) {
  return Container(
    margin: EdgeInsets.only(
      top: 15,
      bottom: 15,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 3,
            right: 3,
          ),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 3,
            right: 3,
          ),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(
            left: 3,
            right: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Text(s,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            )),
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(
            left: 10,
            right: 3,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 3,
            right: 3,
          ),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 3,
            right: 3,
          ),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ],
    ),
  );
}
