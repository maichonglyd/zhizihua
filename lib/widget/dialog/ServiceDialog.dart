import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/model/deal/deal_goods.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart' hide Image;

class ServiceDialog extends StatefulWidget {
  List<Ser> sers;

  ServiceDialog(this.sers);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceState(sers);
  }
}

class ServiceState extends State<ServiceDialog> {
  List<Ser> sers;

  ServiceState(this.sers);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  getText(name: 'textWholeService'),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.colors.themeColor),
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "images/shenqingfanli_tijiaoshenqing.png",
                    height: 17,
                    width: 17,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: RefreshHelper().getEasyRefresh(
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.8,
                    children: sers.map((ser) => buildItem(ser)).toList(),
                  ),
                  controller: RefreshHelperController()))
        ],
      ),
    );
  }

  Widget buildItem(Ser ser) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppTheme.colors.lineColor,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            ser.serverName,
            maxLines: 1,
            style: TextStyle(fontSize: 12, color: AppTheme.colors.textColor),
          ),
          Text(
            AppUtil.formatDate2(ser.startTime),
            maxLines: 1,
            style: TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor),
          )
        ],
      ),
    );
  }
}
