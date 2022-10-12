import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/lottery_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/reward_detail/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_recharge/page.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryAddressDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryBuyChanceDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/LotteryRewardDialog.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Effect<LotteryActivityState> buildEffect() {
  return combineEffects(<Object, Effect<LotteryActivityState>>{
    Lifecycle.initState: _init,
    LotteryActivityAction.action: _onAction,
    LotteryActivityAction.buyLotteryChance: _buyLotteryChance,
    LotteryActivityAction.showRechargeDialog: _showRechargeDialog,
    LotteryActivityAction.getSelectReward: _getSelectReward,
    LotteryActivityAction.showRewardDialog: _showRewardDialog,
    LotteryActivityAction.showAddressDialog: _showAddressDialog,
    LotteryActivityAction.getData: _getData,
    LotteryActivityAction.buyChance: _buyChance,
    LotteryActivityAction.gotoInvitePage: _gotoInvitePage,
  });
}

void _onAction(Action action, Context<LotteryActivityState> ctx) {}

void _init(Action action, Context<LotteryActivityState> ctx) {
  ctx.dispatch(LotteryActivityActionCreator.getData());
}

void _getData(Action action, Context<LotteryActivityState> ctx) {
  LotteryService.getLotteryInfo().then((data) {
    if (200 == data.code) {
      LotteryService.getRewardList(1, data.data.lotteryId).then((data) {
        if (200 == data.code) {
          ctx.dispatch(
              LotteryActivityActionCreator.updateRewardList(data.data.list));
        }
      });
      ctx.dispatch(LotteryActivityActionCreator.updateInfo(data));
    }
  });

  LotteryService.getMyRewardList(1).then((data) {
    if (200 == data.code) {
      ctx.dispatch(LotteryActivityActionCreator.updateMyReward(data.data.list));
    }
  });
}

void _buyLotteryChance(Action action, Context<LotteryActivityState> ctx) {
  num number = action.payload['num'];
  String text = action.payload['text'];
  showDialog<Null>(
    context: ctx.context,
    barrierDismissible: false,
    builder: (context) {
      return LotteryBuyChanceDialog(
        num: number,
        text: text,
        submitCallback: (num) {
          ctx.dispatch(LotteryActivityActionCreator.buyChance(num));
        },
      );
    },
  );
}

void _showRechargeDialog(Action action, Context<LotteryActivityState> ctx) {
  showDialog<Null>(
    context: ctx.context,
    barrierDismissible: false,
    builder: (context) {
      return LotteryBuyChanceDialog(
        num: -1,
        text: getText(name: 'textNoPtbToRecharge'),
        submitCallback: (num) {
          AppUtil.gotoPageByName(ctx.context, PtzRechargePage.pageName);
        },
      );
    },
  );
}

void _getSelectReward(Action action, Context<LotteryActivityState> ctx) {
  // 正在抽奖中，不重复请求接口
  if (ctx.state.startLottery) return;

  if (0 >= ctx.state.info.data.drawableCnt) {
    showToast(getText(name: 'textDrawCardChangeHasDone'));
    return;
  }

  LotteryService.startLottery(ctx.state.info.data.lotteryId).then((data) {
    if (200 == data.code) {
      int index = -1;
      for (int i = 0; i < ctx.state.rewardList.length; i++) {
        if (data.data.rewardId == ctx.state.rewardList[i].id) {
          index = i;
          ctx.state.userReward = data.data;
        }
      }
      if (-1 != index) {
        ctx.state.controller.selectIndex = index;
        ctx.state.controller.start();
        ctx.state.startLottery = true;
      }
    }
  });
}

void _showRewardDialog(Action action, Context<LotteryActivityState> ctx) {
  if (null == ctx.state.userReward) return;

  showDialog<Null>(
    context: ctx.context,
    barrierDismissible: false,
    builder: (context) {
      return LotteryRewardDialog(
        reward: ctx.state.userReward,
        submitCallback: (reward) {
          int type = getLotteryRewardType(reward);
          if (LotteryMyRewardType.kind == type) {
            ctx.dispatch(
                LotteryActivityActionCreator.showAddressDialog(reward.orderId));
          } else if (LotteryMyRewardType.coupon == type) {
            AppUtil.gotoPageByName(ctx.context, MineCouponPage.pageName);
          } else if (LotteryMyRewardType.gift == type) {
            AppUtil.gotoPageByName(ctx.context, RewardDetailPage.pageName,
                arguments: {'orderId': reward.orderId});
          } else if (LotteryMyRewardType.ptb == type) {
            AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName);
          }
        },
      );
    },
  );
}

void _showAddressDialog(Action action, Context<LotteryActivityState> ctx) {
  String orderId = action.payload;
  showDialog<Null>(
    context: ctx.context,
    barrierDismissible: false,
    builder: (context) {
      return LotteryAddressDialog(
        submitCallback: (name, address, phone) {
          LotteryService.createAddress(orderId, name, address, phone)
              .then((data) {
            if (200 == data.code) {
              LotteryService.getMyRewardList(1).then((data) {
                if (200 == data.code) {
                  ctx.dispatch(LotteryActivityActionCreator.updateMyReward(
                      data.data.list));
                }
              });
            }
          });
        },
      );
    },
  );
}

void _buyChance(Action action, Context<LotteryActivityState> ctx) {
  num number = action.payload;
  LotteryService.bugRechargeOpportunity(number, ctx.state.info.data.lotteryId).then((data) {
    if (200 == data.code) {
      showToast(getText(name: 'textBuyDrawCardSuccessful'));
      ctx.dispatch(LotteryActivityActionCreator.getData());
    } else {
      ctx.dispatch(LotteryActivityActionCreator.showRechargeDialog());
    }
  });
}

void _gotoInvitePage(Action action, Context<LotteryActivityState> ctx) {
  if (null != ctx.state.info && null != ctx.state.info.data.lotteryId) {
    AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: {
      'shareType': 'lottery',
      'lotteryId': ctx.state.info.data.lotteryId,
    }).then((data) {
      ctx.dispatch(LotteryActivityActionCreator.getData());
    });
  }
}
