import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHelper {
  Function(int page) loadMore;
  Function() onRefresh;
  RefreshHelperController controller;
  SmartRefresher easyRefresh;

  SmartRefresher getEasyRefresh(
    Widget child, {
    Function(int page) loadMore,
    Function() onRefresh,
    RefreshHelperController controller,
    Widget emptyWidget,
    Widget netErrWidget,
    String emptyImageUrl,
  }) {
    this.loadMore = loadMore;
    this.onRefresh = onRefresh;
    this.controller = controller;
    if (emptyWidget == null) {
      emptyWidget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              emptyImageUrl != null && emptyImageUrl.isNotEmpty
                  ? emptyImageUrl
                  : "images/default_nodata.png",
              height: 180,
              width: 218,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                getText(name: 'textNoData'),
                style: TextStyle(
                    fontSize: 12, color: AppTheme.colors.textSubColor2),
              ),
            )
          ],
        ),
      );
    }

    netErrWidget = Center(
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
              getText(name: 'textDataLoadingError'),
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
                if (null != onRefresh) {
                  onRefresh();
                }
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

    SmartRefresher smartRefresher = SmartRefresher(
      enablePullDown: null != this.controller && null != onRefresh,
      enablePullUp: null != this.controller && null != loadMore,
      header: ClassicHeader(
        refreshingText: "",
        idleText: "",
        completeText: '',
        releaseText: '',
        failedText: getText(name: 'textRefreshFailAndTry'),
      ),
      footer: ClassicFooter(
        loadingText: '',
        noDataText: getText(name: 'textNoMoreData'),
        idleText: "",
        failedText: getText(name: 'textLoadFailAndTry'),
      ),
      controller: this.controller.easyRefreshController,
      onRefresh: onRefresh != null
          ? () async {
              print("RefreshHelper : onRefresh");
              onRefresh();
            }
          : null,
      onLoading: !this.controller.isEmpty && loadMore != null
          ? () async {
              print("RefreshHelper : onLoad:" +
                  this.controller.currentPage.toString());
              loadMore(this.controller.currentPage + 1); //加载下一页
            }
          : null,
      child: child,
    );
    return smartRefresher;
  }
}

class RefreshHelperController {
  //加载第一页 刷新
  //加载更多  反馈页码
  int currentPage = 0;
  int offset = 20;
  bool isEmpty = false;
  bool isNetErr = false;

  RefreshController easyRefreshController =
      RefreshController(initialRefresh: false);

  //内部控制刷新啥啥的
  List controllerRefresh(List newData, List oldData, refreshPage) {
    //首次加载
    //刷新
    //空数据
    //加载更多
    //加载完成
    //网络错误

    isEmpty = false; //数据空
    isNetErr = false; // 网络错误

    if (refreshPage == 1 && (newData == null || newData.length == 0)) {
      //空数据
      finishRefresh(success: true);
      oldData.clear();
      isEmpty = true;
    } else if (refreshPage == 1 && newData.length > 0) {
      //刷新完成
      finishRefresh(success: true, noMore: false);
      oldData.clear();
      oldData.addAll(newData);
    } else if ((newData == null || newData.length == 0) && refreshPage > 1) {
      //加载完成
      finishLoad(success: true, noMore: true);
    } else {
      finishLoad(success: true, noMore: false);
      oldData.addAll(newData);
    }
    return oldData;
  }

  //完成刷新
  void finishRefresh({
    bool success,
    bool noMore,
  }) {
    easyRefreshController.refreshCompleted();
    if (success) {
      currentPage = 1;
    }
  }

  /// 完成加载
  void finishLoad({
    bool success,
    bool noMore,
  }) {
    easyRefreshController.loadComplete();
    if (noMore) {
      easyRefreshController.loadNoData();
    }
    if (success) {
      currentPage = currentPage + 1;
    }
  }

  void setEmpty() {
    isEmpty = true;
  }

  void setNotEmpty() {
    isEmpty = false;
  }

  void setNetErr() {
    isNetErr = true;
  }
}
