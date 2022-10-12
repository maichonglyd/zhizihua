import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/BlankToolBarTool.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_picker/flutter_picker.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

const int TYPE_GAME_NAME = 1;
const int TYPE_GAME_ACCOUNT = 2;
const int TYPE_GAME_TIME = 3;
const int TYPE_GAME_SERVICE = 4;
const int TYPE_GAME_ROLE_NAME = 5;
const int TYPE_GAME_ROLE_ID = 6;
const int TYPE_GAME_MONEY = 7;
const int TYPE_Phone = 8;
const int TYPE_MORE = 9;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Widget buildView(
    RebateCommitState state, Dispatch dispatch, ViewService viewService) {
  FocusNode focusNode =
      state.blankToolBarModel.getFocusNodeByController(state.contentController);

  return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: huoTitle(getText(name: 'textRebate')),
        centerTitle: true,
      ),
      body: BlankToolBarTool.blankToolBarWidget(
        viewService.context,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SplitLine(),
                buildItem(TYPE_GAME_NAME, state, dispatch, viewService),
                buildItem(TYPE_GAME_ACCOUNT, state, dispatch, viewService),
                buildItem(TYPE_GAME_TIME, state, dispatch, viewService),
                buildItem(TYPE_GAME_SERVICE, state, dispatch, viewService),
                buildItem(TYPE_GAME_ROLE_NAME, state, dispatch, viewService),
                buildItem(TYPE_GAME_ROLE_ID, state, dispatch, viewService),
                buildItem(TYPE_GAME_MONEY, state, dispatch, viewService),
                SplitLine(),
                buildInputItem(TYPE_Phone, state, focusNode, viewService),
                buildInputItem(TYPE_MORE, state, focusNode, viewService),
                Container(
                  height: 60,
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 60,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                child: MaterialButton(
                  onPressed: () {
                    dispatch(RebateCommitActionCreator.commit());
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
        model: state.blankToolBarModel,
      ));
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

Widget buildItem(int type, RebateCommitState state, Dispatch dispatch, ViewService viewService) {
  double height = 55;
  String title = "";
  Widget typeView = Container();
  switch (type) {
    case TYPE_GAME_NAME:
      {
        title = getText(name: 'textGameName');
        typeView = Text(
          state.rebateGame.gameName,
          style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
        );
        break;
      }
    case TYPE_GAME_ACCOUNT:
      {
        title = getText(name: 'textApplyAccount');
        typeView = Text(
          LoginControl.getUserInfo().data.username,
          style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
        );
        break;
      }
    case TYPE_GAME_TIME:
      {
        title = getText(name: 'textRechargeTime');
        typeView = GestureDetector(
          child: Text(
            state.time,
            style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
          ),
          onTap: () {
            Picker picker = new Picker(
                adapter: new DateTimePickerAdapter(
                    type: PickerDateTimeType.kYMD,
                    isNumberMonth: true,
                    yearSuffix: "",
                    monthSuffix: "",
                    daySuffix: ""),
                title: new Text(""),
                onConfirm: (Picker picker, List value) {
                  dispatch(RebateCommitActionCreator.selectDate(
                      picker.adapter.text.substring(0, 10)));
                },
                onSelect: (Picker picker, int index, List<int> selecteds) {});
            picker.show(_scaffoldKey.currentState);
          },
        );
        break;
      }
    case TYPE_GAME_SERVICE:
      {
        title = getText(name: 'textGameService');
        typeView = DropdownButton(
          underline: Container(),
          items: buildAndGetDropDownMenuItems(
              state.service.map((server) => server.serverName).toList()),
          hint: new Text(
            state.curServer != null ? state.curServer.serverName : getText(name: 'textSelectService'),
            style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
          ),
          onChanged: (v) {
            print(v);
            dispatch(RebateCommitActionCreator.selectServer(v));
          },
        );
//        typeView = GestureDetector(
//          child: Row(
//            children: <Widget>[
//              Text(
//                "选择区服",
//                style:
//                TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
//              ),
//              Icon(Icons.arrow_drop_down,size: 16,)
//            ],
//          ),
//          onTap: (){
//            dispatch(RebateCommitActionCreator.showRoleDialog());
//          },
//        );
        break;
      }

    case TYPE_GAME_ROLE_NAME:
      {
        title = getText(name: 'textRoleName');
        typeView = DropdownButton(
          underline: Container(),
          items: buildAndGetDropDownMenuItems(state.curServer != null
              ? state.curServer.roleList
                  .map((roleList) => roleList.roleName)
                  .toList()
              : []),
          hint: new Text(
            state.curRole != null ? state.curRole.roleName : getText(name: 'textSelectRoleName'),
            style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
          ),
          onChanged: (String v) {
            dispatch(RebateCommitActionCreator.selectRole(v));
          },
        );
        break;
      }
    case TYPE_GAME_ROLE_ID:
      {
        title = getText(name: 'textRoleId');
        typeView = Container(
          width: 150,
          child: TextField(
            textAlign: TextAlign.right,
            controller: state.roleController,
            inputFormatters: [],
            decoration: InputDecoration(
              hintText: getText(name: 'textPleaseInputRoleId'),
              hintStyle:
                  TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 14),
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
        );
        break;
      }

    case TYPE_GAME_MONEY:
      {
        title = getText(name: 'textRechargePrice');
        typeView = Text(
          state.realAmount.toString(),
          style: TextStyle(fontSize: 14, color: AppTheme.colors.themeColor),
        );
        break;
      }
  }
  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: height,
        child: Row(
          children: <Widget>[
            Text(title,
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.textColor)),
            Expanded(
              child: Container(),
            ),
            typeView
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: 1,
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}

Widget buildInputItem(int type, RebateCommitState state, FocusNode focusNode, ViewService viewService) {
  bool isTop = false;
  double height = 55;
  String title = "";
  Widget typeView = Container();
  switch (type) {
    case TYPE_Phone:
      {
        title = getText(name: 'textPhoneNumberColon');
        typeView = Expanded(
            child: TextField(
          controller: state.mobileController,
          inputFormatters: [
            WhitelistingTextInputFormatter(RegExp(r'\d+')),
            LengthLimitingTextInputFormatter(11)
          ],
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: getText(name: 'mobileInputHint'),
            hintStyle:
                TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 15),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          style: TextStyle(
            color: AppTheme.colors.textColor,
          ),
        ));
        break;
      }
    case TYPE_MORE:
      {
        height = 160;
        isTop = true;
        title = getText(name: 'textRemarkColon');
        typeView = Expanded(
            child: TextField(
          maxLines: 5,
          controller: state.contentController,
          decoration: InputDecoration(
            hintText: "",
            hintStyle: TextStyle(
              color: AppTheme.colors.hintTextColor,
            ),
            contentPadding: EdgeInsets.only(left: 15),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          style: TextStyle(
            color: AppTheme.colors.textColor,
          ),
          focusNode: focusNode,
        ));
        break;
      }
  }

  return Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 14, right: 14, top: isTop ? 14 : 0),
        height: height,
        child: Row(
          crossAxisAlignment:
              isTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.textColor)),
            typeView
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: 1,
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}
