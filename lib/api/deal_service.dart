import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/deal/deal_accont_server_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_details_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_my_order_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_order_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_playing_game_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_details_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_goods_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_index_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_details.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_order_list.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_playing_game_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_role.dart';
import 'package:flutter_huoshu_app/model/deal/deal_prop_server.dart';

import 'common_dio.dart';

class DealService {
  //交易首页
  static Future<DealIndexData> getDealIndex() async {
    dynamic response = await CommonDio.post("app/account/deal/index");
    return DealIndexData.fromJson(response);
  }

  //商品首页 sortType 排序方式：1:表示按最新上架，2：价格高到低，3价格低到高
  static Future<DealGoodsListData> getDealGoods(
      int page, int offset, int sortType) async {
    dynamic response = await CommonDio.post("app/account/goods/list", data: {
      "page": page,
      "offset": offset,
      "sort_type": sortType,
      "status": 2
    });
    return DealGoodsListData.fromJson(response);
  }

  //商品首页 sortType 排序方式：1:表示按最新上架，2：价格高到低，3价格低到高
  static Future<DealGoodsListData> getDealGoodsById(
      int page, int offset, int gameId) async {
    dynamic response = await CommonDio.post("app/account/goods/list",
        data: {"page": page, "offset": offset, "game_id": gameId, "status": 2});
    return DealGoodsListData.fromJson(response);
  }

  //商品列表，自己的商品  status	状态 0所有 1审核中 2已上架 3已下架 4已出售 5审核不通过
  static Future<DealGoodsListData> getMyDealGoods(
      int page, int offset, int status) async {
    dynamic response = await CommonDio.post("app/account/goods/list", data: {
      "page": page,
      "offset": offset,
      "is_me_sell": 2,
      "status": status
    });
    return DealGoodsListData.fromJson(response);
  }

  static Future<DealGoodsListData> searchDealGoods(
      int page, int offset, String key) async {
    dynamic response = await CommonDio.post("app/account/goods/list",
        data: {"page": page, "offset": offset, "keyword": key, "status": 2});
    return DealGoodsListData.fromJson(response);
  }

  //交易详情页
  static Future<DealDetailsData> getDealDetails(int goodsId) async {
    dynamic response = await CommonDio.post("app/account/goods/detail",
        data: {"goods_id": goodsId});
    return DealDetailsData.fromJson(response);
  }

  //交易订单列表  is_mine	否	Number(11)	默认为0 1 表示自己买 2 表示自己卖
  static Future<DealMyOrderListData> getAccountOrderList(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/account/order/list", data: {
      "page": page,
      "offset": offset,
      "is_mine": 1,
    });
    return DealMyOrderListData.fromJson(response);
  }

  //下单
  static Future<DealOrderData> dealCreateOrder(Context ctx, int goodsId) async {
    dynamic response = await CommonDio.post("app/account/goods/buy",
        data: {"goods_id": goodsId}, ctx: ctx);
    return DealOrderData.fromJson(response);
  }

  //获取支付方式
  static Future getPayWay() async {
    dynamic response = await CommonDio.post("app/account/pay/payway");
    return response;
  }

  //获取支付token，调起支付
  static Future<DealPayInfoData> pay(
      String orderId, String payWay, String payToken) async {
    dynamic response = await CommonDio.post("app/account/goods/pay",
        data: {"order_id": orderId, "payway": payWay, "pay_token": payToken});
    return DealPayInfoData.fromJson(response);
  }

  //查询支付结果
  static Future queryOrder(String orderId) async {
    dynamic response = await CommonDio.post("app/account/order/query",
        data: {"order_id": orderId});
    return response;
  }

  //交易 卖号 - 游戏列表
  static Future<DealPlayingGameListData> getDealGameList() async {
    dynamic response = await CommonDio.post("app/user/account/game/list");
    return DealPlayingGameListData.fromJson(response);
  }

  //交易 卖号 - 游戏对应的小号列表
  static Future<DealAccountListData> getDealAccountsByGame(int gameId) async {
    dynamic response = await CommonDio.post("app/user/account/list",
        data: {"game_id": gameId});
    return DealAccountListData.fromJson(response);
  }

  //交易 卖号 - 小号对应的区服信息
  static Future<DealAccountServerData> getDealAccountServer(int mgMemId) async {
    dynamic response = await CommonDio.post("app/user/account/server",
        data: {"mg_mem_id": mgMemId});
    return DealAccountServerData.fromJson(response);
  }

  //交易 卖号 - 游戏列表
  static Future<DealPlayingGameListData> getPlayingGames() async {
    dynamic response = await CommonDio.post("app/account/pgsgl");
    return DealPlayingGameListData.fromJson(response);
  }

  //发送验证码 1注册 2登录 3修改密码 4身份验证 5 找回密码 6 绑定手机
  static Future<dynamic> sendSellSms() async {
    dynamic response =
        await CommonDio.post("app/sms/send", data: {"sms-type": 4});
    return response;
  }

  //出售
  static Future<BaseModel> sell(String code, int mgMemId, int gameId,
      String title, String price, String imageJson, String description) async {
    dynamic response = await CommonDio.post("app/account/goods/sell", data: {
      "sms-code": code,
      "mg_mem_id": mgMemId,
      "game_id": gameId,
      "title": title,
      "price": price,
      "image": imageJson,
      "description": description,
    });
    return BaseModel.fromJson(response);
  }

  //
  static Future<BaseModel> edit(
    String code,
    String roleId,
    int gameId,
    String title,
    String price,
    String imageJson,
    String description,
    String serverId,
    String serverName,
    String goodsId,
    int mgMemId,
  ) async {
    dynamic response = await CommonDio.post("app/account/goods/edit", data: {
      "sms-code": code,
      "role_id": roleId,
      "game_id": gameId,
      "title": title,
      "price": price,
      "image": imageJson,
      "description": description,
      "server_id": serverId,
      "server_name": serverName,
      "goods_id": goodsId,
      "mg_mem_id": mgMemId,
    });
    return BaseModel.fromJson(response);
  }

  //下架小号
  static Future<BaseModel> dealGoodsCancel(int goodsId) async {
    dynamic response = await CommonDio.post("app/account/goods/cancel",
        data: {"goods_id": goodsId});
    return BaseModel.fromJson(response);
  }

  //道具商城主页
  static Future<DealPropIndexData> getMaterialDealIndex() async {
    dynamic response = await CommonDio.post("app/material/deal/index");
    return DealPropIndexData.fromJson(response);
  }

  //道具商城 选择游戏列表
  static Future<DealPropPlayingGameListData> getMaterialGameList(
      int page) async {
    dynamic response = await CommonDio.post("app/material/game/list",
        data: {"page": page, "offset": 10, "is_mine": 1});
    return DealPropPlayingGameListData.fromJson(response);
  }

  //道具商城 我的游戏列表
  static Future<DealPropPlayingGameListData> getMaterialGameListByMine(int page) async {
    dynamic response = await CommonDio.post("app/material/game/list",
        data: {"page": page, "offset": 10, "is_mine": 2});
    return DealPropPlayingGameListData.fromJson(response);
  }

  //道具商城 获取全部区服列表
  static Future<DealPropServerData> getMaterialServices(
    int gameId,
    int page,
  ) async {
    dynamic response = await CommonDio.post("app/material/server/list", data: {
      "game_id": gameId,
      "page": page,
      "offset": 10,
    });
    return DealPropServerData.fromJson(response);
  }

  //道具商城 我的区服列表
  static Future<DealPropServerData> getMaterialServicesByMine(
      int gameId,
    int page,
  ) async {
    dynamic response = await CommonDio.post("app/material/server/list",
        data: {"game_id": gameId, "page": page, "offset": 100, "is_mine": 2});
    return DealPropServerData.fromJson(response);
  }

  //道具商城 小号列表
  static Future<DealPropRoleData> getMaterialRoles(
      int gameId, String serverId) async {
    dynamic response = await CommonDio.post("app/material/role/list",
        data: {"game_id": gameId, "server_id": serverId});
    return DealPropRoleData.fromJson(response);
  }

  //道具商城 获取商品列表
  //sortType 排序方式：1:表示按最新上架，2：价格高到低，3价格低到高
  //status 状态 0所有 1审核中 2已上架 3已下架 4已出售 5审核不通过 6 锁定中
  //isMeSell 是否是自己出售的商品 1不是 2是
  static Future<DealPropGoodsListData> getMaterialGoodsList(int page,
      {int sortType = 1,
      int state = 0,
      int isMeSell,
      int gameId,
      String serverId}) async {
    Map<String, dynamic> data = {
      "page": page,
      "offset": 10,
      "sort_type": sortType,
      "status": state,
    };

    if (gameId != null) {
      data["game_id"] = gameId;
    }

    if (isMeSell != null) {
      data["is_me_sell"] = isMeSell;
    }

    if (gameId != null) {
      data["game_id"] = gameId;
    }

    if (serverId != null) {
      data["server_id"] = serverId;
    }

    dynamic response =
        await CommonDio.post("app/material/goods/list", data: data);

    return DealPropGoodsListData.fromJson(response);
  }

  //道具商城  获取商品详情
  static Future<DealPropDetailsData> getMaterialGoodsDetails(
      int goodsId) async {
    dynamic response = await CommonDio.post("app/material/goods/detail",
        data: {"goods_id": goodsId});
    return DealPropDetailsData.fromJson(response);
  }

  //道具商城  获取订单
  //status	状态 交易状态 1待支付 2已支付 3 支付失败
  //is_mine	默认为0 1 表示自己买 2 表示自己卖
  static Future<DealPropOrderListData> getMaterialOrders(
      int page, int isMine) async {
    dynamic response = await CommonDio.post("app/material/order/list",
        data: {"page": page, "offset": 10, "is_mine": isMine});
    return DealPropOrderListData.fromJson(response);
  }

  //获取订单详情
  static Future<DealPropOrderDetailsData> getMaterialOrderDetails(
      String orderId) async {
    dynamic response = await CommonDio.post("app/material/order/detail",
        data: {"order_id": orderId});
    return DealPropOrderDetailsData.fromJson(response);
  }

  //道具商城 取消订单
  static Future<BaseModel> cancelMaterialOrders(int orderId) async {
    dynamic response = await CommonDio.post("app/material/order/cancel",
        data: {"order_id": orderId});
    return BaseModel.fromJson(response);
  }

  //道具商场  商品下架
  static Future<BaseModel> cancelMaterialGoods(int goodsId) async {
    dynamic response = await CommonDio.post("app/material/goods/cancel",
        data: {"goods_id": goodsId});
    return BaseModel.fromJson(response);
  }

  //道具商城 购买道具下单
  static Future<DealOrderData> addMaterialOrder(int goodsId,
      {String userName,
      String passWord,
      String serverName,
      String roleName,
      String mobile,
      String remark}) async {
    dynamic response = await CommonDio.post("app/material/goods/buy", data: {
      "goods_id": goodsId,
      "username": userName,
      "password": passWord,
      "server_name": serverName,
      "role_name": roleName,
      "mobile": mobile,
      "remark": remark,
    });
    return DealOrderData.fromJson(response);
  }

  static Future<DealOrderData> rePay(String orderId) async {
    dynamic response = await CommonDio.post("app/material/order/repay",
        data: {"order_id": orderId});
    return DealOrderData.fromJson(response);
  }

  //道具商城 购买道具支付
  static Future<DealPayInfoData> materialPay(
      String orderId, String payWay, String payToken) async {
    dynamic response = await CommonDio.post("app/material/goods/pay",
        data: {"order_id": orderId, "payway": payWay, "pay_token": payToken});
    return DealPayInfoData.fromJson(response);
  }

  //查询支付结果
  static Future materialQueryOrder(String orderId) async {
    dynamic response = await CommonDio.post("app/material/order/query",
        data: {"order_id": orderId});
    return response;
  }

  //道具商城 出售道具 上架商品
  static Future<BaseModel> sellMaterialGoods(int gameId,
      {String serverId,
      String serverName,
      String roleId,
      String roleName,
      String password,
      String title,
      String price,
      String imageJson,
      String description,
      String mobile,
      Context ctx}) async {
    dynamic response = await CommonDio.post("app/material/goods/sell",
        data: {
          "game_id": gameId,
          "server_id": serverId,
          "server_name": serverName,
          "role_id": roleId,
          "role_name": roleName,
          "password": password,
          "title": title,
          "price": price,
          "image": imageJson,
          "description": description,
          "mobile": mobile,
        },
        isShowDialog: true,
        ctx: ctx);
    return BaseModel.fromJson(response);
  }

  // 道具商城 编辑商品
  static Future<BaseModel> editMaterialGoods(int goodsId,
      {String serverId,
      String serverName,
      String roleId,
      String roleName,
      String password,
      String title,
      String price,
      String imageJson,
      String description,
      String mobile,
      Context ctx}) async {
    dynamic response = await CommonDio.post("app/material/goods/edit",
        data: {
          "goods_id": goodsId,
          "server_id": serverId,
          "server_name": serverName,
          "role_id": roleId,
          "role_name": roleName,
          "password": password,
          "title": title,
          "price": price,
          "image": imageJson,
          "description": description,
          "mobile": mobile,
        },
        isShowDialog: true,
        ctx: ctx);
    return BaseModel.fromJson(response);
  }
}
