import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_game_detail/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TurnGiftState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textTurnGameGift')),
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
      child: state.refreshHelper.getEasyRefresh(
        ListView(
          children: state.list
              .map((value) =>
                  _buildItemView(state, dispatch, viewService, value))
              .toList(),
        ),
        controller: state.refreshHelperController,
        onRefresh: () {
          dispatch(TurnGiftActionCreator.getData(1));
        },
        loadMore: (page) {
          dispatch(TurnGiftActionCreator.getData(page));
        },
      ),
    ),
  );
}

Widget _buildItemView(TurnGiftState state, Dispatch dispatch,
    ViewService viewService, TurnGiftBean bean) {
  return GestureDetector(
    onTap: () {
      // AppUtil.gotoPageByName(viewService.context, TurnGameDetailPage.pageName, arguments: {'activityId': bean.activityId});
    },
    child: Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildGameView(bean.fromGame.icon, bean.fromGame.name),
              Expanded(
                flex: 98,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        getText(name: 'textTurn'),
                        style: TextStyle(
                            color: AppTheme.colors.themeColor, fontSize: 14),
                      ),
                      Image.asset(
                        'images/pic_arrow_white.png',
                        width: double.infinity,
                        height: 10,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ),
              _buildGameView(bean.toGame.icon, bean.toGame.name),
            ],
          ),
          if (null != bean.couponList && bean.couponList.length > 0)
            _buildImageTitleView('images/icon_coupon_gold.png',
                getText(name: 'textHowManyCouponHasObtain', args: [bean.couponList.length])),
          if (null != bean.couponList && bean.couponList.length > 0)
            _buildCouponView(state, dispatch, viewService, bean.couponList),
          if (null != bean.propList && bean.propList.length > 0)
            _buildImageTitleView(
                'images/icon_gift_gold.png', getText(name: 'textHowManyGoodsHasObtain', args: [bean.propList.length])),
          if (null != bean.propList && bean.propList.length > 0)
            _buildPropView(state, dispatch, viewService, bean.propList),
        ],
      ),
    ),
  );
}

Expanded _buildGameView(String icon, String name) {
  return Expanded(
    flex: 98,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          child: ClipRRect(
            child: HuoNetImage(
              imageUrl: icon ?? '',
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Text(
            name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppTheme.colors.textSubColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildImageTitleView(String icon, String title, {String text1}) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 10),
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

Widget _buildCouponView(TurnGiftState state, Dispatch dispatch,
    ViewService viewService, List<TurnCouponBean> list) {
  if (list.length == 1) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 6),
      child: _buildCouponItemView(state, dispatch, viewService, list[0]),
    );
  }

  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: list
        .map((value) =>
            _buildCouponItemView(state, dispatch, viewService, value))
        .toList(),
  );
}

Widget _buildCouponItemView(TurnGiftState state, Dispatch dispatch,
    ViewService viewService, TurnCouponBean bean) {
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
                    text: '¥',
                    style: TextStyle(color: Color(0xFFC4863D), fontSize: 11),
                  ),
                  TextSpan(
                    text: '${bean.detail.amount ?? 0}',
                    style: TextStyle(color: Color(0xFFC4863D), fontSize: 15),
                  ),
                ],
              )),
              Container(
                child: Text(
                  '满${bean.detail.condition ?? 0}元可用',
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
              '代\n金\n券',
              style: TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropView(TurnGiftState state, Dispatch dispatch,
    ViewService viewService, List<TurnPropBean> list) {
  if (list.length == 1) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 6),
      child: _buildPropItemView(state, dispatch, viewService, list[0]),
    );
  }

  return Wrap(
    spacing: 39,
    runSpacing: 10,
    children: list
        .map((value) => _buildPropItemView(state, dispatch, viewService, value))
        .toList(),
  );
}

Widget _buildPropItemView(TurnGiftState state, Dispatch dispatch,
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
