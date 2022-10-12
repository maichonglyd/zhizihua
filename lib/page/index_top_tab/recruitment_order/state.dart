import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/index/recruitment_bean.dart';

class RecruitmentOrderState implements Cloneable<RecruitmentOrderState> {
  RecruitmentModel recruitmentModel;

  @override
  RecruitmentOrderState clone() {
    return RecruitmentOrderState()..recruitmentModel = recruitmentModel;
  }
}

RecruitmentOrderState initState(Map<String, dynamic> args) {
  return RecruitmentOrderState();
}
