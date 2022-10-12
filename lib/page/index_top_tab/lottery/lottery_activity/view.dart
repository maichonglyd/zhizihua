import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_activity_info.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/lottery_reward/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/reward_detail/page.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/widget/LotteryMachineView.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textLuckyDraw')),
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
    body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: _buildContentView(state, dispatch, viewService),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: _buildNotificationView(state, dispatch, viewService),
        ),
      ],
    ),
  );
}

Widget _buildNotificationView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 32,
    color: Color(0xFFBF67FC),
    child: Row(
      children: [
        Container(
          width: 14,
          height: 14,
          margin: EdgeInsets.only(left: 15, right: 8),
          child: Image.asset(
            'images/icon_horn_white.png',
            fit: BoxFit.fill,
          ),
        ),
        if (null != state.info &&
            null != state.info.data.topMsg &&
            state.info.data.topMsg.length > 0)
          Expanded(
            child: FlutterMarquee(
              onChange: (index) {},
              onRoll: (index) {},
              animationDirection: AnimationDirection.t2b,
              duration: 5,
              children: state.info.data.topMsg
                  .map((value) => Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ))
                  .toList(),
            ),
          )
      ],
    ),
  );
}

Widget _buildContentView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 1526,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/pic_lottery_bg.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 661,
          child: _buildRuleView(state, dispatch, viewService),
        ),
        Positioned(
          top: 179,
          child: null == state.rewardList || state.rewardList.length <= 0
              ? SizedBox()
              : LotteryMachineView(
                  controller: state.controller,
                  list: state.rewardList,
                  chance: null != state.info ? state.info.data.drawableCnt : 0,
                  clickStart: () {
                    dispatch(LotteryActivityActionCreator.getSelectReward());
                  },
                  finishCallback: () {
                    state.startLottery = false;
                    dispatch(LotteryActivityActionCreator.showRewardDialog());
                    dispatch(LotteryActivityActionCreator.getData());
                  },
                ),
        ),
        _buildLotteryView(state, dispatch, viewService),
        Positioned(
          top: 915,
          child: _buildCloudView(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildMyRewardView(state, dispatch, viewService),
        ),
      ],
    ),
  );
}

Widget _buildLotteryView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Column(
      children: [
        _buildShareView(state, dispatch, viewService),
        _buildRechargeView(state, dispatch, viewService),
      ],
    ),
  );
}

Widget _buildShareView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      dispatch(LotteryActivityActionCreator.gotoInvitePage());
    },
    child: Container(
      height: 27,
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(left: 256, top: 44, bottom: 104),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(14)),
      ),
      child: Container(
        width: 103,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(13)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFFF3FE6),
                Color(0xFFFFD762),
              ]),
        ),
        child: Text(
          getText(name: 'textShareToGetCard'),
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    ),
  );
}

Widget _buildRechargeView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  if (null != state.info && null != state.info.data.opportunityList) {
    widgetList.addAll(state.info.data.opportunityList
        .map((value) =>
            _buildRechargeItemView(state, dispatch, viewService, value))
        .toList());
  }
  return Container(
    margin: EdgeInsets.only(left: 45, right: 45),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgetList,
    ),
  );
}

Widget _buildRechargeItemView(LotteryActivityState state, Dispatch dispatch,
    ViewService viewService, LotteryOpportunityBean bean) {
  return GestureDetector(
    onTap: () {
      dispatch(LotteryActivityActionCreator.buyLotteryChance(bean.cnt ?? 0,
          '${getText(name: 'textBuyDrawCardConsume', args: [bean.cnt, 0 >= bean.giftCnt ? '' : getText(name: 'textDrawCardToGive'), bean.ptbCnt])}${AppConfig.ptzName}'));
    },
    child: Container(
      width: 125,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage('images/pic_lottery_recharge_right.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(
        getText(name: 'textBuyDrawCard', args: [bean.cnt ?? 0]),
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
    ),
  );
}

Widget _buildRuleView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  String rule = '';
  if (null != state.info && null != state.info.data.rule) {
    for (String text in state.info.data.rule) {
      rule += text + '\n';
    }
  }
  return Container(
    width: 360,
    height: 302,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/pic_lottery_role_bg.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 74, bottom: 17),
          child: Text(
            getText(name: 'textActivityRule'),
            style: TextStyle(color: Color(0xFF1300FF), fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 30, right: 20),
          child: Text(
            rule,
            style: TextStyle(color: Color(0xFF1300FF), fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCloudView() {
  return Container(
    height: 155,
    child: Image.asset(
      'images/pic_lottery_cloud.png',
      fit: BoxFit.fill,
    ),
  );
}

Widget _buildMyRewardView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  if (null != state.myRewardList) {
    for (int i = 0; i < state.myRewardList.length; i++) {
      if (i < 3) {
        widgetList.add(_buildRewardItemView(
            state, dispatch, viewService, state.myRewardList[i]));
      } else {
        break;
      }
    }
  }
  return Container(
    width: double.infinity,
    height: 530,
    margin: EdgeInsets.only(bottom: 26),
    padding: EdgeInsets.only(top: 94),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/pic_lottery_reward.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgetList,
          ),
        ),
        _buildMoreView(state, dispatch, viewService),
      ],
    ),
  );
}

Widget _buildRewardItemView(LotteryActivityState state, Dispatch dispatch,
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
    width: 300,
    height: 108,
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.only(left: 14, right: 14),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/pic_lottery_coupon_bg.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      children: [
        Container(
          height: 28,
          child: Row(
            children: [
              Text(
                typeText,
                style: TextStyle(
                    color: AppTheme.colors.textSubColor2, fontSize: 11),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Text(
                dateText,
                style: TextStyle(
                    color: AppTheme.colors.textSubColor2, fontSize: 11),
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
                width: 55,
                height: 55,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppTheme.colors.bgColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: HuoNetImage(
                  imageUrl: bean.rewardIcon ?? '',
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
                          color: AppTheme.colors.textSubColor, fontSize: 12),
                    ),
                    Text(
                      desText,
                      style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: 20,
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
  );
}

Widget _buildMyRewardItemButtonView(
  LotteryActivityState state,
  Dispatch dispatch,
  ViewService viewService,
  LotteryMyRewardBean bean,
  int type,
) {
  if (LotteryMyRewardType.kind == type && bean.inKind.consignee.isEmpty) {
    return GestureDetector(
      onTap: () {
        dispatch(LotteryActivityActionCreator.showAddressDialog(bean.orderId));
      },
      child: Container(
        width: 57,
        height: 24,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: AppTheme.colors.themeColor,
            borderRadius: BorderRadius.circular(10)),
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

Widget _buildMoreView(
    LotteryActivityState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      AppUtil.gotoPageByName(viewService.context, LotteryRewardPage.pageName);
    },
    child: Container(
      height: 56,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20),
      child: Text(
        '${getText(name: 'textLookMore')}>',
        style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 15),
      ),
    ),
  );
}
