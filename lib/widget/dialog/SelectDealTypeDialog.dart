import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_account_list_data.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

class SelectDealTypeDialog extends StatefulWidget {
  List<String> types;
  Function(String account, int i) select;

  SelectDealTypeDialog(this.types, this.select);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SelectDealTypeState(types, select);
  }
}

class SelectDealTypeState extends State<SelectDealTypeDialog> {
  int index = -1;
  List<String> types;
  Function(String account, int i) select;

  SelectDealTypeState(this.types, this.select);

  @override
  Widget build(BuildContext context) {
    List<Widget> views = List();
    for (int i = 0; i < types.length; ++i) {
      views.add(Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              select(types[i], i);
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: 54,
              child: Text(
                types[i],
                style:
                    TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppTheme.colors.lineColor,
          )
        ],
      ));
    }
    views.add(SplitLine());
    views.add(InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        child: Text(
          getText(name: 'textCancel'),
          style: TextStyle(fontSize: 15, color: AppTheme.colors.textSubColor),
        ),
      ),
    ));
    return new Material(
      color: Colors.white,
      child: Container(
        height: 229,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: views,
        ),
      ),
    );
  }
}
