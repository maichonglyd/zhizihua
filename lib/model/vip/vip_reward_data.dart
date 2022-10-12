import '../base_model.dart';

class RewardInfoData extends BaseModel<InfoData> {
  RewardInfoData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = InfoData.fromJson(jsonRes);
  }
}

class InfoData {
  String ptbCnt;
  InfoData({
    this.ptbCnt,
  });

  InfoData.fromJson(Map<String, dynamic> json) {
    ptbCnt = json['ptb_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ptb_cnt'] = this.ptbCnt;
    return data;
  }
}
