import 'dart:io';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';

//import 'package:drifter/drifter.dart';
import 'package:flutter_plugin_user_agent_auth/flutter_plugin_user_agent_auth.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceInfoUtil {
  static DeviceBean deviceBean;
  static HuoInitInfo huoInitInfo;
  static String iosSubCh = "";
  static String webViewUserAgent = "";

  static DeviceBean getDeviceData() {
    if (deviceBean != null) {
      return deviceBean;
    }
    return new DeviceBean();
  }

  static HuoInitInfo getHuoInitInfo() {
    if (huoInitInfo != null) {
      return huoInitInfo;
    }
    return new HuoInitInfo();
  }

  static Future<DeviceBean> initPlatformState() async {
    print("DeviceInfoPlugin");
    try {
      if (Platform.isAndroid) {
        //申请权限
        // applyPermission();
        print("isAndroid");
        deviceBean = await FlutterPluginUserAgentAuth.getDeviceInfo;

        String oaid = await FlutterPluginUserAgentAuth.getOaid;
        print("获取oaid" + oaid);
        deviceBean.oaid = oaid;
      } else if (Platform.isIOS) {
        print("isIOS");
        deviceBean = await FlutterPluginUserAgentAuth.getDeviceInfo;
        updateSubCh();
      }
    } on Exception {
      deviceBean = DeviceBean();
    }
    return new Future(() => deviceBean);
  }

  static Future<void> applyPermission() async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions(
              [PermissionGroup.storage, PermissionGroup.phone]);
      deviceBean = await FlutterPluginUserAgentAuth.getDeviceInfo;
    }
    return Future.value(null);
  }

  static updateSubCh() {
    //ios端
    //从info.plist读，如果有直接用并且存入本地，如果没有则读本地的，如果本地没有读剪切板的
    if (Platform.isIOS) {
      SpUtil.getSP().then((sp) {
        if(deviceBean.hs_agent.isNotEmpty){
          iosSubCh=deviceBean.hs_agent;
          sp.setString("sp_key_sub_ch", iosSubCh);
        }else{
          String spSubCh = sp.getString("sp_key_sub_ch");
          if (spSubCh == null || spSubCh.isNotEmpty) {
            AppUtil.getClipboardContent().then((content) {
              if (content != null && content.isNotEmpty && content.contains("hy") && content.length <= 32) {
                iosSubCh = content;
                sp.setString("sp_key_sub_ch", content);
              }
            });
          } else {
            iosSubCh = spSubCh;
          }
        }
      });
    }
  }
}
