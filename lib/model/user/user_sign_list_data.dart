import '../base_model.dart';

class UserSignListData extends BaseModel<Data> {
  UserSignListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int signDays;
  int lastSignTime;
  int count;
  List<Sign> list;

  Data({this.signDays, this.lastSignTime, this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    signDays = json['sign_days'];
    lastSignTime = json['last_sign_time'];
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Sign>();
      json['list'].forEach((v) {
        list.add(new Sign.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sign_days'] = this.signDays;
    data['last_sign_time'] = this.lastSignTime;
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sign {
  int signDays;
  int id;
  int integral;
  String icon;
  String name;
  String desc;

  Sign(
      {this.signDays, this.id, this.integral, this.icon, this.name, this.desc});

  Sign.fromJson(Map<String, dynamic> json) {
    signDays = json['sign_days'];
    id = json['id'];
    integral = json['integral'];
    icon = json['icon'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sign_days'] = this.signDays;
    data['id'] = this.id;
    data['integral'] = this.integral;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}
