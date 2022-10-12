import 'package:dio/dio.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';

class HuoDioInterceptor extends Interceptor {
  InterceptorSuccessCallback _onResponse;
  InterceptorErrorCallback _onError;

  HuoDioInterceptor({
    InterceptorSuccessCallback onResponse,
    InterceptorErrorCallback onError,
  })  : _onResponse = onResponse,
        _onError = onError;

  @override
  onRequest(RequestOptions options) async{
    Map newData = Map<String, dynamic>();
    if (options.data != null) {
      newData = Map<String, dynamic>.from(options.data);
    }
    newData.addAll(RequestUtil.getCommonData());
    //todo sign添加 by liuhongliang
    newData.addAll(RequestUtil.getSign(options.method, options.path, newData));
    options.data = newData;
    return options;
  }


  @override
  onResponse(Response response) async{
    if (_onResponse != null) {
      return _onResponse(response);
    }
    return response;
  }

  @override
  onError(DioError err) async{
    if (_onError != null) {
      return _onError(err);
    }
    print("==============DioError:" + err.toString());
  }
}
