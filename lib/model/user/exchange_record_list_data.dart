import '../base_model.dart';

class ExchangeRecordListData extends BaseModel<Data> {
  ExchangeRecordListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<ExchangeBean> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<ExchangeBean>();
      json['list'].forEach((v) {
        list.add(new ExchangeBean.fromJson(v));
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

class ExchangeBean {
  String address;
  // List<String> adminNote;
  String code;
  int confirmTime;
  int createTime;
  int flag;
  int goodsId;
  String goodsName;
  String goodsType;
  int id;
  int integral;
  String invoiceNo;
  int memId;
  String mobile;
  String nickname;
  int num;
  String orderId;
  String originalImg;
  String regMobile;
  String shippingName;
  int shippingStatus;
  int status;
  String username;

  ExchangeBean(
      {this.address,
      //  this.adminNote,
      this.code,
      this.confirmTime,
      this.createTime,
      this.flag,
      this.goodsId,
      this.goodsName,
      this.goodsType,
      this.id,
      this.integral,
      this.invoiceNo,
      this.memId,
      this.mobile,
      this.nickname,
      this.num,
      this.orderId,
      this.originalImg,
      this.regMobile,
      this.shippingName,
      this.shippingStatus,
      this.status,
      this.username});

  ExchangeBean.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    //  adminNote = json['admin_note'].cast<String>();
    code = json['code'];
    confirmTime = json['confirm_time'];
    createTime = json['create_time'];
    flag = json['flag'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    goodsType = json['goods_type'];
    id = json['id'];
    integral = json['integral'];
    invoiceNo = json['invoice_no'];
    memId = json['mem_id'];
    mobile = json['mobile'];
    nickname = json['nickname'];
    num = json['num'];
    orderId = json['order_id'];
    originalImg = json['original_img'];
    regMobile = json['reg_mobile'];
    shippingName = json['shipping_name'];
    shippingStatus = json['shipping_status'];
    status = json['status'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    // data['admin_note'] = this.adminNote;
    data['code'] = this.code;
    data['confirm_time'] = this.confirmTime;
    data['create_time'] = this.createTime;
    data['flag'] = this.flag;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['goods_type'] = this.goodsType;
    data['id'] = this.id;
    data['integral'] = this.integral;
    data['invoice_no'] = this.invoiceNo;
    data['mem_id'] = this.memId;
    data['mobile'] = this.mobile;
    data['nickname'] = this.nickname;
    data['num'] = this.num;
    data['order_id'] = this.orderId;
    data['original_img'] = this.originalImg;
    data['reg_mobile'] = this.regMobile;
    data['shipping_name'] = this.shippingName;
    data['shipping_status'] = this.shippingStatus;
    data['status'] = this.status;
    data['username'] = this.username;
    return data;
  }
}
