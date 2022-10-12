import '../base_model.dart';

class GoldRecord extends BaseModel<Data> {
  GoldRecord.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<DataList> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<DataList>();
      json['list'].forEach((v) {
        list.add(new DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  String iaName;
  num integral;
  num changeIntegral;
  int createTime;
  int itgType;

  DataList(
      {this.iaName,
      this.integral,
      this.changeIntegral,
      this.createTime,
      this.itgType});

  DataList.fromJson(Map<String, dynamic> json) {
    iaName = json['ia_name'];
    integral = json['integral'];
    changeIntegral = json['change_integral'];
    createTime = json['create_time'];
    itgType = json['itg_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ia_name'] = this.iaName;
    data['integral'] = this.integral;
    data['change_integral'] = this.changeIntegral;
    data['create_time'] = this.createTime;
    data['itg_type'] = this.itgType;
    return data;
  }
}
