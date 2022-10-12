import '../base_model.dart';

class RecycleExplain extends BaseModel<Data> {
  RecycleExplain.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String content;
  int expireTime;
  int recycleCnt;
  String ptbCnt;

  Data({this.content, this.expireTime, this.recycleCnt, this.ptbCnt});

  Data.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    expireTime = json['expire_time'];
    recycleCnt = json['recycle_cnt'];
    ptbCnt = json['ptb_cnt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['expire_time'] = this.expireTime;
    data['recycle_cnt'] = this.recycleCnt;
    data['ptb_cnt'] = this.ptbCnt;
    return data;
  }
}
