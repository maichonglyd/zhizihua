import 'dart:convert';

import 'package:tobias/tobias.dart' as tobias;
//import 'package:fake_wechat/fake_wechat.dart';

abstract class IPay {
  Future startPay(String token);
}

class WxPayImpl extends IPay {
  @override
  Future<void> startPay(String token) {
    var wxinfo = json.decode(token);
    // Wechat _wechat = Wechat()..registerApp(appId: wxinfo["appid"]);
    //     return _wechat.pay(
    //     appId: wxinfo["appid"],
    //     partnerId: wxinfo["partnerid"],
    //     prepayId: wxinfo["prepayid"],
    //     package: wxinfo["package"],
    //     nonceStr: wxinfo['noncestr'],
    //     timeStamp: wxinfo['timestamp'].toString(),
    //     sign: wxinfo['sign']);

//    registerWxApi(appId: wxinfo["appid"],universalLink: "https://your.univerallink.com/link/");
//    print("appid${wxinfo["appid"]}");
//    payWithWeChat(
//      appId: wxinfo['appid'],
//      partnerId: wxinfo['partnerid'],
//      prepayId: wxinfo['prepayid'],
//      packageValue: wxinfo['package'],
//      nonceStr: wxinfo['noncestr'],
//      timeStamp: wxinfo['timestamp'],
//      sign: wxinfo['sign'],
//    );


//    return fluwx
//        .pay(
//        appId: wxinfo["appid"],
//        partnerId: wxinfo["partnerid"],
//        prepayId: wxinfo["prepayid"],
//        packageValue: wxinfo["package"],
//        nonceStr: wxinfo['noncestr'],
//        timeStamp: wxinfo['timestamp'],
//        sign: wxinfo['sign']);
  }
}

class AliPayImpl extends IPay {
  @override
  Future startPay(String token) {
    // TODO: implement startPay
    return tobias.pay(token);
  }
}
