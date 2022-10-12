import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/cpl_mem_rank_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GamePlayerRechargeListState state, Dispatch dispatch,
    ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: huoTitle(getText(name: 'textPlayerList')),
      centerTitle: true,
      elevation: 0,
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
    body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          _buildHeaderTitleView(state, dispatch, viewService),
          Expanded(
              child: state.refreshHelper.getEasyRefresh(
                  ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildItemView(
                          state, dispatch, viewService, index);
                    },
                    itemCount: state.rankList.length,
                  ),
                  controller: state.refreshHelperController, onRefresh: () {
            dispatch(GamePlayerRechargeListActionCreator.getData(1));
          }))
        ],
      ),
    ),
  );
}

Widget _buildHeaderTitleView(GamePlayerRechargeListState state, Dispatch dispatch,
    ViewService viewService) {
  return Container(
    height: 44,
    color: Colors.white,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textRanking'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textPlayerNickname'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textCumulativeRevenue'),
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildItemView(GamePlayerRechargeListState state, Dispatch dispatch,
    ViewService viewService, int index) {
  return Container(
    height: 60,
    color: 0 == index % 2 ? Colors.white : AppTheme.colors.bgColor,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildItemHeaderView(state, dispatch, viewService, index),
        ),
        Expanded(
          flex: 1,
          child: _buildPlayer(state, dispatch, viewService, index),
        ),
        Expanded(
          flex: 1,
          child: _buildPrice(state, dispatch, viewService, index),
        ),
      ],
    ),
  );
}

Widget _buildItemHeaderView(GamePlayerRechargeListState state,
    Dispatch dispatch, ViewService viewService, int index) {
  Widget headerWidget = Container();
  if (3 > index) {
    String icon;
    switch (index) {
      case 0:
        icon = "images/icon_gold.png";
        break;
      case 1:
        icon = "images/icon_silver.png";
        break;
      case 2:
        icon = "images/icon_bronze.png";
        break;
    }
    headerWidget = Container(
      alignment: Alignment.center,
      child: Container(
        width: 22,
        height: 28,
        child: Image.asset(
          icon,
          fit: BoxFit.fill,
        ),
      ),
    );
  } else {
    headerWidget = Container(
      alignment: Alignment.center,
      child: Text(
        (index + 1).toString(),
        style: TextStyle(color: AppTheme.colors.themeColor, fontSize: 15),
      ),
    );
  }
  return headerWidget;
}

Widget _buildPlayer(GamePlayerRechargeListState state, Dispatch dispatch,
    ViewService viewService, int index) {
  CplMemRank cplMemRank = state.rankList[index];
  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          child: HuoNetImage(
            imageUrl: cplMemRank.avatar ?? '',
            width: 32,
            height: 32,
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          child: Text(
            cplMemRank.nickname ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: _getTextColor(index), fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrice(GamePlayerRechargeListState state, Dispatch dispatch,
    ViewService viewService, int index) {
  CplMemRank cplMemRank = state.rankList[index];
  return Container(
    alignment: Alignment.centerRight,
    margin: EdgeInsets.only(right: 23),
    child: Text(
      "${cplMemRank.money ?? 0}${getText(name: 'textPriceSymbol')}",
      style: TextStyle(color: _getTextColor(index), fontSize: 14),
    ),
  );
}

Color _getTextColor(int index) {
  Color textColor;
  if (3 > index) {
    switch (index) {
      case 0:
        textColor = Color(0xFFFFA200);
        break;
      case 1:
        textColor = Color(0xFF919191);
        break;
      case 2:
        textColor = Color(0xFFD86C00);
        break;
    }
  } else {
    textColor = AppTheme.colors.textColor;
  }
  return textColor;
}
