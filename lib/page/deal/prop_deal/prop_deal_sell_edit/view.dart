import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealSellEditState state, Dispatch dispatch, ViewService viewService) {
  FocusNode focusNode =
      state.blankToolBarModel.getFocusNodeByController(state.contentController);

  return Material(
    child: Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: huoTitle(getText(name: 'textSellProps')),
          ),
          body: RefreshHelper().getEasyRefresh(
              ListView(
                children: <Widget>[
                  SplitLine(),
                  Container(
                    height: 53,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(getText(name: 'textGameColon'))),
                        GestureDetector(
                          child: state.playedGame == null
                              ? Text(getText(name: 'toastSelectSellGame'))
                              : Text(state.playedGame.gameName),
                          onTap: () {
                            if (state.goodsId == null)
                              dispatch(PropDealSellEditActionCreator
                                  .gotoSelectGame());
                          },
                        ),
                        if (state.goodsId == null)
                          Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                          )
                      ],
                    ),
                  ), //选择游戏
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                    height: 53,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: Row(
                      children: <Widget>[
                        Text(getText(name: 'textServiceColon')),
//                            state.accountServer == null
//                                ? Text("")
//                                : Text(state.accountServer.serverName),
                        Expanded(child: Container()),
                        DropdownButton(
                          underline: Container(),
                          items: buildAndGetDropDownMenuItems(
                              state.services != null
                                  ? state.services
                                      .map((server) => server.serverName)
                                      .toList()
                                  : []),
                          hint: new Text(
                            state.curServer != null
                                ? state.curServer.serverName
                                : getText(name: 'textSelectService'),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.colors.textSubColor),
                          ),
                          onChanged: (String v) {
                            dispatch(
                                PropDealSellEditActionCreator.selectServer(v));
                          },
                        )
                      ],
                    ),
                  ), //区服
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                    height: 53,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: Row(
                      children: <Widget>[
                        Text(getText(name: 'textRoleColon')),
                        Expanded(child: Container()),
                        DropdownButton(
                          underline: Container(),
                          items: buildAndGetDropDownMenuItems(
                              state.roles != null
                                  ? state.roles
                                      .map((role) => role.roleName)
                                      .toList()
                                  : []),
                          hint: new Text(
                            state.curRole != null
                                ? state.curRole.roleName
                                : getText(name: 'textSelectRole'),
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.colors.textSubColor),
                          ),
                          onChanged: (String v) {
                            dispatch(
                                PropDealSellEditActionCreator.selectRole(v));
                          },
                        )
//                            state.accountServer == null
//                                ? Text("")
//                                : Text(state.accountServer.serverName),
                      ],
                    ),
                  ), //角色名
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                    height: 53,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: Row(
                      children: <Widget>[
                        Text(getText(name: 'textPriceColon')),
                        Expanded(
                          child: TextField(
                            inputFormatters: [],
                            maxLength: 8,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: state.priceController,
                            decoration: InputDecoration(
                              hintText: getText(name: 'textInputLowestPrice', args: [state.minPrice]),
                              hintStyle: TextStyle(
                                  color: AppTheme.colors.hintTextColor,
                                  fontSize: 14),
                              contentPadding: EdgeInsets.all(0),
                              counterText: "",
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(
                              color: AppTheme.colors.textColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ), //价格
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 14),
                    alignment: Alignment.topRight,
                    child: Text(
                      state.priceController.text.isEmpty
                          ? ""
//                          : "手续费${state.feeRate}%(最低${state.minFee}元)，售出可得${state.obtainPtb ?? "x"}${AppConfig.ptzName}。",
                          : getText(name: 'textLowestServiceCharge', args: [state.feeRate, state.minFee, state.obtainPtb ?? "x", AppConfig.ptzName]),
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                    ),
                  ), //手续费提示
                  Container(
                    padding: EdgeInsets.only(left: 14, right: 14, top: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(getText(name: 'textGoodsNameColon'))),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: TextField(
                      controller: state.titleController,
                      inputFormatters: [],
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: getText(name: 'textPleaseInputGoodsName'),
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
                  ), //商品标题
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 14, right: 14, top: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text(getText(name: 'textDesColon'))),
                      ],
                    ),
                  ),
                  Container(
                    height: 123,
                    padding: EdgeInsets.only(left: 14, right: 14),
                    child: TextField(
                      controller: state.contentController,
                      inputFormatters: [],
                      maxLength: 199,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: getText(name: 'textDesGoodsDetail'),
                        hintStyle: TextStyle(
                            color: AppTheme.colors.hintTextColor, fontSize: 14),
                        contentPadding: EdgeInsets.only(left: 10, top: 10),
                        counterText: "",
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(
                        color: AppTheme.colors.textColor,
                      ),
                      focusNode: focusNode,
                    ),
                  ), //描述
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: 20, left: 14, right: 14, bottom: 59),
                      height: 200,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: buildImageView(state, dispatch),
                      )), //选择图片
                ],
              ),
              controller: RefreshHelperController()),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 59,
            color: Colors.white,
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            width: 360,
            child: MaterialButton(
              onPressed: () {
                dispatch(PropDealSellEditActionCreator.commit());
              },
              minWidth: 300,
              height: 40,
              color: AppTheme.colors.themeColor,
              child: Text(
                getText(name: 'textSubmitApply'),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

List<Widget> buildImageView(PropDealSellEditState state, Dispatch dispatch) {
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
              dispatch(PropDealSellEditActionCreator.deletePic(index));
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
            dispatch(PropDealSellEditActionCreator.selectPic());
          },
          child: Container(
            height: 69,
            width: 69,
            margin: EdgeInsets.only(top: 8, right: 8),
            child: Image.asset("images/mine_icon_add_pic.png"),
          ),
        )
      ],
    ));
  }
  return picViews;
}

List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
  List<DropdownMenuItem<String>> items = List();
  for (String fruit in fruits) {
    items.add(DropdownMenuItem(
        value: fruit,
        child: Container(
          width: 60,
          alignment: Alignment.center,
          child: Text(
            fruit,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        )));
  }
  return items;
}
