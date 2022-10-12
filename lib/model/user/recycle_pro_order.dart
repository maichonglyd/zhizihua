import '../base_model.dart';

class RecycleProOrder extends BaseModel<Data> {
  RecycleProOrder.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String orderId;
  double amount;
  double ptbRemain;
  List<PayWay> payWay;

  Data({this.orderId, this.amount, this.ptbRemain, this.payWay});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    amount = double.parse(json['amount'].toString());
    ptbRemain = double.parse(json['ptb_remain'].toString());
    if (json['payway'] != null) {
      payWay = new List<PayWay>();
      json['payway'].forEach((v) {
        payWay.add(new PayWay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['ptb_remain'] = this.ptbRemain;
    if (this.payWay != null) {
      data['payway'] = this.payWay.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayWay {
  String payWay;
  String name;
  String icon;
  String url;

  PayWay({this.payWay, this.name, this.icon, this.url});

  PayWay.fromJson(Map<String, dynamic> json) {
    payWay = json['payway'];
    name = json['name'];
    icon = json['icon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payway'] = this.payWay;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['url'] = this.url;
    return data;
  }
}
