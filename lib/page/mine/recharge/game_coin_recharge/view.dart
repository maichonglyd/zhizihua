import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/UsNumberTextInputFormatter.dart';
import 'package:flutter_huoshu_app/widget/huo_appbar.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCoinRechargeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: AppBar(
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
        title: huoTitle(getText(name: 'textRecharge')),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              dispatch(GameCoinRechargeActionCreator.gotoRecord());
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              child: Text(
                getText(name: 'textRechargeHistory'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15, color: AppTheme.colors.textSubColor),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            state.game == null
                ? GestureDetector(
                    onTap: () {
                      dispatch(GameCoinRechargeActionCreator.gotoSelectGame());
                    },
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(
                                getText(name: 'textPleaseSelectGame'),
                            style: TextStyle(
                                fontSize: 15, color: AppTheme.colors.textColor),
                          )),
                          Container(
                            margin: EdgeInsets.only(left: 7.5, right: 7.5),
                            child: Text(
                              getText(name: 'textSearch'),
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 15),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: AppTheme.colors.textColor,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 80,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(14.4)),
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.only(right: 10),
                            child: HuoNetImage(
                              imageUrl: state.game.icon,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              state.game.gameName,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.colors.textColor),
                            ),
                            Text(
//                              "平台： ${state.game.cpsInfo.channelName}",
                              "${getText(name: 'textPlatformColon')} ${state.game.cps.cpsName}",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.colors.textSubColor2),
                            )
                          ],
                        )),
                        GestureDetector(
                          onTap: () {
                            dispatch(
                                GameCoinRechargeActionCreator.changeGame());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              getText(name: 'textChangePlatform'),
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor2,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        )
                      ],
                    ),
                  ),
            Container(
              height: 10,
            ),
            state.game != null && state.game.isSdk == 1
                ? Container(child: buildCpsGame(state, dispatch, viewService))
                : Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  getText(name: 'textGameAccount'),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme.colors.textColor),
                                ),
                                margin: EdgeInsets.only(right: 25),
                              ),
                              Expanded(
                                  child: TextField(
                                      controller: state.accountController,
                                      decoration: InputDecoration(
                                        hintText: getText(name: 'textPleaseInputAccount'),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme.colors.textSubColor,
                                            fontSize: 15),
                                      ),
                                      style: TextStyle(
                                          textBaseline:
                                              TextBaseline.alphabetic)))
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  getText(name: 'textRechargePrice'),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppTheme.colors.textColor),
                                ),
                                margin: EdgeInsets.only(right: 25),
                              ),
                              Expanded(
                                  child: TextField(
                                      controller: state.amountController,
                                      inputFormatters: [
//                                        UsNumberTextInputFormatter(),
                                        WhitelistingTextInputFormatter(
                                            RegExp(r'\d+')),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: getText(name: 'textPleaseInputRechargePrice'),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            color: AppTheme.colors.textSubColor,
                                            fontSize: 15),
                                      ),
                                      style: TextStyle(
                                          textBaseline:
                                              TextBaseline.alphabetic)))
                            ],
                          ),
                        ),
                        Container(
                          height: 36.5,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            getText(name: 'textSelectPayWay'),
                            style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.colors.textSubColor3),
                          ),
                        ),
                        buildPayWayView(state, dispatch, getText(name: 'textAliPayRe'),
                            "images/pic_n_zhifubao.png", 0),
                        buildPayWayView(state, dispatch, getText(name: 'textWxPay'),
                            "images/pic_n_wechat.png", 1),
                        state.game != null
                            ? Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Text(
                                        getText(name: 'textRechargeDes'),
                                        style: TextStyle(
                                            color: Color(0xff666666),
                                            fontSize: 13),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 7),
                                        child: Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip1'),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip12'),
                                            style: TextStyle(
                                                color: Color(0xffFFD32F),
                                                fontSize: 12),
                                          ),
                                        ]))),
                                    Container(
                                        margin: EdgeInsets.only(top: 7),
                                        child: Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip2'),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip22'),
                                            style: TextStyle(
                                                color: Color(0xffFFD32F),
                                                fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: getText(name: 'textConsume'),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 12),
                                          ),
                                        ]))),
                                    Container(
                                        margin: EdgeInsets.only(top: 7),
                                        child: Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip3'),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: getText(name: 'textRechargeTip31'),
                                            style: TextStyle(
                                                color: Color(0xffFFD32F),
                                                fontSize: 12),
                                          ),
                                          TextSpan(
                                            text: getText(name: 'textUse'),
                                            style: TextStyle(
                                                color: Color(0xff999999),
                                                fontSize: 12),
                                          ),
                                        ]))),
                                  ],
                                ),
                              )
                            : Container(),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            child: Image.asset(
                              "images/icon_fankui.png",
                              height: 31,
                              width: 47,
                            ),
                            onTap: () {
                              dispatch(
                                  GameCoinRechargeActionCreator.gotoFeedback());
                            },
                          ),
                        )),
                        Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                color: Colors.white,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      getText(name: 'textNeedPay'),
                                      style: TextStyle(
                                          color: AppTheme.colors.textSubColor3,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${getText(name: 'textCurrencySymbol')}${(state.amount * (state.game != null ? state.game.rate : 1)).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              )),
                              GestureDetector(
                                onTap: () {
                                  dispatch(GameCoinRechargeActionCreator.pay());
                                },
                                child: Container(
                                  width: 110,
                                  alignment: Alignment.center,
                                  color: AppTheme.colors.themeColor,
                                  child: Text(
                                    getText(name: 'textRecharge'),
                                    style: TextStyle(
                                        color: AppTheme.colors.textColor,
                                        fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ));
}

Widget buildCpsGame(
    GameCoinRechargeState state, dispatch, ViewService viewService) {
  return Container(
    child: Expanded(
      child: Stack(
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              buildItemView(state, dispatch, viewService, getText(name: 'textGameAccount'), getText(name: 'textPleaseInputAccount'),
                  state.accountController, 1),
              Container(
                height: 1,
              ),
              buildItemView(state, dispatch, viewService, getText(name: 'textPassword'), getText(name: 'textPleaseInputAccountPassword'),
                  state.pswController, 1),
              Container(
                height: 1,
              ),
              buildItemView(state, dispatch, viewService, getText(name: 'textServiceSimple'), getText(name: 'textPleaseInputService'),
                  state.serverController, 1),
              Container(
                height: 1,
              ),
              buildItemView(state, dispatch, viewService, getText(name: 'textRoleName'), getText(name: 'textPleaseInputRole'),
                  state.roleNameController, 1),
              Container(
                height: 1,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        getText(name: 'textRechargePrice'),
                        style: TextStyle(
                            fontSize: 15, color: AppTheme.colors.textColor),
                      ),
                      margin: EdgeInsets.only(right: 25),
                    ),
                    Expanded(
                        child: TextField(
                            controller: state.amountController,
                            inputFormatters: [
                              UsNumberTextInputFormatter(),
//                              WhitelistingTextInputFormatter(RegExp(r'\d+')),
                            ],
                            decoration: InputDecoration(
                              hintText: getText(name: 'textPleaseInputRechargePrice'),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 15),
                            ),
                            style: TextStyle(
                                textBaseline: TextBaseline.alphabetic)))
                  ],
                ),
              ),
              buildItemView(state, dispatch, viewService, getText(name: 'textRemark'), getText(name: 'textPleaseInputRemark'),
                  state.remarkController, 1),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10, bottom: 0),
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 60,
                            margin: EdgeInsets.only(right: 25),
                            child: Text(
                              getText(name: 'textPicture'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.colors.textColor),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              getText(name: 'textUploadImage'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.colors.textSubColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 20, left: 14, right: 14, bottom: 14),
                        child: GridView.count(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: buildImageView(state, dispatch),
                        ))
                  ],
                ),
              ),
              Container(
                height: 36.5,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  getText(name: 'textSelectPayWay'),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor3),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 80),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    buildPayWayView(state, dispatch, getText(name: 'textAliPayRe'),
                        "images/pic_n_zhifubao.png", 0),
                    buildPayWayView(
                        state, dispatch, getText(name: 'textWxPay'), "images/pic_n_wechat.png", 1),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    color: Colors.white,
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          getText(name: 'textNeedPay'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor3,
                              fontSize: 13),
                        ),
                        Text(
                          "${getText(name: 'textCurrencySymbol')}${(state.amount * (state.game != null ? state.rate ?? 1 : 1)).toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      ],
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      dispatch(GameCoinRechargeActionCreator.pay());
                    },
                    child: Container(
                      width: 110,
                      alignment: Alignment.center,
                      color: AppTheme.colors.themeColor,
                      child: Text(
                        getText(name: 'textRecharge'),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

List<Widget> buildImageView(GameCoinRechargeState state, Dispatch dispatch) {
  List<Widget> picViews = state.images.asMap().keys.map((index) {
    return Stack(
      children: <Widget>[
        Container(
            height: 69,
            width: 69,
            margin: EdgeInsets.only(top: 8, right: 8),
            child: ClipRRect(
              child: state.images[index].isLocalFile
                  ? Image.file(
                      state.images[index].file,
                      fit: BoxFit.cover,
                    )
                  : HuoNetImage(
                      imageUrl: state.images[index].url,
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.all(Radius.circular(9)),
            )),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              dispatch(GameCoinRechargeActionCreator.deletePic(index));
            },
            child: Image.asset(
              "images/shenqingfanli_tijiaoshenqing.png",
              height: 18,
              width: 18,
            ),
          ),
        )
      ],
    );
  }).toList();
  if (picViews.length < 6) {
    picViews.add(Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            dispatch(GameCoinRechargeActionCreator.selectPic());
          },
          child: Container(
            height: 69,
            width: 69,
            margin: EdgeInsets.only(top: 8, right: 8),
            child: Image.asset("images/pingjia_icon_xiangji.png"),
          ),
        )
      ],
    ));
  }
  return picViews;
}

Widget buildItemView(
    GameCoinRechargeState state,
    dispatch,
    ViewService viewService,
    String leftTitle,
    String hintTextStr,
    TextEditingController controller,
    int inputType) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(left: 15, right: 15),
    child: Row(
      children: <Widget>[
        Container(
          width: 60,
          child: Text(
            leftTitle,
            style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
          ),
          margin: EdgeInsets.only(right: 25),
        ),
        Expanded(
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintTextStr,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 15),
                ),
                style: TextStyle(textBaseline: TextBaseline.alphabetic)))
      ],
    ),
  );
}

Widget buildPayWayView(GameCoinRechargeState state, Dispatch dispatch,
    String title, String image, int i) {
  return Container(
    height: 50,
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppTheme.colors.themeColor,
            value: state.payType == i ? true : false,
            onChanged: (value) {
              dispatch(GameCoinRechargeActionCreator.changePayType(i));
            }),
        Image.asset(
          image,
          height: 24,
          width: 24,
        ),
        Text(
          title,
          style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
        ),
      ],
    ),
  );
}
