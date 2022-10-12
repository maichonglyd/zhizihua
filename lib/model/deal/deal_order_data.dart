import '../base_model.dart';

class DealOrderData extends BaseModel<Data> {
  DealOrderData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String orderId;
  double realAmount;
  int status;
  String payToken;

  Data({this.orderId, this.realAmount, this.status, this.payToken});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    realAmount = double.parse(json['real_amount'].toString());
    status = json['status'];
    payToken = json['pay_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['real_amount'] = this.realAmount;
    data['status'] = this.status;
    data['pay_token'] = this.payToken;
    return data;
  }
}
