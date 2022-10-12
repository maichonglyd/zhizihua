import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/recruitment_bean.dart';

//TODO replace with your own action
enum RecruitmentOrderAction {
  action,
  showServiceDialog,
  getData,
  updateData,
}

class RecruitmentOrderActionCreator {
  static Action onAction() {
    return const Action(RecruitmentOrderAction.action);
  }

  static Action getData() {
    return const Action(RecruitmentOrderAction.getData);
  }

  static Action updateData(RecruitmentModel model) {
    return Action(RecruitmentOrderAction.updateData, payload: model);
  }

  static Action showServiceDialog() {
    return const Action(RecruitmentOrderAction.showServiceDialog);
  }
}
