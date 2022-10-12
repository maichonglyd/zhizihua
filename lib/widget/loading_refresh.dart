import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

ViewMiddleware<T> loadingRefreshViewMiddleware<T>(Action action,
    {Widget Function(dynamic, StackTrace,
            {AbstractComponent<dynamic> component, Store<T> store})
        onError}) {
  return (AbstractComponent<dynamic> component, Store<T> store) {
    return (ViewBuilder<dynamic> next) {
      return (dynamic state, Dispatch dispatch, ViewService viewService) {
        //判断状态 LoadStatus
        if (state is T) {
          BaseState baseState = state as BaseState;
          return buildLoadingRefreshWidget(
              baseState.loadStatus, next, state, dispatch, viewService, action);
        } else {
          return next(state, dispatch, viewService);
        }
      };
    };
  };
}

Widget buildLoadingRefreshWidget(LoadStatus status, ViewBuilder<dynamic> next,
    dynamic state, Dispatch dispatch, ViewService viewService, Action action) {
  Widget loadView;

  Widget errWidget = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "images/default_nodata2.png",
          height: 180,
          width: 218,
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Text(
            getText(name: 'textNetworkProblem'),
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
          ),
        ),
        Container(
          height: 30,
          width: 92,
          margin: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: AppTheme.colors.themeColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: MaterialButton(
            onPressed: () {
              dispatch(action);
            },
            child: Text(
              getText(name: 'textRefresh'),
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        )
      ],
    ),
  );

  switch (status) {
    case LoadStatus.loading:
      loadView = Center(
        child: CircularProgressIndicator(),
      );
      break;
    case LoadStatus.error:
      loadView = errWidget;
      break;
    case LoadStatus.netOff:
      loadView = errWidget;
      break;
    case LoadStatus.success:
      try {
        return next(state, dispatch, viewService);
      } catch (e, stackTrace) {
        HuoLog.e("加载失败了${e} ${stackTrace}");
        return errWidget;
      }
      break;
  }
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    ),
    body: loadView,
  );
}

enum LoadStatus { loading, error, netOff, success }

Widget wrapLoadingRefreshWidget(LoadStatus status, ViewBuilder<dynamic> next,
    dynamic state, Dispatch dispatch, ViewService viewService, Action action) {}
