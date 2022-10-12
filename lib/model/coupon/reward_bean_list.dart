import '../base_model.dart';

class RewardList extends BaseModel<Data> {
  RewardList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Reward> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Reward>();
      json['list'].forEach((v) {
        list.add(new Reward.fromJson(v));
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

//data.count  Number  数量  26
//data.list  Array  数据列表
//data.list.id  String  ID
//data.list.title  String  代金券
//data.list.money  String  金额
//data.list.condition  String  条件说明
//data.list.content  String  说明  .
class Reward {
  num money;
  int id;
  String condition;
  String content;
  String title;

  Reward({this.money, this.condition, this.content, this.id, this.title});

  Reward.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    id = json['id,'];
    title = json['title'];
    content = json['content'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
