import '../base_model.dart';

class ShareInfo extends BaseModel<Data> {
  ShareInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String shareId;
  String title;
  String content;
  String icon;
  String url;
  String rule;
  int memCnt;
  int shareTotal;

  Data(
      {this.shareId,
      this.title,
      this.content,
      this.icon,
      this.url,
      this.rule,
      this.memCnt,
      this.shareTotal});

  Data.fromJson(Map<String, dynamic> json) {
    shareId = json['share_id'].toString();
    title = json['title'];
    content = json['content'];
    icon = json['icon'];
    url = json['url'];
    rule = json['rule'];
    memCnt = json['mem_cnt'];
    shareTotal = json['share_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['share_id'] = this.shareId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['rule'] = this.rule;
    data['mem_cnt'] = this.memCnt;
    data['share_total'] = this.shareTotal;
    return data;
  }
}
