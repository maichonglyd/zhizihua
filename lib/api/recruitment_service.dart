import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/index/recruitment_bean.dart';

class RecruitmentService {
  static Future<RecruitmentModel> getRecruitmentRank() async {
    dynamic response = await CommonDio.post("v9155/recruitment/info");
    return RecruitmentModel.fromJson(response);
  }
}
