import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

class NormalTipsDialog extends StatelessWidget {
  Function() cancelCallback;
  Function() confirmCallback;
  String titleText;
  String contentText;

  NormalTipsDialog({
    this.cancelCallback,
    this.confirmCallback,
    this.titleText,
    this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  titleText ?? getText(name: 'textTip'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 20),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  contentText ?? getText(name: 'textExitGame'),
                  style:
                      TextStyle(color: AppTheme.colors.textColor, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (null != cancelCallback) {
                          Navigator.pop(context); // 退出弹窗
                          cancelCallback();
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 111,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(21)),
                          border: Border.all(
                            color: AppTheme.colors.textSubColor3,
                          ),
                        ),
                        child: Text(
                          getText(name: 'textCancel'),
                          style: TextStyle(fontSize: 16, color: AppTheme.colors.textSubColor),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (null != confirmCallback) {
                          Navigator.pop(context); // 退出弹窗
                          confirmCallback();
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 111,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.themeColor,
                          borderRadius: BorderRadius.all(Radius.circular(21)),
                        ),
                        child: Text(
                          getText(name: 'textConfirm'),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, Color textColor, Function() action) {
    return GestureDetector(
      onTap: () {
        if (null != action) {
          Navigator.pop(context); // 退出弹窗
          action();
        }
      },
      child: Container(
        height: 42,
        width: 111,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(21)),
          border: Border.all(
            color: AppTheme.colors.textSubColor3,
          ),
        ),
        child: Text(
          text ?? '',
          style: TextStyle(fontSize: 16, color: AppTheme.colors.textSubColor),
        ),
      ),
    );
  }
}
