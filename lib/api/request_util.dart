import 'dart:convert';
import 'dart:io';

import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import '../app_config.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class RequestUtil {
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  //========================IOS=============================
  //agentgame = "(null)";
  //"app_id" = 101;
  //"client_id" = 1;
  //device =     {
  //"device_id" = 95158f07579ef3f0ffe447a50e1d22dee47c578a;
  //deviceinfo = "x86_64||12.0||5||en";
  //idfa = "F7A81CF9-66DE-4DA8-98DE-153865D51D94";
  //idfv = "69E25DD4-E07F-4B97-99C9-CBCBAAD90BA8";
  //ipaddrid = "";
  //"local_ip" = "192.168.1.80";
  //mac = "38:F9:D3:0C:06:BE";
  //userua = "Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16A366";
  //};
  //"device_id" = 95158f07579ef3f0ffe447a50e1d22dee47c578a;
  //from = 4;
  //timestamp = 1565667206;
  //verid = 1;
  //version = "1.0";
  //========================Android=============================
  //device-brand	Netease
  //device-device_id	XM6h5ZdI+wEDAFM+TKSd6Ogt
  //device-disk_space	1947570176-1470705664
  //device-has_sim	1
  //device-imsi
  //device-ip	10.0.3.15
  //device-is_break	1
  //device-is_charge	1
  //device-latitude
  //device-longitude
  //device-mac	02:00:00:00:00:00
  //device-model	MuMu
  //device-net	WIFI
  //device-open_time	66
  //device-os	android
  //device-os_version	Android6.0.1
  //device-screen	810*1440
  //device-screen_luminance	102
  //device-userua
  //获取设备参数，要判断iso/android
  static Map<String, dynamic> getDeviceData() {
    Map<String, dynamic> devices = {
      'device-brand': DeviceInfoUtil.getDeviceData().brand,
      'device-device_id': DeviceInfoUtil.getDeviceData().device_id,
      'device-disk_space': DeviceInfoUtil.getDeviceData().disk_space,
      'device-has_sim': DeviceInfoUtil.getDeviceData().has_sim,
      'device-imsi': DeviceInfoUtil.getDeviceData().imsi,
      'device-ip': DeviceInfoUtil.getDeviceData().ip,
      'device-model': DeviceInfoUtil.getDeviceData().model,
      'device-os': DeviceInfoUtil.getDeviceData().os,
      'device-os_version': DeviceInfoUtil.getDeviceData().os_version,
      'device-is_break': DeviceInfoUtil.getDeviceData().is_break,
      'device-device-is_charge': DeviceInfoUtil.getDeviceData().is_charge,
      'device-mac': DeviceInfoUtil.getDeviceData().mac,
      'device-net': DeviceInfoUtil.getDeviceData().net,
      'device-screen': DeviceInfoUtil.getDeviceData().screen,
      'device-oaid': DeviceInfoUtil.getDeviceData().oaid,
      'device-screen_luminance': "0",
    };
    return devices;
  }

  static Map<String, dynamic> getAgentData() {
    Map<String, dynamic> agent = {
      "agent-ch": "", //	是	STRING(32)	渠道编号	聚合为 详见 渠道SDK编号 运营平台为agent_id
      "agent-sub_ch": Platform.isIOS
          ? DeviceInfoUtil.iosSubCh
          : DeviceInfoUtil.getHuoInitInfo()
              .hs_agent, //		是	STRING(32)	子渠道编号	平台子渠道编号 默认为空串 运营平台对应agent_game
    };
    print("调用了获取agent：" + DeviceInfoUtil.getHuoInitInfo().hs_agent);
    return agent;
  }

  static Map<String, dynamic> getGameData() {
    Map<String, dynamic> game = {
      "game-pkg_name": "", //	是	STRING(32)	游戏包名	默认为空字符串 例如 com.huosdk.app
      "game-app_ver": "", //	是	STRING(32)	游戏版本号	默认为空字符串 例如 1.3.1
      "game-h_ver": "", //	是	STRING(32)	聚合SDK版本编号	聚合SDK版本号
      "game-sdk_ver": "", //	是	STRING(32)	客户端渠道SDK版本编号	客户端渠道SDK版本ID
    };
    return game;
  }

  //agent-ch	ZKM_20
  //agent-sub_ch	hy000100100009k3
  //app_id	100
  //client_id	120
  //format	json
  //game-app_ver	2.0.0.1
  //game-h_ver	120
  //game-pkg_name	com.zkouyu.app
  //game-sdk_ver
  //open_cnt	1
  //sign	c9cdd22dc5b6b48ac022ef38c3b992fd
  //token	a90509eaff26cf3baf8142a64c39d678
  //ts	1565665098281
  static Map<String, dynamic> getCommonData({String from}) {
    if (from == null || from.isEmpty) {
      from = "json";
    }
    Map<String, dynamic> common = {
      'ts': currentTimeMillis(),
      'app_id': Platform.isAndroid?AppConfig.appid:AppConfig.iosAppid,
//            'app_id': AppConfig.appid,
//      'app_id': AppConfig.iosAppid,
      'client_id': AppConfig.client_id,
      'format': from,
//      'sign': "xxxx",
      'token': LoginControl.getToken()
    };
    common.addAll(getDeviceData());
    common.addAll(getGameData());
    common.addAll(getAgentData());
    return common;
  }

  ///根据参数获取签名
  static Map<String, dynamic> getSign(
      String mothed, String api, Map<String, dynamic> paramMap) {
    String sign = mothed + "&" + api.substring(0);

    String param = "";
    paramMap.forEach((key, value) {
      param += "$key=$value&";
    });
    param = param.substring(0, param.length - 1);

    sign = "$sign&$param&${AppConfig.client_key}&${AppConfig.rsa_public_key}";

    Map<String, dynamic> signMap = {
      'sign': generateMd5(sign),
    };

    print("sign原串：$sign");

    return signMap;
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  static String getCommonParams({String from}) {
    Map<String, dynamic> common = getCommonData(from: from);
    String params = "";
    common.forEach((key, val) {
      if (val == null) {
        val = "";
      }

      params += key + "=" + Uri.encodeComponent(val.toString()) + "&";
    });
    if (params.endsWith("&")) {
      params = params.substring(0, params.length - 1);
    }
    return params;
  }

  static String urlAppendCommonParams(String url) {
    if (url.contains("?")) {
      return url += "&" + getCommonParams(from: "html");
    }
    return url += "?" + getCommonParams(from: "html");
  }

  static Map<String, dynamic> getCommonHeader() {
    Map<String, dynamic> common = {
      'hs-device-type': Platform.isAndroid ? 'andapp' : "iosapp",
      'hs-token': LoginControl.getToken(),
      'hs-lang': LocaleManager.getNowLocaleString(),
    };
    return common;
  }

  ///get请求根据参数获取签名
  static String getSignForGet(Map<String, dynamic> paramMap) {
    String sign;

    String param = "";
    paramMap.forEach((key, value) {
      param += "$key=$value&";
    });
    param = param.substring(0, param.length - 1);

    sign = "&$param&${AppConfig.client_key}&${AppConfig.rsa_public_key}";

    Map<String, dynamic> signMap = {
      'sign': generateMd5(sign),
    };

    print("sign原串：$sign");

    return sign;
  }
}
