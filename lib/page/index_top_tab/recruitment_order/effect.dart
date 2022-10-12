import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/recruitment_service.dart';
import 'package:flutter_huoshu_app/widget/dialog/RecruitServiceDialog.dart';

import 'action.dart';
import 'state.dart';

Effect<RecruitmentOrderState> buildEffect() {
  return combineEffects(<Object, Effect<RecruitmentOrderState>>{
    Lifecycle.initState: _init,
    RecruitmentOrderAction.action: _onAction,
    RecruitmentOrderAction.showServiceDialog: _showServiceDialog,
    RecruitmentOrderAction.getData: _getData,
  });
}

void _onAction(Action action, Context<RecruitmentOrderState> ctx) {}

void _init(Action action, Context<RecruitmentOrderState> ctx) {
  ctx.dispatch(RecruitmentOrderActionCreator.getData());
}

void _getData(Action action, Context<RecruitmentOrderState> ctx) {
  RecruitmentService.getRecruitmentRank().then((data) {
    if (200 == data.code) {
      ctx.dispatch(RecruitmentOrderActionCreator.updateData(data));
    }
  });
}

void _showServiceDialog(Action action, Context<RecruitmentOrderState> ctx) {
  if (null == ctx.state.recruitmentModel) return;
  showDialog<Null>(
      context: ctx.context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return RecruitServiceDialog(
              phone: ctx.state.recruitmentModel.data.gsPhone,
              qq: ctx.state.recruitmentModel.data.gsQq,
              weChat: ctx.state.recruitmentModel.data.gsWeChat,
            );
          },
        );
      });
}
