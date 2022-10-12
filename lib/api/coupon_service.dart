import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_bean_list.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';
import 'package:flutter_huoshu_app/model/coupon/reward_bean_list.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/game_jp.dart';
import 'package:flutter_huoshu_app/model/game/game_list.dart';
import 'package:flutter_huoshu_app/model/game/game_type.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/game/newsdetails_bean.dart';
import 'package:flutter_huoshu_app/model/game/search_hot_list.dart';
import 'package:flutter_huoshu_app/model/game_dto.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

import 'common_dio.dart';

class CouponService {
  //获取优惠券列表
  static Future<CouponList> getCouponList(int page, int status,
      {int offset = 10}) async {
    dynamic response = await CommonDio.post("app/user/coupon/list",
        data: {"page": page, "offset": offset,"status": status});
    return CouponList.fromJson(response);
  }

  //领取优惠券
  static Future<VIPPayInfoData> openVip(int id, String payWay) async {
    dynamic response = await CommonDio.post("app/vip/pay",
        data: {"vip_id": id, "payway": payWay});
    return VIPPayInfoData.fromJson(response);
  }

  //首页进行优惠券弹窗 1.scene=1登录场景 scene=2注册场景
  static Future<RewardList> getRewordList(int scene) async {
    dynamic response = await CommonDio.get(
        "platformact/reward/list?scene=${scene}${RequestUtil.getSignForGet(RequestUtil.getCommonData())}");
    return RewardList.fromJson(response);
  }

  //领取弹窗的优惠券
  static Future<dynamic> takeReward(int scene) async {
    dynamic response =
    await CommonDio.post("platformact/reward/add", data: {"scene": scene});
    return response;
  }

  //领取优惠券
  static Future<BaseModel> obtainCoupon({int id}) async {
    dynamic response =
    await CommonDio.post("cpvoucher/voucher/add", data: {"cv_id": id});
    return BaseModel.fromJson(response);
  }

  //获取优惠券中心列表
  static Future<CouponCenterList> getCouponCenter(
      {int page, String gameName, int offset = 10}) async {
    dynamic response = await CommonDio.post("gameact/game/list",
        data: {"page": page, "offset": offset, "game_name": gameName});
    return CouponCenterList.fromJson(response);
  }

  //领取优惠券
  static Future<BaseModel> obtainCouponCenter({int id}) async {
    dynamic response =
    await CommonDio.post("gameact/coupon/add", data: {"id": id});
    return BaseModel.fromJson(response);
  }
}
