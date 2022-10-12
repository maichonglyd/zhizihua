import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';

//TODO replace with your own action
enum AccountManageAction {
  action,
  getUserInfo,
  updateUserInfo,
  gotoUpdatePw,
  gotoUpdateMobile,
  updateNickname,
  selectPic,
  updateAvatar,
  gotoIdentify,
  gotoWebView
}

class AccountManageActionCreator {
  static Action onAction() {
    return const Action(AccountManageAction.action);
  }

  static Action gotoWebView(int type) {
    return Action(AccountManageAction.gotoWebView, payload: type);
  }

  static Action getUserInfo() {
    return const Action(AccountManageAction.getUserInfo);
  }

  static Action gotoIdentify() {
    return const Action(AccountManageAction.gotoIdentify);
  }

  static Action updateUserInfo(UserInfo userInfo) {
    return Action(AccountManageAction.updateUserInfo, payload: userInfo);
  }

  static Action gotoUpdatePw() {
    return Action(AccountManageAction.gotoUpdatePw);
  }

  static Action gotoUpdateMobile(int isBind) {
    return Action(AccountManageAction.gotoUpdateMobile, payload: isBind);
  }

  static Action updateNickname() {
    return Action(AccountManageAction.updateNickname);
  }

  static Action selectPic() {
    return Action(AccountManageAction.selectPic);
  }

  static Action updateAvatar(String url) {
    return Action(AccountManageAction.updateAvatar, payload: url);
  }
}
