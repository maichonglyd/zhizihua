import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import '../../../../app_config.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(AccountRecycleRecordState state, Dispatch dispatch,
    ViewService viewService) {
  String timeStr = '';
  if (null != state.recycleExplain && null != state.recycleExplain.data.expireTime) {
    double time = state.recycleExplain.data.expireTime / 60 / 12;
    if (time > 0 && time < 0.5) {
      timeStr = "${state.recycleExplain.data.expireTime / 12}${getText(name: 'textMinute')}";
    } else {
      timeStr = "${state.recycleExplain.data.expireTime / 60 / 12}${getText(name: 'textHour')}";
    }
  }

  return state.recycleList != null
      ? Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: huoTitle(getText(name: 'textRecycleHistory')),
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
          body: state.refreshHelper.getEasyRefresh(
              ListView(
                children: <Widget>[
                  buildHead(state, viewService),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      getText(name: 'textRecycleAccountBuy', args: [timeStr]),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor2, fontSize: 15),
                    ),
                  ),
                  for (RecycleMg recycleMg in state.recycleList.data.list)
                    buildItem(recycleMg, dispatch, viewService),
                ],
              ), onRefresh: () {
            dispatch(AccountRecycleRecordActionCreator.getOrders(1));
          }, loadMore: (page) {
            dispatch(AccountRecycleRecordActionCreator.getOrders(page));
          }, controller: state.refreshHelperController),
        )
      : Container(
          color: Colors.white,
        );
}

Widget buildHead(AccountRecycleRecordState state, ViewService viewService) {
  return Container(
    height: 112,
    width: 360,
    margin: EdgeInsets.only(top: 9),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              getText(name: 'textRecycleNumber'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 15),
            ),
            Text(
              "${state.recycleExplain.data.recycleCnt}",
              style: TextStyle(color: AppTheme.colors.themeColor, fontSize: 32),
            )
          ],
        )),
        Container(
          color: AppTheme.colors.lineColor,
          margin: EdgeInsets.only(top: 25, bottom: 25),
          width: 1,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "${getText(name: 'textObtain')}${AppConfig.ptzName}",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 15),
            ),
            Text(
              "${state.recycleExplain.data.ptbCnt}",
              style: TextStyle(color: AppTheme.colors.themeColor, fontSize: 32),
            )
          ],
        )),
      ],
    ),
  );
}

Widget buildItem(RecycleMg recycleMg, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 154,
    margin: EdgeInsets.only(left: 16, right: 16, bottom: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              recycleMg.gameName,
              style: TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              getText(name: 'textRecyclePrice'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              "${getText(name: 'textExactlyRecharge', args: [recycleMg.sumMoney])}${getText(name: 'textPriceSymbol')}",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "${recycleMg.amount}",
              style: TextStyle(color: AppTheme.colors.themeColor, fontSize: 17),
            ),
          ],
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        Row(
          children: <Widget>[
            Text(
              "${getText(name: 'textAccountNicknameColon')}${recycleMg.nickname}",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              getText(name: 'textRecyclePercent', args: [recycleMg.rate * 100]),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "${AppUtil.formatDate2(recycleMg.createTime)}",
              style:
                  TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              getText(name: 'textRecycleSuccessful'),
              style: TextStyle(color: Color(0xFF05D84A), fontSize: 12),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: () {
                if (recycleMg.backStatus == 2)
                  dispatch(
                      AccountRecycleRecordActionCreator.payback(recycleMg.id));
              },
              child: Container(
                alignment: Alignment.center,
                height: 20,
                width: 43,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: recycleMg.backStatus == 1
                            ? AppTheme.colors.textSubColor2
                            : AppTheme.colors.themeColor,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  getText(name: 'textRedeem'),
                  style: TextStyle(
                      color: recycleMg.backStatus == 1
                          ? AppTheme.colors.textSubColor2
                          : AppTheme.colors.themeColor,
                      fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
