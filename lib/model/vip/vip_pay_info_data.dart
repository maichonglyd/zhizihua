import '../base_model.dart';

class VIPPayInfoData extends BaseModel<Data> {
  VIPPayInfoData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

//data.pay_type	STRING	支付类型	选择支付方式时 调用 防止重复下单
//data.real_amount	STRING	道具价格	6 00
//data.order_id	STRING	平台订单号	订单号
//data.status	Number	玩家支付状态	1 待支付 2 支付成功 3 支付失败
//data.cp_status	Number	通知游戏状态	1 待通知 2 通知成功 3 通知失败
//data.is_native	Number	是否跳转原生	2 跳转 其他 不跳转
//data.token	STRING	支付token
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
