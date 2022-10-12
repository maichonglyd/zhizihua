import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/huo_dio_interceptor.dart';
import 'package:flutter_huoshu_app/api/loading_dialog/action.dart';
import 'package:flutter_huoshu_app/api/loading_dialog/page.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/global_store/store.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:oktoast/oktoast.dart';

import 'user_service.dart';

class CommonDio<T> {
  static Dio mDio;
  static Dio mGetDio;
  static Dio muploadDio;
  static final bool isProxy = false;
  static final String proxyIP = "192.168.1.3:8888";

  static const int SUCCESS_CODE = 200;
  static const int TOKEN_INVALID_CODE = 1002;
  static const int GOODS_NOT_EXIST = 46107;

  static Dio get dio {
    // 或者通过传递一个 `BaseOptions`来创建dio实例
    BaseOptions options = new BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        contentType: "application/x-www-form-urlencoded",
        headers: RequestUtil.getCommonHeader());

    mDio ??= new Dio(options)
      ..interceptors.add(HuoDioInterceptor())
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    if (isProxy) {
      (mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // config the http client
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return "PROXY $proxyIP"; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
        };
        // you can also create a HttpClient to dio
        // return HttpClient();
      };
    }
    return mDio;
  }

  static Dio get getReqDio {
    // 或者通过传递一个 `BaseOptions`来创建dio实例
    BaseOptions options = new BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        contentType: "application/x-www-form-urlencoded",
        headers: RequestUtil.getCommonHeader());

    mGetDio ??= new Dio(options)
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return mGetDio;
  }

  static Dio getTimeDio(int connectTimeout, int receiveTimeout) {
    // 或者通过传递一个 `BaseOptions`来创建dio实例
    BaseOptions options = new BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: "application/x-www-form-urlencoded");
    return new Dio(options)
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  static Dio getDio(int connectTimeout, int receiveTimeout) {
    // 或者通过传递一个 `BaseOptions`来创建dio实例
    BaseOptions options = new BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: "application/x-www-form-urlencoded",
        headers: RequestUtil.getCommonHeader());
    return new Dio(options)
      ..interceptors.add(HuoDioInterceptor())
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

//  static Dio get chatDio {
//    // 或者通过传递一个 `BaseOptions`来创建dio实例
//    BaseOptions options = new BaseOptions(
//        baseUrl: AppConfig.chatBaseUrl,
//        connectTimeout: 30000,
//        receiveTimeout: 30000,
//        contentType: ContentType.parse("application/x-www-form-urlencoded"),
//        headers: RequestUtil.getCommonHeader());
//    return chatTestDio ??= new Dio(options)
//      ..interceptors.add(HuoDioInterceptor())
//      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
//  }

  static Dio get uploadDio {
    // 或者通过传递一个 `BaseOptions`来创建dio实例
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: "application/x-www-form-urlencoded",
    );

    return muploadDio ??= new Dio(options)
      ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  static Future get(String path,
      {data,
      Context ctx,
      bool gotoLogin = true,
      bool isShowDialog = false,
      bool isShowError = true,
      bool isShowToast = true,
      int connectTimeout = null,
      int receiveTimeout = null}) async {
    Response<String> response;
    // dialog
    if (isShowDialog && ctx != null) {
      //显示菊花
//      AppUtil.gotoPageByName(ctx.context, LoadingDialogPage.pageName);
      showDialog(
          context: ctx.context,
          builder: (context) {
            return new WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: new LoadingDialogPage().buildPage(null),
            );
          },
          barrierDismissible: false);
    }
    try {
      var dio;
      if (connectTimeout == null || receiveTimeout == null) {
        dio = CommonDio.getReqDio;
      } else {
        dio = CommonDio.getTimeDio(connectTimeout, receiveTimeout);
      }
      HuoLog.d("data=${data}");
      if (data != null) {
        response = await dio.get<String>(path, queryParameters: data);
      } else {
        response = await dio.get<String>(path);
      }
    } on DioError catch (e) {
      // toast  请求错误
      print("连接失败，请检查网络是否连接正常！");
      print(e);
      return BaseModel(-1, "连接失败，请检查网络是否连接正常！", null).toJson();
    } finally {
      if (isShowDialog && ctx != null) {
        Navigator.pop(ctx.context);
      }
    }
    if (response != null && response.statusCode > 400) {
      print(response.statusMessage);
      showToast("服务器忙，请稍后再试！");
      return BaseModel(response.statusCode, "服务器忙，请稍后再试！", null).toJson();
    }
    if (response != null) {
      dynamic jsonData = json.decode(response.data);
      //数据过滤
      int code = jsonData['code'];
      String msg = jsonData['msg'];

      if (code != SUCCESS_CODE && code != TOKEN_INVALID_CODE) {
        if (isShowError) {
          showToast(msg);
        }
      }
      if (code == TOKEN_INVALID_CODE) {
        //        登陆过期
        LoginControl.saveLogin(false);
        UserService.logout().then((data) {});
        if (ctx != null) {
          ctx.broadcast(
              HomeActionCreator.onLoginInvalid(isShowToast, gotoLogin));
        }
      }
      return jsonData;
    }
  }

  static Future post(String path,
      {data,
      Context ctx,
      bool gotoLogin = true,
      bool isShowDialog = false,
      bool isShowError = true,
      bool isShowToast = true,
      int connectTimeout = null,
      int receiveTimeout = null}) async {
    Response<String> response;
    // dialog
    if (isShowDialog && ctx != null) {
      //显示菊花
//      AppUtil.gotoPageByName(ctx.context, LoadingDialogPage.pageName);
      showDialog(
          context: ctx.context,
          builder: (context) {
            return new WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: new LoadingDialogPage().buildPage(null),
            );
          },
          barrierDismissible: false);
    }
    try {
      var dio;
      if (connectTimeout == null || receiveTimeout == null) {
        dio = CommonDio.dio;
      } else {
        dio = CommonDio.getDio(connectTimeout, receiveTimeout);
      }
      HuoLog.d("data=${data}");
      if (data != null) {
        response = await dio.post<String>(path, data: data);
      } else {
        response = await dio.post<String>(path);
      }
    } on DioError catch (e) {
      // toast  请求错误
      print("连接失败，请检查网络是否连接正常！");
      print(e);
      return BaseModel(-1, "连接失败，请检查网络是否连接正常！", null).toJson();
    } finally {
      if (isShowDialog && ctx != null) {
        Navigator.pop(ctx.context);
      }
    }
    if (response != null && response.statusCode > 400) {
      print(response.statusMessage);
      showToast("服务器忙，请稍后再试！");
      return BaseModel(response.statusCode, "服务器忙，请稍后再试！", null).toJson();
    }
    if (response != null) {
      dynamic jsonData = json.decode(response.data);
      //数据过滤
      int code = jsonData['code'];
      String msg = jsonData['msg'];

      if (code != SUCCESS_CODE && code != TOKEN_INVALID_CODE) {
        if (isShowError) {
          showToast(msg);
        }
      }
      if (code == TOKEN_INVALID_CODE) {
        //        登陆过期
        LoginControl.saveLogin(false);
        if (ctx != null) {
          ctx.broadcast(
              HomeActionCreator.onLoginInvalid(isShowToast, gotoLogin));
        }
      }
      return jsonData;
    }
  }

  static Future<ImageUploadInfo> upload(File file) async {
    String path = file.path;
    String fileName = path.substring(path.lastIndexOf('/') + 1, path.length);
    print("fileName:" + fileName);
    FormData formData = new FormData.fromMap({
      "filetype": "image",
      "app": "agent",
      "id": uuid(),
      "file": await MultipartFile.fromFile(path, filename: fileName),
    });
    var response =
        await CommonDio.uploadDio.post("app/asset/upload", data: formData);
//    dynamic jsonData = json.decode();
    return ImageUploadInfo.fromJson(response.data);
  }

  //下载文件
  static Future downloadFile(String downUrl, String saveUrl) async {
    Dio dio = Dio();
    //设置连接超时时间
    dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    dio.options.receiveTimeout = 10000;
    Response response = await dio.download(downUrl, saveUrl);
    if (response.statusCode == 200) {
      print('下载请求成功');
    }
  }

  static Future uploadImageFiles(List<ImageUploadData> files) async {
    List<Future<ImageUploadInfo>> uploads = List();
    for (ImageUploadData fileData in files) {
      //是本地文件才上传
      if (fileData.isLocalFile) {
        uploads.add(upload(fileData.file));
      } else {
        uploads.add(Future.value(ImageUploadInfo.withSuccessData(fileData)));
      }
    }
    return Future.wait(uploads);
  }

  static Future uploadFiles(List<File> files) async {
    List<Future<ImageUploadInfo>> uploads = List();
    for (File file in files) {
      uploads.add(upload(file));
    }
    return Future.wait(uploads);
  }

  static String uuid() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }
}
