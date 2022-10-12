import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/generated/theme/colors.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

///购买记录
class VipRecordDialog extends StatefulWidget {
  List<RecordMod> recordList;
  Function() ok;

  VipRecordDialog(this.recordList, this.ok);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogContentState(recordList, ok);
  }
}

class DialogContentState extends State<VipRecordDialog> {
  List<RecordMod> recordList;
  int selectIndex = 0;
  Function() ok;

  DialogContentState(this.recordList, this.ok);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets +
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
            duration: Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 305,
                    padding: EdgeInsets.only(top: 14, bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      getText(name: 'textBuyCardHistory'),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.colors.textSubColor),
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Image.asset(
                                      "images/ic_off_white.png",
                                      width: 15,
                                      height: 15,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          color: Color(0xffF8F8F8),
                          height: 40,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    getText(name: 'textTime'),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.colors.textSubColor2),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    getText(name: 'textBuyCardType'),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.colors.textSubColor2),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    getText(name: 'textPayWay'),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppTheme.colors.textSubColor2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        recordList != null && recordList.length > 0
                            ? Container(
                                height: 180,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: recordList
                                      .map((record) => buildItem(record))
                                      .toList(),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Widget buildItem(RecordMod recordMod) {
    // 1日卡 2周卡 3月卡 4季卡 5年卡
    String typeName;
    switch (recordMod.vipType) {
      case 1:
        typeName = getText(name: 'textDayCard');
        break;
      case 2:
        typeName = getText(name: 'textWeekCard');
        break;
      case 3:
        typeName = getText(name: 'textMonthCard');
        break;
      case 4:
        typeName = getText(name: 'textSeasonCard');
        break;
      case 5:
        typeName = getText(name: 'textYearCard');
        break;
    }
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 40,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${AppUtil.formatDate1(recordMod.payTime)}",
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.colors.textSubColor2),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "$typeName",
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.colors.textSubColor2),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "${recordMod.paywayName}",
                    style: TextStyle(
                        fontSize: 13, color: AppTheme.colors.textSubColor2),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        )
      ],
    );
  }
}
