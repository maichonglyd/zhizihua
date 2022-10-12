import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class RecruitServiceDialog extends StatefulWidget {
  String phone;
  String qq;
  String weChat;

  RecruitServiceDialog({
    Key key,
    this.phone,
    this.qq,
    this.weChat,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RecruitServiceState();
  }
}

class RecruitServiceState extends State<RecruitServiceDialog> {
  RecruitServiceState();

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 290,
            height: 310,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 210,
                  height: 118,
                  margin: EdgeInsets.only(top: 24),
                  child: Image.asset("images/pic_recruit_service_bg.png"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 18, right: 18, top: 5),
                  child: Text(
                    "我们将会全心全意为您提供满意周到的咨询服务，也希望您能支持和监督我们的服务",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppTheme.colors.textSubColor, fontSize: 11),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _clickAction('tel:' + widget.phone);
                  },
                  child: Container(
                    height: 37,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFFFC200),
                            Color(0xFFFF9000),
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          margin: EdgeInsets.only(right: 6),
                          child: Image.asset(
                            "images/icon_phone_white.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          getText(name: 'textCallServicePhone'),
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _clickAction("mqq://im/chat?chat_type=wpa&uin=${widget.qq}&version=1&src_type=web");
                        },
                        child: Container(
                          width: 122,
                          height: 37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: AppTheme.colors.textSubColor, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                margin: EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "images/icon_qq_grey.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                getText(name: 'textQQService'),
                                style: TextStyle(
                                    color: AppTheme.colors.textSubColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          AppUtil.copyToClipboard(widget.weChat);
                          showToast(getText(name: 'textHasCopyServicePhone'));
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 122,
                          height: 37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: AppTheme.colors.textSubColor, width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                margin: EdgeInsets.only(right: 5),
                                child: Image.asset(
                                  "images/icon_wechat_grey.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                getText(name: 'textWeChatService'),
                                style: TextStyle(
                                    color: AppTheme.colors.textSubColor,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 27,
              height: 27,
              margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                "images/ic_off.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _clickAction(String url) {
    if (null != url && url.isNotEmpty) {
      launch(url);
      Navigator.of(context).pop();
    }
  }
}
