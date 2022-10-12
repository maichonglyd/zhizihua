import '../base_model.dart';

class ExchangeDetail extends BaseModel<Data> {
  ExchangeDetail.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int actId;
  String address;
  // List<String> adminNote;
  int city;
  int confirmTime;
  String consignee;
  int country;
  int createTime;
  int district;
  String email;
  String endTime;
  int flag;
  String goodsCode;
  int goodsId;
  String goodsName;
  int id;
  num integral;
  String invoiceNo;
  int memId;
  String mobile;
  int number;
  String orderId;
  String originalImg;
  int province;
  String shippingCode;
  String shippingName;
  String shippingPrice;
  int shippingStatus;
  int shippingTime;
  String startTime;
  int status;
  int town;
  int updateTime;
  String userNote;
  String zipcode;

  Data(
      {this.actId,
      this.address,
      //    this.adminNote,
      this.city,
      this.confirmTime,
      this.consignee,
      this.country,
      this.createTime,
      this.district,
      this.email,
      this.endTime,
      this.flag,
      this.goodsCode,
      this.goodsId,
      this.goodsName,
      this.id,
      this.integral,
      this.invoiceNo,
      this.memId,
      this.mobile,
      this.number,
      this.orderId,
      this.originalImg,
      this.province,
      this.shippingCode,
      this.shippingName,
      this.shippingPrice,
      this.shippingStatus,
      this.shippingTime,
      this.startTime,
      this.status,
      this.town,
      this.updateTime,
      this.userNote,
      this.zipcode});

  Data.fromJson(Map<String, dynamic> json) {
    actId = json['act_id'];
    address = json['address'];
    //   adminNote = json['admin_note'].cast<String>();
    city = json['city'];
    confirmTime = json['confirm_time'];
    consignee = json['consignee'];
    country = json['country'];
    createTime = json['create_time'];
    district = json['district'];
    email = json['email'];
    endTime = json['end_time'].toString();
    flag = json['flag'];
    goodsCode = json['goods_code'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    id = json['id'];
    integral = json['integral'];
    invoiceNo = json['invoice_no'];
    memId = json['mem_id'];
    mobile = json['mobile'];
    number = json['num'];
    orderId = json['order_id'];
    originalImg = json['original_img'];
    province = json['province'];
    shippingCode = json['shipping_code'];
    shippingName = json['shipping_name'];
    shippingPrice = json['shipping_price'];
    shippingStatus = json['shipping_status'];
    shippingTime = json['shipping_time'];
    startTime = json['start_time'].toString();
    status = json['status'];
    town = json['town'];
    updateTime = json['update_time'];
    userNote = json['user_note'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['act_id'] = this.actId;
    data['address'] = this.address;
    //   data['admin_note'] = this.adminNote;
    data['city'] = this.city;
    data['confirm_time'] = this.confirmTime;
    data['consignee'] = this.consignee;
    data['country'] = this.country;
    data['create_time'] = this.createTime;
    data['district'] = this.district;
    data['email'] = this.email;
    data['end_time'] = this.endTime;
    data['flag'] = this.flag;
    data['goods_code'] = this.goodsCode;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['id'] = this.id;
    data['integral'] = this.integral;
    data['invoice_no'] = this.invoiceNo;
    data['mem_id'] = this.memId;
    data['mobile'] = this.mobile;
    data['num'] = this.number;
    data['order_id'] = this.orderId;
    data['original_img'] = this.originalImg;
    data['province'] = this.province;
    data['shipping_code'] = this.shippingCode;
    data['shipping_name'] = this.shippingName;
    data['shipping_price'] = this.shippingPrice;
    data['shipping_status'] = this.shippingStatus;
    data['shipping_time'] = this.shippingTime;
    data['start_time'] = this.startTime;
    data['status'] = this.status;
    data['town'] = this.town;
    data['update_time'] = this.updateTime;
    data['user_note'] = this.userNote;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
