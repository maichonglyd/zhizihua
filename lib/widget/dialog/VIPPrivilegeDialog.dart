import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:oktoast/oktoast.dart';

class VIPPrivilegeDialog extends StatefulWidget {
//  String code;
  int type;

  VIPPrivilegeDialog(this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState();
  }
}

class DialogContentState extends State<VIPPrivilegeDialog> {
//  String code;
//  DialogContentState(this.code);

  String imageUrl = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 0:
        {
          //会员标识
          imageUrl = "images/vip_pic_vipbs.png";
          break;
        }
      case 1:
        {
          //靓号昵称
          imageUrl = "images/vip_pic_name.png";
          break;
        }
      case 2:
        {
          // 签到加成
          imageUrl = "images/vip_pic_sign.png";
          break;
        }
      case 3:
        {
          //会员任务
          imageUrl = "images/vip_pic_task.png";
        }
    }
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
          //保证控件居中效果
          child: Container(
              width: 280,
              height: 310,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 280,
                    height: 230,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(imageUrl))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("images/ic_off.png"),
                    ),
                  )
                ],
              ))),
    );
  }
}
