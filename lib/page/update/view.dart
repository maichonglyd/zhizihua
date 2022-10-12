import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/plugin/download_sign/download_sign_manager.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    UpdatePageState state, Dispatch dispatch, ViewService viewService) {
  String statusText = getText(name: 'textToDownload');
  switch (state.status) {
    case DownloadStatus.INITIAL:
      statusText = getText(name: 'textToDownload');
      break;
    case DownloadStatus.DOWNLOADING:
      statusText = "${state.curProgress.toStringAsFixed(1)} %";
      break;
    case DownloadStatus.PAUSE:
      statusText = getText(name: 'textContinue');
      break;
    case DownloadStatus.INSTALL:
      statusText = getText(name: 'textInstall');
      break;
    case DownloadStatus.OPEN:
      statusText = getText(name: 'textOpen');
      break;
    case DownloadStatus.RETRY:
      statusText = getText(name: 'textRetry');
      break;
    case DownloadStatus.REQUEST:
      statusText = getText(name: 'textDownloadRequest');
      break;
  }
  return AnimatedPadding(
      padding: MediaQuery.of(viewService.context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: viewService.context,
        child: Center(
            child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 126),
              width: 271,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 49),
                    child: Text(
                      getText(name: 'textUpdateVersion') +
                              state.upInfo.version ??
                          "",
                      maxLines: 1,
                      style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: 17,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 19, left: 17, right: 17),
                    child: Text(
                      state.upInfo.content,
                      maxLines: 3,
                      style: TextStyle(
                          color: AppTheme.colors.textSubColor,
                          fontSize: 13,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (state.upInfo.upStatus == 2)
                        GestureDetector(
                          onTap: () {
                            if (Platform.isIOS) {
                              DownloadSignManager.deleteDownSignTaskByAppid(
                                  int.parse(AppConfig.iosAppid));
                            }
                            Navigator.pop(viewService.context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 25, bottom: 18),
                            height: 41,
                            width: 111,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21)),
                                border: Border.all(color: Color(0xffd8d8d8))),
                            child: Text(
                              getText(name: 'textCancel'),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.colors.textSubColor2,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          if (DownloadStatus.REQUEST != state.status) {
                            dispatch(UpdatePageActionCreator.onClick());
                          }
                          if (DownloadStatus.INITIAL == state.status) {
                            dispatch(UpdatePageActionCreator.updateStatus(
                                DownloadStatus.REQUEST, 0));
                          }
                        },
                        child: Container(
                          height: 41,
                          width: 111,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 25, bottom: 18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                            color: AppTheme.colors.themeColor,
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              "images/pic_n_Toupdate.png",
              height: 156,
              width: 271,
            ),
          ],
        )),
      ));
}
