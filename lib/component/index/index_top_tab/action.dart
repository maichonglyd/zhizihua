import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';

//TODO replace with your own action
enum IndexTopTabComponentAction {
  action,
  gotoInvite,
  gotoRebate,
  gotoGameClassify,
  gotoGameRank,
  gotoRecycle,
  gotoVipRebate,
  gotoTaskCenter,
  gotoGameReserve,
  gotoDealPage,
  gotoActivityNews,
  gotoCouponCenter,
  gotoRecruitOrder,
  gotoTurnGame,
  gotoSpecialGame,
  gotoLotteryActivity,
}

class IndexTopTabComponentActionCreator {
  static Action onAction() {
    return const Action(IndexTopTabComponentAction.action);
  }
  static Action gotoInvite() {
    return const Action(IndexTopTabComponentAction.gotoInvite);
  }
  static Action gotoRebate() {
    return const Action(IndexTopTabComponentAction.gotoRebate);
  }

  static Action gotoGameClassify() {
    return const Action(IndexTopTabComponentAction.gotoGameClassify);
  }


  static Action gotoGameRank() {
    return const Action(IndexTopTabComponentAction.gotoGameRank);
  }

  static Action gotoRecycle() {
    return Action(IndexTopTabComponentAction.gotoRecycle);
  }

  static Action gotoVipRebate() {
    return const Action(IndexTopTabComponentAction.gotoVipRebate);
  }

  static Action gotoTaskCenter() {
    return const Action(IndexTopTabComponentAction.gotoTaskCenter);
  }

  static Action gotoGameReserve() {
    return const Action(IndexTopTabComponentAction.gotoGameReserve);
  }

  static Action gotoDealPage() {
    return const Action(IndexTopTabComponentAction.gotoDealPage);
  }

  static Action gotoActivityNews(){
    return const Action(IndexTopTabComponentAction.gotoActivityNews);
  }

  static Action gotoCouponCenter(){
    return const Action(IndexTopTabComponentAction.gotoCouponCenter);
  }

  static Action gotoRecruitOrder(){
    return const Action(IndexTopTabComponentAction.gotoRecruitOrder);
  }

  static Action gotoTurnGame(){
    return const Action(IndexTopTabComponentAction.gotoTurnGame);
  }

  static Action gotoSpecialGame(IndexTopTabBean bean){
    return Action(IndexTopTabComponentAction.gotoSpecialGame, payload: bean);
  }

  static Action gotoLotteryActivity(){
    return const Action(IndexTopTabComponentAction.gotoLotteryActivity);
  }
}
