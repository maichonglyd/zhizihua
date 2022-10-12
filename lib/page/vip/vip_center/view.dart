import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/action.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

import 'state.dart';

Widget buildView(
    VipOpenState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: AppTheme.colors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        title: GestureDetector(
          child: Text(
            getText(name: 'textNumberCenter'),
            style: TextStyle(fontSize: 18, color: AppTheme.colors.textColor),
          ),
          onTap: () {
            dispatch(VipOpenActionCreator.showRewardDialog());
          },
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListView(
          children: <Widget>[
            Container(
              height: 170,
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "images/pic_top.png",
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 13),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: 42,
                                height: 42,
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/ic_goukabg.png")),
                                    shape: BoxShape.circle),
                                child: Text(
                                  getText(name: 'textBuyCardHistory'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xff005CC4)),
                                ),
                              ),
                              onTap: () {
                                dispatch(VipOpenActionCreator.showRecordDialog(
                                    state.recordList));
                              },
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            state.vipMods != null && state.vipMods.length > 0
                ? ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: state.vipMods.asMap().keys.map((index) {
                      return buildItem(state.vipMods[index], index, dispatch,
                          viewService, state);
                    }).toList(),
                    scrollDirection: Axis.vertical,
                  )
                : Container(),
            Center(
              child: Container(
                  width: 156,
                  height: 37,
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/pic_guzebg.png"))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/pic_zhuangshi_left.png",
                        width: 13,
                        height: 10,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          getText(name: 'textRuleDes'),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.colors.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Image.asset(
                        "images/pic_zhuangshi_right.png",
                        width: 13,
                        height: 10,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )),
            ),
            state.memInfoData != null &&
                    state.memInfoData.rules != null &&
                    state.memInfoData.rules.length > 0
                ? Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffF4FCFF),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          state.memInfoData.rules.asMap().keys.map((index) {
                        return buildTextItem(state.memInfoData.rules[index],
                            index, dispatch, viewService);
                      }).toList(),
                      scrollDirection: Axis.vertical,
                    ))
                : Container()
          ],
        ),
      ));
}

Widget buildTextItem(
    String content, int index, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Text(
      content,
      style: TextStyle(
        fontSize: 12,
        color: AppTheme.colors.textSubColor2,
      ),
    ),
  );
}

Widget buildItem(VIPMod vipMod, int index, Dispatch dispatch,
    ViewService viewService, VipOpenState state) {
  //字体颜色截取,后台返回的是#FFFFFF这种格式的
  String fontColor;
  if (vipMod.fontColor != null && vipMod.fontColor != "") {
    fontColor = "0xff${vipMod.fontColor.substring(1)}";
  }
  bool isVisibleOverlay = false;
  //是否显示可以领取
  int status = 0;
  String btnText = getText(name: 'textBuyNow');
  if (state.memInfoData != null) {
    if (state.memInfoData.vipId <= 0) {
      isVisibleOverlay = false;
    } else if (state.memInfoData.vipId == vipMod.id) {
      isVisibleOverlay = false;
      if (state.memInfoData.canGetPtb == 2) {
        //可以领取
        btnText = getText(name: 'textReceivingNow');
        status = 2;
      } else {
        btnText = getText(name: 'textHasReceivedSimple');
        status = 1;
      }
    } else {
      isVisibleOverlay = true;
    }
  }
  return Container(
    margin: EdgeInsets.only(bottom: 3, top: 8, left: 15, right: 15),
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Image.network(
              vipMod.background ?? "",
              fit: BoxFit.fill,
              height: 110,
              width: 330,
            ),
          ),
        ),
        Container(
          height: 95,
          width: 330,
          margin: EdgeInsets.only(left: 12, right: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
//                child: HuoNetImage(
//                  imageUrl: vipMod.icon ?? "",
//                  fit: BoxFit.cover,
//                  width: 80,
//                  height: 60,
//                ),
                child: Image.network(
                  vipMod.icon ?? "",
                  fit: BoxFit.cover,
                  width: 85,
                  height: 71,
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(
                        vipMod.name ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 100,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      color: Color(0xb2ffffff),
                    ),
                    Container(
                      width: 125,
                      child: Text(
                        vipMod.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xb2ffffff),
                        ),
                      ),
                    )
                  ],
                ),
              )),
              Container(
                height: 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            double.parse(vipMod.realAmount) == 0.01
                                ? "${vipMod.realAmount}${getText(name: 'textPriceSymbol')}"
                                : "${double.parse(vipMod.realAmount).toStringAsFixed(0)}${getText(name: 'textPriceSymbol')}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              "${getText(name: 'textOriginalPrice')}${double.parse(vipMod.amount).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xb2ffffff),
                                color: Color(0xb2ffffff),
                              ),
                            ),
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          btnText,
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(fontColor != null && fontColor != ""
                                  ? int.parse(fontColor)
                                  : 0xff8C63F4)),
//                          TextStyle(fontSize: 14, color: Color(0xff8C63F4),
                        ),
                      ),
                      onTap: () {
                        if (status == 0) {
                          //立即购买
                          dispatch(VipOpenActionCreator.showPayTypeDialog(
                              state.payWayMods, vipMod));
                        } else if (status == 2) {
                          //立即领取
                          dispatch(VipOpenActionCreator.reward(vipMod.id));
                        } else {
                          //已领取
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: isVisibleOverlay,
          child: Container(
            height: 97,
            width: 330,
            decoration: BoxDecoration(
                color: Color(0x72000000),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        )
      ],
    ),
  );
}
