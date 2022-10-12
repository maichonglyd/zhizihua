import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_detail_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/stop_game/page.dart';
import 'package:flutter_huoshu_app/widget/Star_widget.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TurnGameDetailState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  if (null != state.turnGameDetailModel) {
    widgetList.add(_buildHeaderView(state, dispatch, viewService));
    widgetList.add(_buildNotificationView());
    widgetList.addAll(state.turnGameDetailModel.data.welfareList
        .map((value) => _buildItemView(state, dispatch, viewService, value))
        .toList());
  }

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(null != state.turnGameDetailModel
          ? state.turnGameDetailModel.data.game.name
          : ''),
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
      color: AppTheme.colors.bgColor,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(bottom: 58),
            child: state.refreshHelper.getEasyRefresh(
              ListView(
                children: widgetList,
              ),
              controller: state.refreshHelperController,
              onRefresh: () {
                dispatch(TurnGameDetailActionCreator.getData());
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomButtonView(state, dispatch, viewService),
          )
        ],
      ),
    ),
  );
}

Widget _buildHeaderView(
    TurnGameDetailState state, Dispatch dispatch, ViewService viewService) {
  TurnGame game = state.turnGameDetailModel.data.game;
  return Container(
    height: 98,
    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.only(left: 15, right: 9),
          child: ClipRRect(
            child: HuoNetImage(
              imageUrl: game.icon ?? '',
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  game.name ?? '',
                  style: TextStyle(
                      color: AppTheme.colors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text(
                      AppUtil.gameTypeTransport(game.type, '·', 2),
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      '${game.userCnt}人在玩',
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 68,
          width: 68,
          margin: EdgeInsets.only(left: 10, right: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x1A003D6E),
                    offset: Offset(0, 0),
                    blurRadius: 4.0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(game.starCnt.toString(),
                  style: TextStyle(
                      fontSize: 23,
                      color: AppTheme.colors.textColor,
                      fontWeight: FontWeight.bold)),
              //自定义一个星星
              StarWidget((game.starCnt / 2).round())
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildNotificationView() {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
    child: Row(
      children: [
        Image.asset(
          'images/icon_horn_gold.png',
          width: 14,
          height: 14,
          fit: BoxFit.fill,
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            getText(name: 'textPlayedGameReplaceOther'),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
          ),
        )
      ],
    ),
  );
}

Widget _buildItemView(TurnGameDetailState state, Dispatch dispatch,
    ViewService viewService, TurnWelfareBean bean) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    padding: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 127,
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFF45D59),
                  Color(0xFFFF9466),
                ]),
          ),
          child: Text(
            '${getText(name: 'textReallyPay')}${getText(name: 'textCurrencySymbol')}${bean.startCharge ?? 0}-${bean.endCharge ?? 0}',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 15,
          ),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: getText(name: 'textTravelRights'),
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: getText(name: 'textCurrencySymbol'),
              style: TextStyle(
                  color: AppTheme.colors.themeColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '${bean.totalValue ?? 0}',
              style: TextStyle(
                  color: AppTheme.colors.themeColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ])),
        ),
        _buildImageTitleView(
            'images/icon_coupon_gold.png', getText(name: 'textHowManyCouponHasObtain', args: [bean.couponList.length])),
        _buildCouponView(state, dispatch, viewService, bean.couponList),
        _buildImageTitleView(
            'images/icon_gift_gold.png', getText(name: 'textHowManyGoodsHasObtain', args: [bean.propList.length]),
            text1: getText(name: 'textHowMuchValue', args: ['${getText(name: 'textCurrencySymbol')}${_getPropTotalValue(bean.propList)}'])),
        _buildPropView(state, dispatch, viewService, bean.propList),
      ],
    ),
  );
}

Widget _buildImageTitleView(String icon, String title, {String text1}) {
  return Container(
    margin: EdgeInsets.only(left: 16, top: 15, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon ?? '',
          width: 15,
          height: 15,
          fit: BoxFit.fill,
        ),
        Container(
          margin: EdgeInsets.only(left: 4),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: title ?? '',
              style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
            ),
            if (null != text1 && text1.isNotEmpty)
              TextSpan(
                text: text1,
                style:
                    TextStyle(color: AppTheme.colors.themeColor, fontSize: 13),
              ),
          ])),
        )
      ],
    ),
  );
}

Widget _buildCouponView(TurnGameDetailState state, Dispatch dispatch,
    ViewService viewService, List<TurnCouponBean> list) {
  if (list.length == 1) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 6),
      child: _buildCouponItemView(state, dispatch, viewService, list[0]),
    );
  }

  return Container(
    margin: EdgeInsets.only(left: 16),
    child: Wrap(
      spacing: 6,
      runSpacing: 6,
      children: list
          .map((value) =>
              _buildCouponItemView(state, dispatch, viewService, value))
          .toList(),
    ),
  );
}

Widget _buildCouponItemView(TurnGameDetailState state, Dispatch dispatch,
    ViewService viewService, TurnCouponBean coupon) {
  return Container(
    width: 95,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Color(0xFFFFF2E4),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: getText(name: 'textCurrencySymbol'),
                    style: TextStyle(color: Color(0xFFC4863D), fontSize: 11),
                  ),
                  TextSpan(
                    text: '${coupon.detail.amount ?? 0}',
                    style: TextStyle(color: Color(0xFFC4863D), fontSize: 15),
                  ),
                ],
              )),
              Container(
                child: Text(
                  getText(name: 'textAvailableForOver', args: [coupon.detail.condition ?? 0]),
                  style: TextStyle(color: Color(0xFFC4863D), fontSize: 10),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 23,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFD58C43),
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(5))),
            child: Text(
              getText(name: 'textCouponN'),
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropView(TurnGameDetailState state, Dispatch dispatch,
    ViewService viewService, List<TurnPropBean> list) {
  if (list.length == 1) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 6),
      child: _buildPropItemView(state, dispatch, viewService, list[0]),
    );
  }

  return Container(
    margin: EdgeInsets.only(left: 16),
    child: Wrap(
      spacing: 39,
      runSpacing: 10,
      children: list
          .map((value) =>
              _buildPropItemView(state, dispatch, viewService, value))
          .toList(),
    ),
  );
}

Widget _buildPropItemView(TurnGameDetailState state, Dispatch dispatch,
    ViewService viewService, TurnPropBean bean) {
  return Column(
    children: [
      Container(
        width: 63,
        height: 63,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppTheme.colors.themeColor, width: 1),
        ),
        child: Container(
          width: 51,
          height: 51,
          child: HuoNetImage(
            imageUrl: bean.icon ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        width: 74,
        alignment: Alignment.center,
        child: Text(
          bean.name ?? '',
          maxLines: 1,
          style: TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 11),
        ),
      )
    ],
  );
}

Widget _buildBottomButtonView(
    TurnGameDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 58,
    padding: EdgeInsets.only(left: 20, right: 20),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0x2A000000),
          offset: Offset(0, 1),
          blurRadius: 3,
        ),
      ],
    ),
    child: GestureDetector(
      onTap: () {
        if (state.isHas) {
          AppUtil.gotoPageByName(viewService.context, StopGamePage.pageName, arguments: {'activityId': state.activityId, 'game': state.turnGameDetailModel.data.game});
        }
      },
      child: Container(
        width: double.infinity,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: state.isHas
                ? AppTheme.colors.themeColor
                : AppTheme.colors.lineColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          state.isHas ? getText(name: 'textGamesCanTurn') : getText(name: 'textNoGamesToTurn'),
          style: TextStyle(
              color: state.isHas ? Colors.white : AppTheme.colors.textSubColor2,
              fontSize: 15),
        ),
      ),
    ),
  );
}

num _getPropTotalValue(List<TurnPropBean> list) {
  num result = 0;
  if (null != list) {
    for (TurnPropBean bean in list) {
      result += bean.value;
    }
  }
  return result;
}
