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

  //发送短信验证码
  //sms-type 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static dynamic sendRegisterSms(String mobile) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": "1", "sms-mobile": mobile});
    return response;
  }

  //手机注册
  //sms-type 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static Future<UserInfo> mobileRegister(
      String mobile, String code, String password) async {
    dynamic response = await CommonDio.post("app/user/mobile/reg", data: {
      "sms-type": "1",
      "sms-mobile": mobile,
      "sms-code": code,
      "mem-password": password
    });
    //保存用户信息
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //用户名注册
  static Future<UserInfo> usernameRegister(
      String userName, String password) async {
    dynamic response = await CommonDio.post("app/user/reg", data: {
      "mem-username": userName,
      "mem-password": password,
    });
    //保存用户信息
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //获取用户信息
  static Future<UserInfo> getUserInfo() async {
    dynamic response = await CommonDio.post("app/user/detail");
    //保存用户信息
    LoginControl.saveUserInfo(json.encode(response));
    return UserInfo.fromJson(response);
  }

  //找回密码 获取用户绑定信息
  static Future<dynamic> getUserBindInfo(String userName) async {
    dynamic response = await CommonDio.post("app/account/bind/info",
        data: {"username": userName});
    return response;
  }

  //找回密码 发送短信  不用传手机号
  //sms-type 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static Future<dynamic> sendFindPasswordSms(String verifyToken) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": 5, "verify_token": verifyToken});
    return response;
  }

  //找回密码 验证手机验证码
  static Future<dynamic> findPasswordVerify(
      String code, String verifyToken) async {
    dynamic response = await CommonDio.post("app/password/verify",
        data: {"type": 2, "code": code, "verify_token": verifyToken});
    return response;
  }

  //找回密码 重置密码
  static Future<dynamic> passwordReset(
      String password, String verifyToken) async {
    dynamic response = await CommonDio.post("app/password/reset",
        data: {"password": password, "verify_token": verifyToken});
    return response;
  }

  //修改密码
  static Future<dynamic> updatePassword(String oldpwd, String newpwd) async {
    dynamic response = await CommonDio.post("app/user/update/pwd",
        data: {"oldpwd": oldpwd, "newpwd": newpwd});
    return response;
  }

  //绑定手机 发送短信验证码
  //sms-type 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static Future<dynamic> sendBindSms(String mobile) async {
    dynamic response = await CommonDio.post("app/sms/send",
        data: {"sms-type": "6", "sms-mobile": mobile});
    return response;
  }

  //绑定手机号
  static Future<dynamic> bindMobile(String mobile, String code) async {
    dynamic response = await CommonDio.post("app/mobile/bind",
        data: {"sms-mobile": mobile, "sms-code": code});
    return response;
  }

  //更换手机 发送短信验证码
  //sms-type 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static Future<dynamic> sendResetMobileSms() async {
    dynamic response =
        await CommonDio.post("app/sms/send", data: {"sms-type": "6"});
    return response;
  }

  //更换手机号，校验手机号
  static Future<dynamic> sendMobileCheck(String code) async {
    dynamic response =
        await CommonDio.post("app/mobile/check", data: {"sms-code": code});
    return response;
  }

  //提交意见反馈
  static Future<dynamic> feedback(String content, String mobile) async {
    dynamic response = await CommonDio.post("app/game/feedback",
        data: {"content": content, "linkman": mobile});
    return response;
  }

  //修改用户名
  static Future<dynamic> updateNickname(String nickname) async {
    dynamic response = await CommonDio.post("app/user/nickname/update",
        data: {"nickname": nickname});
    return response;
  }

  // 上传用户头像
  static Future<dynamic> updateAvatar(String avatar) async {
    dynamic response = await CommonDio.post("app/user/avatar/update",
        data: {"avatar": avatar});
    return response;
  }

  //积分记录
  //记录类型：1 获得 2 消费
  static Future<GoldRecord> getGoldRecord(
      int page, int offset, int type) async {
    dynamic response = await CommonDio.post("app/user/gold/record",
        data: {"page": page, "offset": offset, "itg_type": type});
    return GoldRecord.fromJson(response);
  }

  //获取消息列表
  static Future<MessageListData> getMessages(int page, int offset) async {
    dynamic response = await CommonDio.post("app/msg/list",
        data: {"page": page, "offset": offset});
    return MessageListData.fromJson(response);
  }

  //获取新消息数量
  static Future getMsgCount() async {
    dynamic response = await CommonDio.post("app/user/msg/count");
    return response;
  }

  //获取分享
  static Future<ShareInfo> getShareDataByApp(
      {String type = 'app', num lotteryId}) async {
    dynamic response = await CommonDio.post("app/share/detail", data: {
      "share_type": type,
      if (null != lotteryId) "object_id": lotteryId
    });
    return ShareInfo.fromJson(response);
  }

  //获取游戏分享
  static Future<ShareInfo> getShareDataByGame(int gameId) async {
    dynamic response = await CommonDio.post("app/share/detail",
        data: {"share_type": "game", "game_id": gameId});
    return ShareInfo.fromJson(response);
  }

  //获取分享人数列表
  static Future<MemListData> getShareMemlist(int page, int offset) async {
    dynamic response = await CommonDio.post("app/user/share/memlist",
        data: {"page": page, "offset": offset});
    return MemListData.fromJson(response);
  }

  //抽奖主页
  static Future<LotteryIndexData> getLotteryIndex(int page, int offset) async {
    dynamic response = await CommonDio.post("app/lottery/index", data: {
      "page": page,
      "offset": offset,
      "act_id": 6,
    });
    return LotteryIndexData.fromJson(response);
  }

  //抽奖主页
  static Future<LotteryDrawData> getLotteryDraw() async {
    dynamic response = await CommonDio.post("app/lottery/draw", data: {
      "act_id": 6,
    });
    return LotteryDrawData.fromJson(response);
  }

  //抽奖实物商品
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

  //获取兑换记录
  static Future<ExchangeRecordListData> getExchangeRecordList(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/shop/goods/exchange_list",
        data: {"page": page, "offset": offset});
    return ExchangeRecordListData.fromJson(response);
  }

  //获取兑换记录详情
  static Future<ExchangeDetail> getExchangeRecordDetails(String id) async {
    dynamic response =
        await CommonDio.post("app/shop/goods/exchange_detail", data: {
      "order_id": id,
    });
    return ExchangeDetail.fromJson(response);
  }

  //分享完成后上报  target 微博:weibo, 微信:wx，朋友圈:wxp, QQ:qq
  static Future notifyShare(String shareId, String target) async {
    dynamic response = await CommonDio.post("app/share/notify",
        data: {"share_id": shareId, "to_target": target, "share_type": "app"},
        isShowError: false);
    return response;
  }

  //获取积分商城列表
  static Future<GoodsListData> getGoods(
      int page, int offset, int isReal) async {
    dynamic response = await CommonDio.post("app/shop/goods/list", data: {
      "page": page,
      "offset": offset,
      "is_real": isReal,
    });
    return GoodsListData.fromJson(response);
  }

  //获取积分商品详情
  static Future<GoodsDetailsData> getGoodsDetails(int goodsId) async {
    dynamic response = await CommonDio.post("app/shop/goods/detail",
        data: {"goods_id": goodsId});
    return GoodsDetailsData.fromJson(response);
  }

  //兑换商品
  static Future exchangeGoods(int goodsId) async {
    dynamic response = await CommonDio.post("app/shop/goods/exchange",
        data: {"goods_id": goodsId, "num": 1});
    return response;
  }

  //兑换商品
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

  //获取客服信息
  static Future<ServiceInfo> getServiceInfo() async {
    dynamic response = await CommonDio.post("app/help/index");
    return ServiceInfo.fromJson(response);
  }

  //平台币充值
  static Future<DealPayInfoData> ptbPay(String payWay, int amount) async {
    dynamic response = await CommonDio.post("app/ptb/pay/post",
        data: {"payway": payWay, "amount": amount});
    return DealPayInfoData.fromJson(response);
  }

  //平台币充值记录
  static Future<PtbRechargeRecord> ptbRechargeRecord(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/ptb/recharge/record",
        data: {"page": page, "offset": offset});
    return PtbRechargeRecord.fromJson(response);
  }

  //平台币消费记录
  static Future<PtbConsumeRecord> ptbConsumeRecord(int page, int offset) async {
    dynamic response = await CommonDio.post("app/ptb/consume/record",
        data: {"page": page, "offset": offset});
    return PtbConsumeRecord.fromJson(response);
  }

  //查询支付结果
  static Future queryOrder(String orderId) async {
    dynamic response = await CommonDio.post("app/ptb/order/query",
        data: {"order_id": orderId});
    return response;
  }

  //查询支付结果
  static Future cpsQueryOrder(String orderId) async {
    dynamic response = await CommonDio.post("ncps/app/order/query",
        data: {"order-order_id": orderId});
    return response;
  }

  //获取签到列表
  static Future<UserSignListData> getSignList() async {
    dynamic response = await CommonDio.post(
      "app/user/sign/list",
    );
    return UserSignListData.fromJson(response);
  }

  //签到
  static Future addSign() async {
    dynamic response = await CommonDio.post(
      "app/user/sign/add",
    );
    return response;
  }

  //获取任务列表首页
  static Future<TaskHome> getTaskHome() async {
    dynamic response = await CommonDio.post(
      "app/task/home",
    );
    return TaskHome.fromJson(response);
  }

  //退出登录
  static Future<String> logout() async {
    dynamic response = await CommonDio.post("app/user/logout");
    return response['msg'];
  }

  //小号回收 文案
  static Future<RecycleExplain> getRecycleExplain() async {
//    dynamic response = await CommonDio.post("app/recycle/explain");
    dynamic response = await CommonDio.post("app/account/recycle/explain");
    return RecycleExplain.fromJson(response);
  }

  //小号回收列表
  static Future<RecycleList> getRecycleList(int page) async {
    dynamic response = await CommonDio.post("app/account/recycle/mg_list",
        data: {"page": page});
    return RecycleList.fromJson(response);
  }

  //小号回收提交
  static Future<RecycleList> addRecycle(int mgMemId) async {
    dynamic response = await CommonDio.post("app/account/recycle/add_recycle",
        data: {"mg_mem_id": mgMemId, "recycle_way": 1});
    return RecycleList.fromJson(response);
  }

  //已回收小号记录
  static Future<RecycleList> getRecycleOrderList(int page) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/order_list", data: {
      "page": page,
      "offset": 10,
    });
    return RecycleList.fromJson(response);
  }

  //小号回收预下单
  static Future<RecycleProOrder> recycleProOrder(int id) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/pre_order", data: {
      "recycle_id": id,
    });
    return RecycleProOrder.fromJson(response);
  }

  //小号赎回支付
  static Future<DealPayInfoData> recyclePay(
      String orderId, String payWay) async {
    dynamic response = await CommonDio.post("/app/account/recycle/pay", data: {
      "order_id": orderId,
      "payway": payWay,
    });
    return DealPayInfoData.fromJson(response);
  }

  //小号回收查单
  static Future recycleQueryOrder(String orderId) async {
    dynamic response =
        await CommonDio.post("app/account/recycle/query_order", data: {
      "order_id": orderId,
    });
    return response;
  }

  //用户领取
  static Future<CouponMyRewardData> getShareSave(int id) async {
    dynamic response = await CommonDio.post("app/user/share/actsave", data: {
      "sa_id": id,
    });
    return CouponMyRewardData.fromJson(response);
  }

  //用户分享我的奖励
  static Future<CouponFriendRewardData> getUserShareSubactlist(int page) async {
    dynamic response = await CommonDio.post("app/user/share/subactlist", data: {
      "page": page,
      "offset": 30,
    });
    return CouponFriendRewardData.fromJson(response);
  }

  //用户分享我的奖励
  static Future<CouponMyRewardData> getUserShareActlist(int page) async {
    dynamic response = await CommonDio.post("app/user/share/actlist", data: {
      "page": page,
      "offset": 30,
    });
    return CouponMyRewardData.fromJson(response);
  }

  //游戏币充值
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

  //cps游戏币充值
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

  //cps游戏币充值
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

  //游戏币充值记录
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

  //CPS充值账户校验
  static Future<CpsRateCheck> cpsAccountCheck(
      num gameId, String account, num cpId) async {
    dynamic response = await CommonDio.post("ncps/app/account/check",
        data: {"game_id": gameId, "account": account, "cps_id": cpId});
    return CpsRateCheck.fromJson(response);
  }
}
