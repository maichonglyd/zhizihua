import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/reward_detail/page.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LotteryRewardState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textMyReward')),
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
      // actions: [
      //   GestureDetector(
      //     onTap: () {
      //       AppUtil.gotoPageByName(
      //           viewService.context, LotteryHistoryPage.pageName);
      //     },
      //     child: Container(
      //       alignment: Alignment.center,
      //       margin: EdgeInsets.only(right: 15),
      //       child: Text(
      //         '历史记录',
      //         style:
      //             TextStyle(color: AppTheme.colors.textSubColor, fontSize: 15),
      //       ),
      //     ),
      //   )
      // ],
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
          dispatch(LotteryRewardActionCreator.getData(1));
        },
        loadMore: (page) {
          dispatch(LotteryRewardActionCreator.getData(page));
        },
      ),
    ),
  );
}

Widget _buildItemView(LotteryRewardState state, Dispatch dispatch,
    ViewService viewService, LotteryMyRewardBean bean) {
  int type = 0;
  String typeText = '';
  String dateText = '';
  String titleText = '';
  String desText = '';
  if (null != bean.ptb) {
    type = LotteryMyRewardType.ptb;
    typeText = AppConfig.ptzName;
    dateText = '';
    titleText = getText(name: 'textCommonPtb');
    desText = '${bean.ptb.ptbCnt}${getText(name: 'textCommonPtb')}';
  } else if (null != bean.coupon) {
    type = LotteryMyRewardType.coupon;
    typeText = getText(name: 'textCoupon');
    dateText = '${AppUtil.formatDate18(bean.coupon.endTime)}${getText(name: 'textBeOverdue')}';
    titleText =
    '${bean.coupon.gameName.isNotEmpty ? getText(name: 'textBookName', args: [bean.coupon.gameName]) : ''}${getText(name: 'textCoupon')}';
    desText = '${bean.rewardName}';
  } else if (null != bean.gift) {
    type = LotteryMyRewardType.gift;
    typeText = getText(name: 'textGift');
    dateText = '${AppUtil.formatDate18(bean.gift.endTime)}${getText(name: 'textBeOverdue')}';
    titleText = getText(name: 'textVirtualGoods');
    desText = '${bean.rewardName}';
  } else if (null != bean.inKind) {
    type = LotteryMyRewardType.kind;
    typeText = getText(name: 'textGoods');
    dateText = getLotteryMyRewardKindStatusText(bean.inKind.shippingStatus);
    titleText = getText(name: 'textRealGoods');
    desText = '${bean.rewardName}';
  }

  return Container(
    width: double.infinity,
    height: 129,
    child: Stack(
      children: [
        Container(
          height: 119,
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/pic_lottery_coupon_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 31,
                child: Row(
                  children: [
                    Text(
                      typeText,
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor2, fontSize: 12),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      dateText,
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor2, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.colors.bgColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: HuoNetImage(
                        imageUrl: bean.rewardIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleText,
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor,
                                fontSize: 13),
                          ),
                          Text(
                            desText,
                            style: TextStyle(
                                color: AppTheme.colors.textColor,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    _buildMyRewardItemButtonView(
                        state, dispatch, viewService, bean, type),
                  ],
                ),
              )
            ],
          ),
        ),
        if (LotteryMyRewardType.coupon == type && 2 == bean.coupon.isUsed)
          Positioned(
            right: 8,
            top: 0,
            child: Image.asset(
              'images/pic_coupon_has_use.png',
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
      ],
    ),
  );
}

Widget _buildMyRewardItemButtonView(
  LotteryRewardState state,
  Dispatch dispatch,
  ViewService viewService,
  LotteryMyRewardBean bean,
  int type,
) {
  if (LotteryMyRewardType.kind == type && bean.inKind.consignee.isEmpty) {
    return GestureDetector(
      onTap: () {
        dispatch(LotteryRewardActionCreator.showAddressDialog(bean.orderId));
      },
      child: Container(
        width: 57,
        height: 24,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: AppTheme.colors.themeColor,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          getText(name: 'textEditInformation'),
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }

  return GestureDetector(
    onTap: () {
      if (LotteryMyRewardType.coupon == type) {
        AppUtil.gotoPageByName(viewService.context, MineCouponPage.pageName);
      } else if (LotteryMyRewardType.ptb == type) {
        AppUtil.gotoPageByName(viewService.context, MyWalletPage.pageName);
      } else {
        AppUtil.gotoPageByName(viewService.context, RewardDetailPage.pageName,
            arguments: {'orderId': bean.orderId});
      }
    },
    child: Container(
      width: 57,
      height: 24,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: AppTheme.colors.lineColor,
          borderRadius: BorderRadius.circular(12)),
      child: Text(
        getText(name: 'textLook'),
        style: TextStyle(color: AppTheme.colors.textColor, fontSize: 11),
      ),
    ),
  );
}
