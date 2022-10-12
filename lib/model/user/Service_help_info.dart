import '../base_model.dart';

class ServiceInfo extends BaseModel<Data> {
  ServiceInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  List<String> qq;
  List<String> qqgroup;
  String wx;
  String tel;
  String serviceTime;
  String weibo;
  String officesite;
  Faqs faq;

  Data(
      {this.qq,
      this.qqgroup,
      this.wx,
      this.tel,
      this.serviceTime,
      this.weibo,
      this.officesite,
      this.faq});

  Data.fromJson(Map<String, dynamic> json) {
    qq = json['qq'] != null ? json['qq'].cast<String>() : null;
    qqgroup = json['qqgroup'] != null ? json['qqgroup'].cast<String>() : null;
    wx = json['wx'];
    tel = json['tel'];
    serviceTime = json['service_time'];
    weibo = json['weibo'];
    officesite = json['officesite'];
    faq = json['faq'] != null ? new Faqs.fromJson(json['faq']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qq'] = this.qq;
    data['qqgroup'] = qqgroup;
    data['wx'] = this.wx;
    data['tel'] = this.tel;
    data['service_time'] = this.serviceTime;
    data['weibo'] = this.weibo;
    data['officesite'] = this.officesite;
    if (this.faq != null) {
      data['faq'] = this.faq.toJson();
    }
    return data;
  }
}

class Faqs {
  int count;
  List<Faq> list;

  Faqs({this.count, this.list});

  Faqs.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Faq>();
      json['list'].forEach((v) {
        list.add(new Faq.fromJson(v));
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

class Faq {
  int id;
  String title;
  String answer;

  Faq({this.id, this.title, this.answer});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['answer'] = this.answer;
    return data;
  }
}
