import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

//TODO replace with your own action
enum GameCoinRechargeAction {
  action,
  gotoSelectGame,
  gotoRecord,
  pay,
  changePayType,
  updateAmount,
  changeGame,
  updateGame,
  gotoFeedback,
  gotoRechargeInfo,
  selectPic,
  deletePic,
  addPic,
  updateRate,
}

class GameCoinRechargeActionCreator {
  static Action onAction() {
    return const Action(GameCoinRechargeAction.action);
  }

  static Action changeGame() {
    return const Action(GameCoinRechargeAction.changeGame);
  }

  static Action updateGame(Game game) {
    return Action(GameCoinRechargeAction.updateGame, payload: game);
  }

  static Action selectPic() {
    return const Action(GameCoinRechargeAction.selectPic);
  }

  static Action addPic(File newFile) {
    return Action(GameCoinRechargeAction.addPic, payload: newFile);
  }

  static Action deletePic(int index) {
    return Action(GameCoinRechargeAction.deletePic, payload: index);
  }

  static Action updateAmount(int amount) {
    return Action(GameCoinRechargeAction.updateAmount, payload: amount);
  }

  static Action changePayType(int payType) {
    return Action(GameCoinRechargeAction.changePayType, payload: payType);
  }

  static Action pay() {
    return const Action(GameCoinRechargeAction.pay);
  }

  static Action gotoSelectGame() {
    return const Action(GameCoinRechargeAction.gotoSelectGame);
  }

  static Action gotoRecord() {
    return const Action(GameCoinRechargeAction.gotoRecord);
  }

  static Action gotoFeedback() {
    return const Action(GameCoinRechargeAction.gotoFeedback);
  }

  static Action gotoRechargeInfo() {
    return const Action(GameCoinRechargeAction.gotoRechargeInfo);
  }

  static Action updateRate(num rate) {
    return Action(GameCoinRechargeAction.updateRate, payload: rate);
  }
}
