import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];

  if (null != state.reward) {
    widgetList.add(_buildGoodsView(state, dispatch, viewService));
    int type = 0;
    if (null != state.reward.ptb) {
      type = LotteryMyRewardType.ptb;
      Navigator.pop(viewService.context);
    } else if (null != state.reward.coupon) {
      type = LotteryMyRewardType.coupon;
      Navigator.pop(viewService.context);
    } else if (null != state.reward.gift) {
      type = LotteryMyRewardType.gift;
      widgetList.add(_buildGiftInfo(state, dispatch, viewService));
    } else if (null != state.reward.inKind) {
      type = LotteryMyRewardType.kind;
      widgetList.add(_buildOrderInfo(state, dispatch, viewService));
      widgetList.add(_buildAddressInfo(state, dispatch, viewService));
    }
  }

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textOrderDetail')),
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
          children: widgetList,
        ),
        controller: state.refreshHelperController,
        onRefresh: () {
          dispatch(RewardDetailActionCreator.getData());
        },
      ),
    ),
  );
}

Widget _buildGoodsView(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
    padding: EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          color: AppTheme.colors.bgColor,
          child: HuoNetImage(
            imageUrl: state.reward.rewardIcon ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.reward.rewardName ?? '',
                style:
                    TextStyle(color: AppTheme.colors.textColor, fontSize: 17),
              ),
              Text(
                '${getText(name: 'textGong')}1${getText(name: 'textNumberGoods')}',
                style: TextStyle(
                    color: AppTheme.colors.textSubColor2, fontSize: 12),
              ),
            ],
          ),
        ),
        Text(
          LotteryMyRewardType.kind != getLotteryRewardType(state.reward) ? getText(name: 'textHasDelivered') : getLotteryMyRewardKindStatusText(state.reward.inKind.shippingStatus),
          style: TextStyle(color: Color(0xFFFF8500), fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildOrderInfo(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    padding: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 13, left: 15),
          child: Text(
            getText(name: 'textOrderInfo'),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 13, bottom: 10),
          height: 1,
          color: AppTheme.colors.bgColor,
        ),
        _buildOrderItemInfo(getText(name: 'textOrderNumberColon'), state.reward.orderId),
        _buildOrderItemInfo(
            getText(name: 'textOrderTime'), AppUtil.formatDate18(state.reward.createTime)),
        _buildOrderItemInfo(getText(name: 'textConsigneeName'), state.reward.inKind.consignee),
        _buildOrderItemInfo(getText(name: 'textMobilePhoneColon'), state.reward.inKind.mobile),
        _buildOrderItemInfo(getText(name: 'textShoppingAddress'), state.reward.inKind.fullAddress),
      ],
    ),
  );
}

Widget _buildAddressInfo(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  widgetList.add(Container(
    padding: EdgeInsets.only(left: 15, top: 13),
    child: Text(
      getText(name: 'textViewLogistics'),
      style: TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
    ),
  ));
  widgetList.add(Container(
    margin: EdgeInsets.only(top: 13, bottom: 10),
    height: 1,
    color: AppTheme.colors.bgColor,
  ));
  if (null == state.reward.inKind.invoiceNo ||
      state.reward.inKind.invoiceNo.isEmpty) {
    widgetList.add(_buildNoShippingInfo());
  } else {
    widgetList
        .add(_buildOrderItemInfo(getText(name: 'textExpressType'), state.reward.inKind.shippingName));
    widgetList.add(_buildOrderItemInfo(getText(name: 'textLogistics'), state.reward.inKind.invoiceNo));
  }
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    padding: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList,
    ),
  );
}

Widget _buildNoShippingInfo() {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 20, bottom: 15),
    child: Text(
      getText(name: 'textNoLogisticsInformation'),
      style: TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 12),
    ),
  );
}

Widget _buildGiftInfo(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
    padding: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, top: 13),
          child: Text(
            getText(name: 'textOrderInfo'),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 13, bottom: 10),
          height: 1,
          color: AppTheme.colors.bgColor,
        ),
        _buildOrderItemInfo(getText(name: 'textOrderNumberColon'), state.reward.orderId),
        _buildOrderItemInfo(
            getText(name: 'textOrderTime'), AppUtil.formatDate18(state.reward.createTime)),
        _buildRechargeCodeView(state, dispatch, viewService),
      ],
    ),
  );
}

Widget _buildRechargeCodeView(
    RewardDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 15, right: 15, top: 28),
    padding: EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: AppTheme.colors.bgColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getText(name: 'textExchangeCode'),
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 12),
        ),
        Text(
          state.reward.gift.content,
          style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
        ),
        Text(
          '${getText(name: 'textDeadlineTimeColon')}${AppUtil.formatDate18(state.reward.gift.endTime)}',
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 12),
        ),
      ],
    ),
  );
}

Widget _buildOrderItemInfo(String title, String des) {
  return Container(
    height: 26,
    margin: EdgeInsets.only(left: 15, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? '',
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 12),
        ),
        Text(
          des ?? '',
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 12),
        ),
      ],
    ),
  );
}
