import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

import '../base_model.dart';

class GoodsDetailsData extends BaseModel<Data> {
  GoodsDetailsData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int id;
  int mobilePrefix;
  int adminId;
  int appId;
  String goodsName;
  String objectType;
  int objectId;
  int storeCnt;
  int remainCnt;
  String marketPrice;
  String gainIntegral;
  String integral;
  int memTimes;
  String goodsIntro;
  String goodsContent;
  String postContent;
  String initial;
  String originalImg;
  int flag;
  int isReal;
  int isOnSale;
  int listOrder;
  int onTime;
  int isDelete;
  int deleteTime;
  int createTime;
  int updateTime;
  Gift gift;

  Data({
    this.id,
    this.mobilePrefix,
    this.adminId,
    this.appId,
    this.goodsName,
    this.objectType,
    this.objectId,
    this.storeCnt,
    this.remainCnt,
    this.marketPrice,
    this.gainIntegral,
    this.integral,
    this.memTimes,
    this.goodsIntro,
    this.goodsContent,
    this.initial,
    this.originalImg,
    this.flag,
    this.isReal,
    this.isOnSale,
    this.listOrder,
    this.onTime,
    this.isDelete,
    this.deleteTime,
    this.createTime,
    this.updateTime,
    this.gift,
    this.postContent,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobilePrefix = json['mobile_prefix'];
    adminId = json['admin_id'];
    appId = json['app_id'];
    goodsName = json['goods_name'];
    objectType = json['object_type'];
    objectId = json['object_id'];
    storeCnt = json['store_cnt'];
    remainCnt = json['remain_cnt'];
    marketPrice = json['market_price'];
    gainIntegral = json['gain_integral'];
    integral = json['integral'];
    memTimes = json['mem_times'];
    goodsIntro = json['goods_intro'];
    goodsContent = json['goods_content'];
    initial = json['initial'];
    originalImg = json['original_img'];
    flag = json['flag'];
    isReal = json['is_real'];
    isOnSale = json['is_on_sale'];
    listOrder = json['list_order'];
    onTime = json['on_time'];
    isDelete = json['is_delete'];
    deleteTime = json['delete_time'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    postContent = json['post_content'];
    gift = json['gift'] != null ? new Gift.fromJson(json['gift']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_prefix'] = this.mobilePrefix;
    data['admin_id'] = this.adminId;
    data['app_id'] = this.appId;
    data['goods_name'] = this.goodsName;
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['store_cnt'] = this.storeCnt;
    data['remain_cnt'] = this.remainCnt;
    data['market_price'] = this.marketPrice;
    data['gain_integral'] = this.gainIntegral;
    data['integral'] = this.integral;
    data['mem_times'] = this.memTimes;
    data['goods_intro'] = this.goodsIntro;
    data['goods_content'] = this.goodsContent;
    data['initial'] = this.initial;
    data['original_img'] = this.originalImg;
    data['flag'] = this.flag;
    data['is_real'] = this.isReal;
    data['is_on_sale'] = this.isOnSale;
    data['list_order'] = this.listOrder;
    data['on_time'] = this.onTime;
    data['is_delete'] = this.isDelete;
    data['delete_time'] = this.deleteTime;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['post_content'] = this.postContent;

    if (this.gift != null) {
      data['gift'] = this.gift.toJson();
    }
    return data;
  }
}
