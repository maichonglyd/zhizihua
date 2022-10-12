import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_record/action.dart';
import 'package:flutter_huoshu_app/widget/huo_html_text/html_text_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/action.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/state.dart';

Widget buildView(
    AccountRecycleState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> views = List();
  views.add(Container(
    width: 360,
    margin: EdgeInsets.only(top: 9, left: 16, right: 16),
    padding: EdgeInsets.all(9),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Image.asset("images/pic_xioahaohuishou.png"),
        Container(
          color: Colors.white,
          child: Html(data: state.explain),
        ),
      ],
    ),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14))),
  ));
  state.recycleGames.forEach((recycleGame) {
    views.add(buildGameItem(state, dispatch, viewService, recycleGame));
  });
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textRecycle')),
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
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            dispatch(AccountRecycleActionCreator.gotoRecord());
          },
          child: Container(
            margin: EdgeInsets.only(right: 14),
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textRecycleHistory'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 15),
            ),
          ),
        ),
      ],
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: views,
        ), onRefresh: () {
      dispatch(AccountRecycleActionCreator.getRecycleList(1));
    }, loadMore: (page) {
      dispatch(AccountRecycleActionCreator.getRecycleListMore(page));
    }, controller: state.refreshHelperController),
  );
}

Widget buildGameItem(AccountRecycleState state, Dispatch dispatch,
    ViewService viewService, RecycleGame recycleGame) {
  Widget headView = Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 25,
          width: 25,
          margin: EdgeInsets.only(right: 5),
          child: ClipRRect(
            child: HuoNetImage(
              imageUrl: recycleGame.icon,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        Expanded(
            child: Text(
          recycleGame.gameName,
          style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
        )),
        Text(
          getText(name: 'textRecyclePercent', args: [(double.parse(recycleGame.rate) * 100).toStringAsFixed(1)]),
          style: TextStyle(fontSize: 10, color: AppTheme.colors.textColor),
        )
      ],
    ),
  );
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(left: 16, right: 16, top: 16),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      children: <Widget>[
        headView,
        for (RecycleMg item in recycleGame.recycleMgs)
          buildAccountItem(state, dispatch, viewService, item),
      ],
    ),
  );
}

Widget buildAccountItem(AccountRecycleState state, Dispatch dispatch,
    ViewService viewService, RecycleMg item) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      dispatch(AccountRecycleActionCreator.gotoCommit(item));
    },
    child: Container(
      height: 50,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: Color(0xFFFEF1EF),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                item.nickname,
                style:
                    TextStyle(fontSize: 14, color: AppTheme.colors.textColor),
              ),
              Text(
                getText(name: 'textExactlyRecharge', args: [item.sumMoney]),
                style: TextStyle(
                    fontSize: 10, color: AppTheme.colors.textSubColor2),
              ),
            ],
          )),
          Text(
            getText(name: 'textRecyclePrice'),
            style:
                TextStyle(fontSize: 10, color: AppTheme.colors.textSubColor2),
          ),
          Text(
            getText(name: 'textHavePrice', args: [item.amount]),
            style: TextStyle(fontSize: 10, color: AppTheme.colors.themeColor),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 13,
            color: AppTheme.colors.textSubColor2,
          ),
        ],
      ),
    ),
  );
}
