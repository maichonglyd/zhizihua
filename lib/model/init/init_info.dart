import 'package:flutter_huoshu_app/model/game/game_banner.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

class InitInfo extends BaseModel<Data> {
  InitInfo.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class UpInfo {
  num upStatus; //	INT	0=不更新，1=强更，2=选更
  String url; //STRING(URL)	up_status 为1或2时必填
  String content; //	STRING	更新内容
  String version; //	STRING	版本
  UpInfo(this.upStatus, this.url, this.content, this.version);

  UpInfo.fromJson(Map<String, dynamic> json) {
    upStatus = json['up_status'];
    url = json['url'];
    content = json['content'];
    version = json['version'];
  }
}

class Splash {
  String img; //	STRING	闪屏图图片URL
  int gameId; //	STRING	闪屏图跳转游戏ID
  String url; //	STRING	闪屏图跳转地址，gameid为0或空时跳转
  int time; // 2018-08-04 13:53:05 星期六	INT	闪屏图停留时间， 秒
  Splash(this.img, this.gameId, this.url, this.time);

  Splash.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    gameId = json['game_id'];
    url = json['url'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['game_id'] = this.gameId;
    data['url'] = this.url;
    data['time'] = this.time;
    return data;
  }
}

class Mod {
  String name; //	STRING	首页标签
  String type; //	STRING	首页标签type="bt",type="jp"
  String listOrder;

//  SlideMod slideList;

  Mod(this.name, this.type, this.listOrder);

  Mod.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    listOrder = json['list_order'];
//    slideList = json['slide_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['list_order'] = this.listOrder;
//    data['slide_list'] = this.slideList;
    return data;
  }

  @override
  String toString() {
    return 'Mod{name: $name, type: $type, listOrder: $listOrder}';
  }
}

class SlideMod {
  int count;
  List<GameBannerItem> list;

  SlideMod({this.count, this.list});

  SlideMod.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<GameBannerItem>();
      json['list'].forEach((v) {
        list.add(new GameBannerItem.fromJson(v));
      });
    }
  }
}

class ShareData {
  String title; //	STRING	分享标题
  String content; //	STRING	分享内容
  String icon; //	STRING	分享图标
  String url; //	STRING	分享URL
  ShareData(this.title, this.content, this.icon, this.url);

  ShareData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    icon = json['icon'];
    url = json['url'];
  }
}

class ThirdPartyData {
  ShareSdkConfig wx;
  ShareSdkConfig wxp;
  ShareSdkConfig qq;

  ThirdPartyData(this.wx, this.wxp, this.qq);

  ThirdPartyData.fromJson(Map<String, dynamic> json) {
    wx = json['wx'] != null ? new ShareSdkConfig.fromJson(json['wx']) : null;
    wxp = json['wxp'] != null ? new ShareSdkConfig.fromJson(json['wxp']) : null;
    qq = json['qq'] != null ? new ShareSdkConfig.fromJson(json['qq']) : null;
  }
}

class ShareSdkConfig {
  String appKey;
  String appSecret;

  ShareSdkConfig(this.appKey, this.appSecret);

  ShareSdkConfig.fromJson(Map<String, dynamic> json) {
    appKey = json['app_key'];
    appSecret = json['app_secret'];
  }
}

class Data {
  String ip; //玩家公网IP	120.236.141.22
  String notice; //	STRING	通知消息
  int toggle; //	STRING	是否重新认证	1 不重新认证 2 重新认证
  String userToken; //	STRING	此次连接使用的user_token	玩家此次连接token
  String agentGame; //	STRING	所属渠道	玩家游戏渠道编号
  num hbTime; //	INT	心跳间隔 单位秒(s)	默认为300s 传入大于60s的参数即使用此时间
  UpInfo upInfo;
  Splash splash;
  ShareData shareData;
  ThirdPartyData thirdPartyData;
  List<Mod> list;
  PopupAd popupAd;
  String clientLangUrl;

  Data.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    notice = json['notice'];
    toggle = json['toggle'];
    userToken = json['user_token'];
    agentGame = json['agent_game'];
    hbTime = json['hb_time'];
    upInfo =
        json['up_info'] != null ? new UpInfo.fromJson(json['up_info']) : null;
    splash =
        json['splash'] != null ? new Splash.fromJson(json['splash']) : null;
    shareData = json['share_data'] != null
        ? new ShareData.fromJson(json['share_data'])
        : null;
    thirdPartyData = json['third_party_data'] != null
        ? new ThirdPartyData.fromJson(json['third_party_data'])
        : null;

    if (json['show_mod'] != null) {
      list = new List<Mod>();
      json['show_mod'].forEach((v) {
        list.add(new Mod.fromJson(v));
      });
    }
    popupAd =
        json['popupads'] != null ? PopupAd.fromJson(json['popupads']) : null;
    clientLangUrl = json['client_lang_url'];
  }
}

class PopupAd {
  int gameId;
  String img;
  String url;
  String objectType;

  PopupAd.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    img = json['img'];
    url = json['url'];
    objectType = json['object_type'];
  }
}
