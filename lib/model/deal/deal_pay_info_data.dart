import '../base_model.dart';

class DealPayInfoData extends BaseModel<Data> {
  DealPayInfoData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String payType;
  String orderId;
  String productPrice;
  dynamic realAmount;
  String token;
  int isNative;
  int status;
  int cpStatus;

  Data(
      {this.payType,
      this.orderId,
      this.productPrice,
      this.realAmount,
      this.token,
      this.isNative,
      this.status,
      this.cpStatus});

  Data.fromJson(Map<String, dynamic> json) {
    payType = json['pay_type'];
    orderId = json['order_id'];
    productPrice = json['product_price'];
    realAmount = json['real_amount'];
    token = json['token'];
    isNative = json['is_native'];
    status = json['status'];
    cpStatus = json['cp_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_type'] = this.payType;
    data['order_id'] = this.orderId;
    data['product_price'] = this.productPrice;
    data['real_amount'] = this.realAmount;
    data['token'] = this.token;
    data['is_native'] = this.isNative;
    data['status'] = this.status;
    data['cp_status'] = this.cpStatus;
    return data;
  }
}
