import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';
import 'package:flutter_huoshu_app/model/user/coupon_friend_reward_data.dart';
import 'package:flutter_huoshu_app/model/user/coupon_my_reward_data.dart';
import 'package:flutter_huoshu_app/model/user/cpl_mem_rank_list.dart';
import 'package:flutter_huoshu_app/model/user/cps_rate_check.dart';
import 'package:flutter_huoshu_app/model/user/cps_recharge_record.dart';
import 'package:flutter_huoshu_app/model/user/exchange_detail_data.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';
import 'package:flutter_huoshu_app/model/user/gold_record.dart';
import 'package:flutter_huoshu_app/model/user/goods_details_data.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';
import 'package:flutter_huoshu_app/model/user/lottery_draw.dart';
import 'package:flutter_huoshu_app/model/user/lottery_index.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';
import 'package:flutter_huoshu_app/model/user/ptb_consume_record.dart';
import 'package:flutter_huoshu_app/model/user/ptb_recharge_record.dart';
import 'package:flutter_huoshu_app/model/user/recycle_explain.dart';
import 'package:flutter_huoshu_app/model/user/recycle_list.dart';
import 'package:flutter_huoshu_app/model/user/recycle_pro_order.dart';
import 'package:flutter_huoshu_app/model/user/share_info.dart';
import 'package:flutter_huoshu_app/model/user/share_men_list_data.dart';
import 'package:flutter_huoshu_app/model/user/task_home.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/model/user/user_sign_list_data.dart';

import 'common_dio.dart';

class UserService {
  static Future<Map<String, dynamic>> init() async {
    Response<Map<String, dynamic>> response =
        await CommonDio.dio.post("app/app/appinit", data: {"open_cnt": 1});
    return response.data;
  }

  static Future<String> mobileLogin(String mobile, String authcode) async {
    Response<String> response = await CommonDio.dio.post(
        "app/user/mobile/login",
        data: {"sms-type": "2", "sms-mobile": mobile, "sms-code": authcode});
    return response.data;
  }

  static Future<UserInfo> usernameLogin(
      String username, String password, Context ctx) async {
    dynamic response = await CommonDio.post("app/user/login",
        data: {"mem-username": username, "mem-password": password},
        ctx: ctx,
        isShowDialog: false);
    return UserInfo.fromJson(response);
  }

  //?????????????????????
  //sms-type 1?????? 2?????? 3???????????? 4???????????? 5 ???????????? 6 ????????????
  static dynamic sendRegisterSms(String mobile) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": "1", "sms-mobile": mobile});
    return response;
  }

  //????????????
  //sms-type 1?????? 2?????? 3???????????? 4???????????? 5 ???????????? 6 ????????????
  static Future<UserInfo> mobileRegister(
      String mobile, String code, String password) async {
    dynamic response = await CommonDio.post("app/user/mobile/reg", data: {
      "sms-type": "1",
      "sms-mobile": mobile,
      "sms-code": code,
      "mem-password": password
    });
    //??????????????????
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //???????????????
  static Future<UserInfo> usernameRegister(
      String userName, String password) async {
    dynamic response = await CommonDio.post("app/user/reg", data: {
      "mem-username": userName,
      "mem-password": password,
    });
    //??????????????????
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //??????????????????
  static Future<UserInfo> getUserInfo() async {
    dynamic response = await CommonDio.post("app/user/detail");
    //??????????????????
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //???????????? ????????????????????????
  static Future<dynamic> getUserBindInfo(String userName) async {
    dynamic response = await CommonDio.post("app/account/bind/info",
        data: {"username": userName});
    return response;
  }

  //???????????? ????????????  ??????????????????
  //sms-type 1?????? 2?????? 3???????????? 4???????????? 5 ???????????? 6 ????????????
  static Future<dynamic> sendFindPasswordSms(String verifyToken) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": 5, "verify_token": verifyToken});
    return response;
  }

  //???????????? ?????????????????????
  static Future<dynamic> findPasswordVerify(
      String code, String verifyToken) async {
    dynamic response = await CommonDio.post("app/password/verify",
        data: {"type": 2, "code": code, "verify_token": verifyToken});
    return response;
  }

  //???????????? ????????????
  static Future<dynamic> passwordReset(
      String password, String verifyToken) async {
    dynamic response = await CommonDio.post("app/password/reset",
        data: {"password": password, "verify_token": verifyToken});
    return response;
  }

  //????????????
  static Future<dynamic> updatePassword(String oldpwd, String newpwd) async {
    dynamic response = await CommonDio.post("app/user/update/pwd",
        data: {"oldpwd": oldpwd, "newpwd": newpwd});
    return response;
  }

  //???????????? ?????????????????????
  //sms-type 1?????? 2?????? 3???????????? 4???????????? 5 ???????????? 6 ????????????
  static Future<dynamic> sendBindSms(String mobile) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": "6", "sms-mobile": mobile});
    return response;
  }

  //???????????????
  static Future<dynamic> bindMobile(String mobile, String code) async {
    dynamic response = await CommonDio.post("app/mobile/bind",
        data: {"sms-mobile": mobile, "sms-code": code});
    return response;
  }

  //???????????? ?????????????????????
  //sms-type 1?????? 2?????? 3???????????? 4???????????? 5 ???????????? 6 ????????????
  static Future<dynamic> sendResetMobileSms() async {
    dynamic response =
        await CommonDio.post("app/sms/send", data: {"sms-type": "6"});
    return response;
  }

  //?????????????????????????????????
  static Future<dynamic> sendMobileCheck(String code) async {
    dynamic response =
        await CommonDio.post("app/mobile/check", data: {"sms-code": code});
    return response;
  }

  //??????????????????
  static Future<dynamic> feedback(String content, String mobile) async {
    dynamic response = await CommonDio.post("app/game/feedback",
        data: {"content": content, "linkman": mobile});
    return response;
  }

  //???????????????
  static Future<dynamic> updateNickname(String nickname) async {
    dynamic response = await CommonDio.post("app/user/nickname/update",
        data: {"nickname": nickname});
    return response;
  }

  // ??????????????????
  static Future<dynamic> updateAvatar(String avatar) async {
    dynamic response = await CommonDio.post("app/user/avatar/update",
        data: {"avatar": avatar});
    return response;
  }

  //????????????
  //???????????????1 ?????? 2 ??????
  static Future<GoldRecord> getGoldRecord(
      int page, int offset, int type) async {
    dynamic response = await CommonDio.post("app/user/gold/record",
        data: {"page": page, "offset": offset, "itg_type": type});
    return GoldRecord.fromJson(response);
  }

  //??????????????????
  static Future<MessageListData> getMessages(int page, int offset) async {
    dynamic response = await CommonDio.post("app/msg/list",
        data: {"page": page, "offset": offset});
    return MessageListData.fromJson(response);
  }

  //?????????????????????
  static Future getMsgCount() async {
    dynamic response = await CommonDio.post("app/user/msg/count");
    return response;
  }

  //????????????
  static Future<ShareInfo> getShareDataByApp(
      {String type = 'app', num lotteryId}) async {
    dynamic response = await CommonDio.post("app/share/detail", data: {
      "share_type": type,
      if (null != lotteryId) "object_id": lotteryId
    });
    return ShareInfo.fromJson(response);
  }

  //??????????????????
  static Future<ShareInfo> getShareDataByGame(int gameId) async {
    dynamic response = await CommonDio.post("app/share/detail",
        data: {"share_type": "game", "game_id": gameId});
    return ShareInfo.fromJson(response);
  }

  //????????????????????????
  static Future<MemListData> getShareMemlist(int page, int offset) async {
    dynamic response = await CommonDio.post("app/user/share/memlist",
        data: {"page": page, "offset": offset});
    return MemListData.fromJson(response);
  }

  //????????????
  static Future<LotteryIndexData> getLotteryIndex(int page, int offset) async {
    dynamic response = await CommonDio.post("app/lottery/index", data: {
      "page": page,
      "offset": offset,
      "act_id": 6,
    });
    return LotteryIndexData.fromJson(response);
  }

  //????????????
  static Future<LotteryDrawData> getLotteryDraw() async {
    dynamic response = await CommonDio.post("app/lottery/draw", data: {
      "act_id": 6,
    });
    return LotteryDrawData.fromJson(response);
  }

  //??????????????????
  static Future lotteryRealGoods(
      String goodsId, String phone, String name, String address) async {
    dynamic response = await CommonDio.post("app/lottery/get_reward", data: {
      "order_id": goodsId,
      "num": 1,
      "address": address,
      "mobile": phone,
      "consignee": name
    });
    return response;
  }

  //??????????????????
  static Future<ExchangeRecordListData> getExchangeRecordList(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/shop/goods/exchange_list",
        data: {"page": page, "offset": offset});
    return ExchangeRecordListData.fromJson(response);
  }

  //????????????????????????
  static Future<ExchangeDetail> getExchangeRecordDetails(String id) async {
    dynamic response =
        await CommonDio.post("app/shop/goods/exchange_detail", data: {
      "order_id": id,
    });
    return ExchangeDetail.fromJson(response);
  }

  //?????????????????????  target ??????:weibo, ??????:wx????????????:wxp, QQ:qq
  static Future notifyShare(String shareId, String target) async {
    dynamic response = await CommonDio.post("app/share/notify",
        data: {"share_id": shareId, "to_target": target, "share_type": "app"},
        isShowError: false);
    return response;
  }

  //????????????????????????
  static Future<GoodsListData> getGoods(
      int page, int offset, int isReal) async {
    dynamic response = await CommonDio.post("app/shop/goods/list", data: {
      "page": page,
      "offset": offset,
      "is_real": isReal,
    });
    return GoodsListData.fromJson(response);
  }

  //????????????????????????
  static Future<GoodsDetailsData> getGoodsDetails(int goodsId) async {
    dynamic response = await CommonDio.post("app/shop/goods/detail",
        data: {"goods_id": goodsId});
    return GoodsDetailsData.fromJson(response);
  }

  //????????????
  static Future exchangeGoods(int goodsId) async {
    dynamic response = await CommonDio.post("app/shop/goods/exchange",
        data: {"goods_id": goodsId, "num": 1});
    return response;
  }

  //????????????
  static Future exchangeRealGoods(
      int goodsId, String phone, String name, String address) async {
    dynamic response = await CommonDio.post("app/shop/goods/exchange", data: {
      "goods_id": goodsId,
      "num": 1,
      "address": address,
      "mobile": phone,
      "consignee": name
    });
    return response;
  }

  //??????????????????
  static Future<ServiceInfo> getServiceInfo() async {
    dynamic response = await CommonDio.post("app/help/index");
    return ServiceInfo.fromJson(response);
  }

  //???????????????
  static Future<DealPayInfoData> ptbPay(String payWay, int amount) async {
    dynamic response = await CommonDio.post("app/ptb/pay/post",
        data: {"payway": payWay, "amount": amount});
    return DealPayInfoData.fromJson(response);
  }

  //?????????????????????
  static Future<PtbRechargeRecord> ptbRechargeRecord(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/ptb/recharge/record",
        data: {"page": page, "offset": offset});
    return PtbRechargeRecord.fromJson(response);
  }

  //?????????????????????
  static Future<PtbConsumeRecord> ptbConsumeRecord(int page, int offset) async {
    dynamic response = await CommonDio.post("app/ptb/consume/record",
        data: {"page": page, "offset": offset});
    return PtbConsumeRecord.fromJson(response);
  }

  //??????????????????
  static Future queryOrder(String orderId) async {
    dynamic response = await CommonDio.post("app/ptb/order/query",
        data: {"order_id": orderId});
    return response;
  }

  //??????????????????
  static Future cpsQueryOrder(String orderId) async {
    dynamic response = await CommonDio.post("ncps/app/order/query",
        data: {"order-order_id": orderId});
    return response;
  }

  //??????????????????
  static Future<UserSignListData> getSignList() async {
    dynamic response = await CommonDio.post(
      "app/user/sign/list",
    );
    return UserSignListData.fromJson(response);
  }

  //??????
  static Future addSign() async {
    dynamic response = await CommonDio.post(
      "app/user/sign/add",
    );
    return response;
  }

  //????????????????????????
  static Future<TaskHome> getTaskHome() async {
    dynamic response = await CommonDio.post(
      "app/task/home",
    );
    return TaskHome.fromJson(response);
  }

  //????????????
  static Future<String> logout() async {
    dynamic response = await CommonDio.post("app/user/logout");
    return response['msg'];
  }

  //???????????? ??????
  static Future<RecycleExplain> getRecycleExplain() async {
//    dynamic response = await CommonDio.post("app/recycle/explain");
    dynamic response = await CommonDio.post("app/account/recycle/explain");
    return RecycleExplain.fromJson(response);
  }

  //??????????????????
  static Future<RecycleList> getRecycleList(int page) async {
    dynamic response = await CommonDio.post("app/account/recycle/mg_list",
        data: {"page": page});
    return RecycleList.fromJson(response);
  }

  //??????????????????
  static Future<RecycleList> addRecycle(int mgMemId) async {
    dynamic response = await CommonDio.post("app/account/recycle/add_recycle",
        data: {"mg_mem_id": mgMemId, "recycle_way": 1});
    return RecycleList.fromJson(response);
  }

  //?????????????????????
  static Future<RecycleList> getRecycleOrderList(int page) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/order_list", data: {
      "page": page,
      "offset": 10,
    });
    return RecycleList.fromJson(response);
  }

  //?????????????????????
  static Future<RecycleProOrder> recycleProOrder(int id) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/pre_order", data: {
      "recycle_id": id,
    });
    return RecycleProOrder.fromJson(response);
  }

  //??????????????????
  static Future<DealPayInfoData> recyclePay(
      String orderId, String payWay) async {
    dynamic response = await CommonDio.post("/app/account/recycle/pay", data: {
      "order_id": orderId,
      "payway": payWay,
    });
    return DealPayInfoData.fromJson(response);
  }

  //??????????????????
  static Future recycleQueryOrder(String orderId) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/query_order", data: {
      "order_id": orderId,
    });
    return response;
  }

  //????????????
  static Future<CouponMyRewardData> getShareSave(int id) async {
    dynamic response = await CommonDio.post("app/user/share/actsave", data: {
      "sa_id": id,
    });
    return CouponMyRewardData.fromJson(response);
  }

  //????????????????????????
  static Future<CouponFriendRewardData> getUserShareSubactlist(int page) async {
    dynamic response = await CommonDio.post("app/user/share/subactlist", data: {
      "page": page,
      "offset": 30,
    });
    return CouponFriendRewardData.fromJson(response);
  }

  //????????????????????????
  static Future<CouponMyRewardData> getUserShareActlist(int page) async {
    dynamic response = await CommonDio.post("app/user/share/actlist", data: {
      "page": page,
      "offset": 30,
    });
    return CouponMyRewardData.fromJson(response);
  }

  //???????????????
  static Future<DealPayInfoData> cpsPay(
      String payWay, num amount, String gameId, String userName) async {
    dynamic response = await CommonDio.post("ncps/app/order/pay",
        isShowDialog: true,
        data: {
          "payway": payWay,
          "amount": amount,
          "game_id": gameId,
          "username": userName
        });
    return DealPayInfoData.fromJson(response);
  }

  //cps???????????????
  static Future<DealPayInfoData> cpsGamePay1(
      String payWay,
      double amount,
      String gameId,
      String userName,
      String password,
      String serverName,
      String roleName,
      String remark) async {
    dynamic response = await CommonDio.post("ncps/app/order/pay", data: {
      "payway": payWay,
      "amount": amount,
      "game_id": gameId,
      "username": userName,
      "password": password,
      "server_name": serverName,
      "role_name": roleName,
      "remark": remark,
    });
    return DealPayInfoData.fromJson(response);
  }

  //cps???????????????
  static Future<DealPayInfoData> cpsGamePay(
      String payWay,
      double amount,
      String gameId,
      String userName,
      String password,
      String serverName,
      String roleName,
      String remark,
      String imageJson) async {
    dynamic response =
        await CommonDio.post("ncps/app/order/pay", isShowDialog: true, data: {
      "payway": payWay,
      "amount": amount,
      "game_id": gameId,
      "username": userName,
      "password": password,
      "server_name": serverName,
      "role_name": roleName,
      "remark": remark,
      "image": imageJson
    });
    return DealPayInfoData.fromJson(response);
  }

  //?????????????????????
  static Future<CpsRechargeRecord> cpsRechargeRecord(
      int page, int offset) async {
    dynamic response = await CommonDio.post("ncps/app/order/list",
        data: {"page": page, "offset": offset});
    println(response);
    return CpsRechargeRecord.fromJson(response);
  }

  static Future<CplMemRankList> cplMemRank(int page, int offset) async {
    dynamic response = await CommonDio.post("app/cpl/mem/rank",
        data: {"page": page, "offset": offset});
    println(response);
    return CplMemRankList.fromJson(response);
  }

  //CPS??????????????????
  static Future<CpsRateCheck> cpsAccountCheck(
      num gameId, String account, num cpId) async {
    dynamic response = await CommonDio.post("ncps/app/account/check",
        data: {"game_id": gameId, "account": account, "cps_id": cpId});
    return CpsRateCheck.fromJson(response);
  }
}
