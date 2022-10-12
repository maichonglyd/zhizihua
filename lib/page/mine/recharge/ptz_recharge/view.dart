import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/widget/UsNumberTextInputFormatter.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PtzRechargeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle("${AppConfig.ptzName}${getText(name: 'textRecharge')}"),
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
      elevation: 0,
    ),
    body: RefreshHelper().getEasyRefresh(
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 75,
                padding: EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${getText(name: 'textAccountColon')}${LoginControl.getUserName()}"),
//                    Text("平台币余额：${state.ptbCnt}"),
                    Text("${AppConfig.ptzName}${getText(name: 'textBalanceColon')}${state.ptbCnt}"),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SplitLine(),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          getText(name: 'textRecharge'),
                          style: TextStyle(
                              fontSize: 14, color: AppTheme.colors.textColor),
                        ),
                        Text(
                          getText(name: 'textPtzEqualPrice', args: [AppConfig.ptzName]),
                          style: TextStyle(
                              fontSize: 12, color: AppTheme.colors.textColor),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid.count(
              childAspectRatio: 1.6,
              crossAxisCount: 3,
              children: state.defaultMoneys
                  .asMap()
                  .keys
                  .map((index) => GestureDetector(
                        onTap: () {
                          dispatch(PtzRechargeActionCreator.selectPrice(index));
                        },
                        child: buildMoney(state.defaultMoneys[index],
                            state.money == state.defaultMoneys[index], viewService),
                      ))
                  .toList(),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 44,
                alignment: Alignment.center,
                margin: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFCCCCCC), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp(r'\d+')),
                    LengthLimitingTextInputFormatter(8),
//                    UsNumberTextInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  controller: state.priceController,
                  decoration: InputDecoration(
                    hintText: getText(name: 'textCustomPrice'),
                    hintStyle: TextStyle(
                        color: AppTheme.colors.hintTextColor, fontSize: 14),
                    contentPadding: EdgeInsets.only(left: 15),
                    counterText: "",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: AppTheme.colors.textColor,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Text(
                  "${getText(name: 'textWillGet')}${state.money}${AppConfig.ptzName}",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.colors.textColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SplitLine(),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Text(
                  getText(name: 'textSelectPayWay'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.textColor,
                      fontSize: 15),
                ),
                margin: EdgeInsets.all(14),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((content, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5),
                      child: buildPayWayViewFlex(
                          state, dispatch, state.payWayMods[index], index)),
                );
              }, childCount: state.payWayMods.length),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      dispatch(PtzRechargeActionCreator.ptzPay());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 30, bottom: 30),
                      decoration: BoxDecoration(
                          color: AppTheme.colors.themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        getText(name: 'textPayNow'),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),

//            SliverToBoxAdapter(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Container(
//                    child: Text(
//                      "选择支付方式",
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          color: AppTheme.colors.textColor,
//                          fontSize: 15),
//                    ),
//                    margin: EdgeInsets.all(14),
//                  ),
//                  buildPayWayView(state, dispatch, "支付宝（推荐）",
//                      "images/pic_n_zhifubao.png", 0),
//                  buildPayWayView(
//                      state, dispatch, "微信支付", "images/pic_n_wechat.png", 1),
//                  Container(
//                    width: 360,
//                    height: 59,
//                    margin: EdgeInsets.only(top: 30),
//                    padding: EdgeInsets.only(
//                        left: 30, bottom: 10, right: 30, top: 10),
//                    color: Colors.white,
//                    child: MaterialButton(
//                      onPressed: () {
//                        //回调
//                        dispatch(PtzRechargeActionCreator.ptzPay());
//                      },
//                      height: 39,
//                      minWidth: 300,
//                      color: AppTheme.colors.themeColor,
//                      child: Text(
//                        "立即付款",
//                        style: TextStyle(fontSize: 15, color: Colors.white),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
          ],
        ),
        controller: RefreshHelperController()),
  );
}

Widget buildPayWayViewFlex(
    PtzRechargeState state, Dispatch dispatch, PayWayMod payWayMod, int index) {
  return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(payWayMod.icon ?? "",
                  width: 24, height: 24, fit: BoxFit.cover),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  payWayMod.name ?? "",
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
                ),
              )),
              GestureDetector(
                child: Image.asset(
                  payWayMod.isSelected
                      ? "images/circle_ic_selection_bule.png"
                      : "images/circle_ic_normal_stroke.png",
                  height: 22,
                  width: 22,
                ),
                onTap: () {
//                  dispatch(PtzRechargeActionCreator.selectPayType(index));
                  dispatch(PtzRechargeActionCreator.selectPayTypeList(index));
                },
              )
            ],
          ),
          Divider()
        ],
      ));
}

Widget buildPayWayView(PtzRechargeState state, Dispatch dispatch, String title,
    String image, int i) {
  return Container(
    child: Row(
      children: <Widget>[
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppTheme.colors.themeColor,
            value: i == state.payType,
            onChanged: (value) {
              dispatch(PtzRechargeActionCreator.updatePayType(i));
//              setState(() {
////                index = i;
////              });
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

Widget buildMoney(int price, bool isSelect, ViewService viewService) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(14),
    child: Text(
      "$price${getText(name: 'textPriceSymbol')}",
      style: TextStyle(
        fontSize: 18,
        color: isSelect ? AppTheme.colors.themeColor : Color(0xFFCCCCCC),
      ),
    ),
    decoration: BoxDecoration(
        border: Border.all(
            color: isSelect ? AppTheme.colors.themeColor : Color(0xFFCCCCCC),
            width: 1),
        borderRadius: BorderRadius.all(Radius.circular(4))),
  );
}
